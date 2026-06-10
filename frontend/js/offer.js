import { apiRequest, requireAuth } from './api.js';

function normalizeFormat(value) {
	const normalized = String(value || '').trim().toLowerCase();
	if (normalized === 'presentiel' || normalized === 'physical') return 'PHYSICAL';
	if (normalized === 'hybride' || normalized === 'both') return 'BOTH';
	return 'ONLINE';
}

function dayLabelFromIndex(index) {
	const days = ['MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY'];
	return days[index] || 'MONDAY';
}

function nextSlotTime(time) {
	const times = ['08:00', '10:00', '12:00', '14:00', '16:00', '18:00', '20:00'];
	const currentIndex = times.indexOf(time);
	return times[currentIndex + 1] || '20:00';
}

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
				formatInput.value = normalizeFormat(button.dataset.format || 'online');
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

	const availabilityCells = document.querySelectorAll('.avail-cell');
	availabilityCells.forEach(cell => {
		cell.addEventListener('click', () => {
			cell.classList.toggle('selected');
			cell.classList.toggle('bg-blue-100');
			cell.classList.toggle('border-blue-400');
		});
	});

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
			const selectedAvailability = Array.from(document.querySelectorAll('.avail-cell.selected'));
			const formatValue = normalizeFormat(String(formData.get('format') || 'online'));
			const data = {
				type: 'OFFER',
				subject: formData.get('subject'),
				description: formData.get('description'),
				format: formatValue,
				domain: formData.get('domain'),
				max_students: Number(formData.get('max_students')) || 1,
				tags,
			};

			try {
				await Promise.all(selectedAvailability.map(async (cell) => {
					const row = cell.closest('tr');
					const rowIndex = row ? Array.from(row.parentElement.children).indexOf(row) : 0;
					const colIndex = row ? Array.from(row.children).indexOf(cell) - 1 : 0;
					const start = row?.children[0]?.textContent?.trim() || '08:00';
					const end = nextSlotTime(start);
					await apiRequest('/me/availability', {
						method: 'POST',
						body: JSON.stringify({ day: dayLabelFromIndex(colIndex), start, end }),
					});
				}));

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
