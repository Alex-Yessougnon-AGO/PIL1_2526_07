from django.contrib import admin
from django.shortcuts import render
from django.utils.html import format_html

from apps.onboarding.forms import RejectionReasonForm
from apps.onboarding.models import VerificationDocument
from apps.onboarding.tasks import notify_verification_approved, notify_verification_rejected


@admin.register(VerificationDocument)
class VerificationDocumentAdmin(admin.ModelAdmin):
    list_display = ("user_email", "file_link", "status_colored", "reviewed_by", "created_at", "updated_at")
    list_filter = ("status", "created_at")
    search_fields = ("user__email", "user__first_name", "user__last_name")
    readonly_fields = ("id", "created_at", "updated_at", "file_link")
    actions = ("approve_documents", "reject_documents")
    date_hierarchy = "created_at"

    fieldsets = (
        (None, {"fields": ("id", "user", "file_link", "status")}),
        ("Review", {"fields": ("rejection_reason", "reviewed_by")}),
        ("Timestamps", {"fields": ("created_at", "updated_at")}),
    )

    def user_email(self, obj):
        return obj.user.email
    user_email.short_description = "User"
    user_email.admin_order_field = "user__email"

    def file_link(self, obj):
        if obj.file:
            return format_html('<a href="{}" target="_blank">View file</a>', obj.file.url)
        return "-"
    file_link.short_description = "Document"

    def status_colored(self, obj):
        colors = {
            "PENDING": "orange",
            "APPROVED": "green",
            "REJECTED": "red",
        }
        color = colors.get(obj.status, "gray")
        return format_html('<span style="color: {}; font-weight: bold;">{}</span>', color, obj.get_status_display())
    status_colored.short_description = "Status"

    def save_model(self, request, obj, form, change):
        """Auto-set reviewed_by when status changes."""
        if change and "status" in form.changed_data:
            obj.reviewed_by = request.user

            if obj.status == "APPROVED":
                self._notify_approved(request, obj)
            elif obj.status == "REJECTED":
                self._notify_rejected(request, obj)

        super().save_model(request, obj, form, change)

    def _notify_approved(self, request, doc):
        """Send approval notification and mark user as verified."""
        notify_verification_approved.delay(
            user_id=str(doc.user_id),
            user_email=doc.user.email,
        )
        doc.user.is_verified = True
        doc.user.save(update_fields=["is_verified"])

    def _notify_rejected(self, request, doc):
        """Send rejection notification."""
        notify_verification_rejected.delay(
            user_id=str(doc.user_id),
            user_email=doc.user.email,
            reason=doc.rejection_reason,
        )

    @admin.action(description="Approve selected documents")
    def approve_documents(self, request, queryset):
        updated = 0
        for doc in queryset.filter(status="PENDING"):
            doc.status = "APPROVED"
            doc.reviewed_by = request.user
            doc.save(update_fields=["status", "reviewed_by", "updated_at"])
            self._notify_approved(request, doc)
            updated += 1

        self.message_user(request, f"{updated} document(s) approved.")

    @admin.action(description="Reject selected documents")
    def reject_documents(self, request, queryset):
        """Admin action with intermediate page for custom rejection reason."""
        # Step 2: Form was submitted — process rejection
        if "apply_rejection" in request.POST:
            form = RejectionReasonForm(request.POST)
            if form.is_valid():
                reason = form.cleaned_data["rejection_reason"]
                updated = 0
                for doc in queryset.filter(status="PENDING"):
                    doc.status = "REJECTED"
                    doc.reviewed_by = request.user
                    doc.rejection_reason = reason
                    doc.save(update_fields=["status", "reviewed_by", "rejection_reason", "updated_at"])
                    self._notify_rejected(request, doc)
                    updated += 1

                self.message_user(request, f"{updated} document(s) rejected.")
                return None  # Return to change list

        # Step 1: Show intermediate page with the form
        form = RejectionReasonForm()
        doc_count = queryset.filter(status="PENDING").count()

        return render(
            request,
            "admin/onboarding/verificationdocument/reject_intermediate.html",
            {
                "title": "Reject verification documents",
                "documents": queryset.filter(status="PENDING"),
                "doc_count": doc_count,
                "form": form,
                "action": "reject_documents",
                "action_checkbox_name": admin.ACTION_CHECKBOX_NAME,
                "selected_ids": queryset.values_list("id", flat=True),
                "opts": self.model._meta,
                "media": self.media,
            },
        )
