document.addEventListener('DOMContentLoaded', () => {
	initBadgeInteractions();
});

/**
 * Handles toggling interaction for both strength and need badges based on parent containers
 */
function initBadgeInteractions() {
	document.querySelectorAll('.skill-badge').forEach(badge => {
		badge.addEventListener('click', function() {
			// Prevent interference with structural control buttons (like "+ Add Subject")
			if (this.innerText.includes('+')) return;

			const isStrengthContainer = this.closest('#strengths-group') !== null;

			if (isStrengthContainer) {
				const isSelected = this.classList.contains('bg-secondary-container/20');
				if (isSelected) {
					// Deselect Strength Badge
					this.className = "skill-badge px-md py-xs bg-surface-container-low border border-outline-variant text-on-surface-variant rounded-full font-label-md hover:border-secondary hover:text-secondary transition-colors";
					const icon = this.querySelector('.material-symbols-outlined');
					if (icon) icon.remove();
				} else {
					// Select Strength Badge
					this.className = "skill-badge px-md py-xs bg-secondary-container/20 border border-secondary text-on-secondary-container rounded-full font-label-md flex items-center gap-xs";
					this.innerHTML += `<span class="material-symbols-outlined text-[16px]" style="font-variation-settings: 'FILL' 1;">check_circle</span>`;
				}
			} else {
				const isSelected = this.classList.contains('bg-tertiary-fixed');
				if (isSelected) {
					// Deselect Need Badge
					this.className = "skill-badge px-md py-xs bg-surface-container-low border border-outline-variant text-on-surface-variant rounded-full font-label-md hover:border-tertiary hover:text-tertiary transition-colors";
					const icon = this.querySelector('.material-symbols-outlined');
					if (icon) icon.remove();
				} else {
					// Select Need Badge
					this.className = "skill-badge px-md py-xs bg-tertiary-fixed border border-tertiary text-on-tertiary-fixed-variant rounded-full font-label-md flex items-center gap-xs";
					this.innerHTML += `<span class="material-symbols-outlined text-[16px]">priority_high</span>`;
				}
			}
		});
	});
}