import { apiRequest, requireAuth } from './api.js';

document.addEventListener('DOMContentLoaded', () => {
	if (!requireAuth()) return;
	const gridContainer = document.getElementById('availability-grid');
	if (gridContainer) {
		const times = ['09:00', '11:00', '13:00', '15:00', '17:00', '19:00'];
		const days = 7;

		times.forEach(time => {
			const labelTime = document.createElement('div');
			labelTime.className = 'text-right pr-2 font-caption text-caption text-on-surface-variant py-2';
			labelTime.textContent = time;
			gridContainer.appendChild(labelTime);

			for (let i = 0; i < days; i++) {
				const labelSlot = document.createElement('label');
				labelSlot.className = 'cursor-pointer h-10 border border-outline-variant/30 rounded bg-surface transition-all hover:bg-surface-container-high';
				labelSlot.innerHTML = `
<input type="checkbox" class="hidden peer">
<div class="w-full h-full peer-checked:bg-secondary peer-checked:text-on-secondary flex items-center justify-center">
<span class="material-symbols-outlined text-[14px] opacity-0 peer-checked:opacity-100">check</span>
</div>
`;
				gridContainer.appendChild(labelSlot);
			}
		});
	}

	const formatButtons = document.querySelectorAll('.radio-card');
	const formatInput = document.getElementById('selected-format');
	formatButtons.forEach(button => {
		button.addEventListener('click', () => {
			formatButtons.forEach(item => {
				item.classList.remove('active', 'bg-blue-600', 'text-white', 'shadow-md');
				item.classList.add('bg-white', 'text-slate-700');
			});
			button.classList.add('active', 'bg-blue-600', 'text-white', 'shadow-md');
			button.classList.remove('bg-white', 'text-slate-700');
			if (formatInput) {
				formatInput.value = button.dataset.format || 'online';
			}
		});
	});

	const tagContainer = document.getElementById('tagContainer');
	const skillInput = document.getElementById('skillInput');
	if (skillInput && tagContainer) {
		skillInput.addEventListener('keydown', (event) => {
			if (event.key === 'Enter') {
				event.preventDefault();
				const value = skillInput.value.trim();
				if (!value) return;

				const tag = document.createElement('span');
				tag.className = 'skill-tag inline-flex items-center gap-2 px-3 py-1.5 rounded-full text-sm font-medium bg-slate-100 text-slate-800';
				tag.innerHTML = `${value}<button type="button" class="text-blue-800 hover:text-red-500 transition-colors remove-tag-button">×</button>`;
				tagContainer.appendChild(tag);
				skillInput.value = '';
			}
		});

		tagContainer.addEventListener('click', (event) => {
			const removeButton = event.target.closest('.remove-tag-button');
			if (removeButton) {
				const tag = removeButton.closest('.skill-tag');
				if (tag) tag.remove();
			}
		});
	}

	const form = document.getElementById('mentor-form');
	if (form) {
		form.addEventListener('submit', async (e) => {
			e.preventDefault();

			const submitBtn = form.querySelector('button[type="submit"]');
			if (submitBtn) {
				submitBtn.disabled = true;
				submitBtn.innerHTML = '<span class="material-symbols-outlined animate-spin">sync</span> Publication...';
			}

			const formData = new FormData(form);
			const tags = Array.from(form.querySelectorAll('.skill-tag')).map(tag => tag.childNodes[0]?.textContent?.trim()).filter(Boolean);
			const data = {
				type: 'OFFER',
				subject: formData.get('subject'),
				description: formData.get('description'),
				format: String(formData.get('format') || 'online').toUpperCase(),
				domain: formData.get('domain'),
				max_students: Number(formData.get('max_students')) || 1,
				tags,
			};

			try {
				const result = await apiRequest('/posts', {
					method: 'POST',
					body: JSON.stringify(data),
				});

				if (result.success) {
					alert('Offre publiée avec succès !');
					window.location.href = 'dashboard.html';
				} else {
					alert(result.message || 'Erreur lors de la publication');
				}
			} catch (error) {
				console.error(error);
				alert('Erreur de connexion avec le serveur');
			} finally {
				if (submitBtn) {
					submitBtn.disabled = false;
					submitBtn.innerHTML = 'Publier l\'offre';
				}
			}
		});
	}
});
