import { apiRequest, requireAuth, updateUserHeader } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
	if (!requireAuth()) return;
	await updateUserHeader();

	// --- Load user data into settings form ---
	try {
		const profile = await apiRequest('/me');
		if (profile.success) {
			const data = profile.data;
			const user = data.user || {};

			// Pre-fill profile info form
			const nameInput = document.querySelector('input[type="text"]');
			if (nameInput) nameInput.value = `${user.first_name || ''} ${user.last_name || ''}`.trim();
			const emailInput = document.querySelector('input[type="email"]');
			if (emailInput) emailInput.value = user.email || '';
			const bioTextarea = document.querySelector('textarea');
			if (bioTextarea && data.bio) bioTextarea.value = data.bio;

			// Department & level selects
			const allSelects = document.querySelectorAll('select');
			if (allSelects[0] && data.department) {
				[...allSelects[0].options].forEach(opt => {
					if (opt.text.toLowerCase().includes(data.department.toLowerCase())) opt.selected = true;
				});
			}
			if (allSelects[1] && data.academic_level) {
				[...allSelects[1].options].forEach(opt => {
					if (opt.text.toLowerCase().includes(data.academic_level.toLowerCase())) opt.selected = true;
				});
			}
		}
	} catch (e) {
		console.error("Error loading profile", e);
	}

	// --- Save profile info ---
	const saveProfileBtn = document.querySelector('.bg-gradient-to-r.from-blue-600.to-indigo-600');
	if (saveProfileBtn) {
		saveProfileBtn.addEventListener('click', async () => {
			const card = saveProfileBtn.closest('.settings-card');
			if (!card) return;
			const bio = card.querySelector('textarea')?.value || '';
			const selects = card.querySelectorAll('select');
			const department = selects[0]?.value || '';
			const academic_level = selects[1]?.value || '';

			try {
				saveProfileBtn.disabled = true;
				const result = await apiRequest('/me', {
					method: 'PATCH',
					body: JSON.stringify({ bio, department, academic_level }),
				});
				if (result.success) {
					alert('✅ Profil mis à jour');
				} else {
					alert('❌ ' + (result.message || 'Erreur'));
				}
			} catch (err) {
				alert('❌ Erreur de connexion');
			} finally {
				saveProfileBtn.disabled = false;
			}
		});
	}

	// --- Change password ---
	const passwordBtn = document.querySelector('.border.border-slate-300.text-slate-700.font-semibold');
	if (passwordBtn && passwordBtn.textContent.toLowerCase().includes('mot de passe')) {
		passwordBtn.addEventListener('click', async () => {
			const section = passwordBtn.closest('.settings-card');
			if (!section) return;
			const inputs = section.querySelectorAll('input[type="password"]');
			const currentPassword = inputs[0]?.value;
			const newPassword = inputs[1]?.value;
			const confirmPassword = inputs[2]?.value;

			if (!currentPassword || !newPassword) {
				alert('Veuillez remplir tous les champs');
				return;
			}
			if (newPassword !== confirmPassword) {
				alert('Les mots de passe ne correspondent pas');
				return;
			}
			if (newPassword.length < 8) {
				alert('Le mot de passe doit contenir au moins 8 caracteres');
				return;
			}

			try {
				passwordBtn.disabled = true;
				const result = await apiRequest('/auth/change-password', {
					method: 'POST',
					body: JSON.stringify({ current_password: currentPassword, new_password: newPassword }),
				});
				if (result.success) {
					alert('Mot de passe modifie avec succes');
					inputs.forEach(i => i.value = '');
				} else {
					alert('Erreur: ' + (result.message || 'Erreur'));
				}
			} catch (err) {
				alert('Erreur de connexion');
			} finally {
				passwordBtn.disabled = false;
			}
		});
	}

	// --- Notification toggles ---
	document.querySelectorAll('.toggle-switch input').forEach(toggle => {
		toggle.addEventListener('change', function() {
			const label = this.closest('.flex.items-center.justify-between')?.querySelector('p.font-semibold')?.innerText;
			localStorage.setItem('notif_' + label, this.checked ? 'true' : 'false');
		});
	});

	initFocusInteractions();
	initAtmosphericNodes(5);
});

function initFocusInteractions() {
	document.querySelectorAll('input, select, textarea').forEach(el => {
		el.addEventListener('focus', () => {
			const label = el.parentElement.querySelector('label');
			if (label) label.classList.add('text-primary');
		});
		el.addEventListener('blur', () => {
			const label = el.parentElement.querySelector('label');
			if (label) label.classList.remove('text-primary');
		});
	});
}

function initAtmosphericNodes(nodeCount = 5) {
	const container = document.body;
	if (!container) return;
	const fragment = document.createDocumentFragment();
	for (let i = 0; i < nodeCount; i++) {
		const node = document.createElement('div');
		node.className = 'fixed opacity-[0.05] pointer-events-none rounded-full bg-primary';
		const size = Math.random() * 200 + 100;
		node.style.width = size + 'px';
		node.style.height = size + 'px';
		node.style.left = Math.random() * 100 + '%';
		node.style.top = Math.random() * 100 + '%';
		node.style.filter = 'blur(100px)';
		fragment.appendChild(node);
	}
	container.appendChild(fragment);
}
