from django import forms


class RejectionReasonForm(forms.Form):
    """Form for admin to provide a rejection reason when rejecting documents."""

    rejection_reason = forms.CharField(
        label="Reason for rejection",
        widget=forms.Textarea(attrs={"rows": 4, "cols": 60, "placeholder": "Explain why the document was rejected..."}),
        required=True,
        max_length=500,
        help_text="This reason will be shared with the user via notification.",
    )
