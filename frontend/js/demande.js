import { apiRequest, requireAuth } from './api.js';

document.addEventListener('DOMContentLoaded', () => {
	if (!requireAuth()) return;
	const form = document.getElementById('helpForm');
	const feedbackMessage = document.getElementById('feedback-message');
	const levelButtons = Array.from(document.querySelectorAll('button[data-group="level"]'));
	const formatButtons = Array.from(document.querySelectorAll('button[data-group="format"]'));
	const selectedLevel = document.getElementById('selected-level');
	const selectedFormat = document.getElementById('selected-format');

	if (!form) return;

	function updateChoiceGroup(buttons, hiddenInput) {
		buttons.forEach(button => {
			button.addEventListener('click', () => {
				buttons.forEach(item => {
					item.classList.remove('active', 'bg-blue-600', 'text-white');
					item.classList.add('text-slate-600');
				});
				button.classList.add('active', 'bg-blue-600', 'text-white');
				button.classList.remove('text-slate-600');
				if (hiddenInput) {
					hiddenInput.value = button.textContent.trim();
				}
			});
		});
	}

	updateChoiceGroup(levelButtons, selectedLevel);
	updateChoiceGroup(formatButtons, selectedFormat);

	form.addEventListener('submit', async (e) => {
		e.preventDefault();

		const submitBtn = form.querySelector('button[type="submit"]');
		if (submitBtn) {
			submitBtn.disabled = true;
			submitBtn.innerHTML = '<span class="material-symbols-outlined animate-spin">sync</span> Publication...';
		}

		const formData = new FormData(form);
		const format = String(formData.get('format') || 'ONLINE').trim().toUpperCase();
		const data = {
			type: 'REQUEST',
			subject: formData.get('subject'),
			description: formData.get('description'),
			format: format === 'PHYSICAL' || format === 'ONLINE' || format === 'BOTH' ? format : 'ONLINE',
			level: String(formData.get('level') || 'Débutant'),
			domain: formData.get('domain'),
			availability: formData.get('availability'),
		};

		try {
			const result = await apiRequest('/posts', {
				method: 'POST',
				body: JSON.stringify(data),
			});

			if (result.success) {
				showFeedback('✅ Demande envoyée avec succès !', 'text-emerald-600');
				form.reset();
			} else {
				showFeedback(`❌ ${result.message || 'Une erreur est survenue'}`, 'text-red-600');
			}
		} catch (error) {
			console.error(error);
			showFeedback('❌ Erreur de connexion au serveur', 'text-red-600');
		} finally {
			if (submitBtn) {
				submitBtn.disabled = false;
				submitBtn.innerHTML = 'Publier la demande';
			}
		}
	});

	function showFeedback(message, colorClass) {
		if (!feedbackMessage) return;
		feedbackMessage.textContent = message;
		feedbackMessage.className = `text-sm ${colorClass}`;
	}
});
