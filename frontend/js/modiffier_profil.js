import { apiRequest, requireAuth, fetchWithAuth, updateUserHeader } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
	if (!requireAuth()) return;
	await updateUserHeader();

	// --- Load current profile data to pre-fill form ---
	try {
		const profile = await apiRequest('/me');
		if (profile.success) {
			const data = profile.data;
			const user = data.user || {};

			// Pre-fill name inputs - utiliser #profile-form pour cibler les champs dans le formulaire
			const nameInput = document.querySelector('#profile-form input[type="text"]');
			if (nameInput) nameInput.value = `${user.first_name || ''} ${user.last_name || ''}`.trim() || 'Utilisateur';

			const emailInput = document.querySelector('#profile-form input[type="email"]');
			if (emailInput) emailInput.value = user.email || '';

			const telInput = document.querySelector('#profile-form input[type="tel"]');
			if (telInput) telInput.value = user.phone || '';

			// Pre-fill bio
			const bioTextarea = document.querySelector('#profile-form textarea');
			if (bioTextarea) bioTextarea.value = data.bio || '';

			// Pre-fill department + level
			const deptSelect = Array.from(document.querySelectorAll('select')).find(s =>
				[...s.options].some(o => o.text.includes(data.department))
			);
			if (deptSelect && data.department) {
				const opt = [...deptSelect.options].find(o => o.text.includes(data.department));
				if (opt) opt.selected = true;
			}

			const levelSelect = Array.from(document.querySelectorAll('select')).find(s =>
				[...s.options].some(o => o.text.includes(data.academic_level))
			);
			if (levelSelect && data.academic_level) {
				const opt = [...levelSelect.options].find(o => o.text.includes(data.academic_level));
				if (opt) opt.selected = true;
			}

			// Pre-fill skills tags
			if (data.skills) {
				const mentorContainer = document.getElementById('mentorTagsContainer');
				const learnerContainer = document.getElementById('learnerTagsContainer');
				if (mentorContainer) mentorContainer.innerHTML = '';
				if (learnerContainer) learnerContainer.innerHTML = '';

				data.skills.forEach(s => {
					const tag = document.createElement('span');
					tag.className = 'skill-tag inline-flex items-center gap-1 px-3 py-1.5 rounded-full text-sm font-medium';
					if (s.type === 'STRENGTH') {
						tag.style.background = '#e0e7ff';
						tag.style.color = '#1e40af';
						tag.innerHTML = `${s.skill_name}<button type="button" class="remove-tag-btn"><span class="material-symbols-outlined text-sm text-blue-800 hover:text-red-500">close</span></button>`;
						if (mentorContainer) mentorContainer.appendChild(tag);
					} else if (s.type === 'WEAKNESS') {
						tag.style.background = '#fef3c7';
						tag.style.color = '#92400e';
						tag.innerHTML = `${s.skill_name}<button type="button" class="remove-tag-btn"><span class="material-symbols-outlined text-sm text-amber-800 hover:text-red-500">close</span></button>`;
						if (learnerContainer) learnerContainer.appendChild(tag);
					}
				});
			}

			// Update avatar
			const avatarImg = document.querySelector('.avatar-container img, img.w-32');
			if (avatarImg) {
				avatarImg.src = data.profile_photo || `https://ui-avatars.com/api/?name=${encodeURIComponent((user.first_name||'') + '+' + (user.last_name||''))}&background=2563EB&color=fff&size=128`;
			}
		}
	} catch (e) {
		console.error("Error loading profile for pre-fill", e);
	}

	// --- Scroll animations ---
	const sections = document.querySelectorAll('.animate-section');
	const observer = new IntersectionObserver((entries) => {
		entries.forEach(entry => {
			if (entry.isIntersecting) {
				entry.target.style.opacity = '1';
				entry.target.style.transform = 'translateY(0)';
			}
		});
	}, { threshold: 0.05 });
	sections.forEach(section => {
		section.style.opacity = '0';
		section.style.transform = 'translateY(20px)';
		section.style.transition = 'all 0.4s ease-out';
		observer.observe(section);
	});

	// --- Mentor Skills Tags ---
	const mentorInput = document.getElementById('mentorSkillInput');
	const mentorContainer = document.getElementById('mentorTagsContainer');
	if (mentorInput && mentorContainer) {
		mentorInput.addEventListener('keypress', (e) => {
			if (e.key === 'Enter' && mentorInput.value.trim() !== '') {
				e.preventDefault();
				const tag = document.createElement('span');
				tag.className = 'skill-tag inline-flex items-center gap-1 px-3 py-1.5 rounded-full text-sm font-medium';
				tag.style.background = '#e0e7ff';
				tag.style.color = '#1e40af';
				const skillName = mentorInput.value.trim();
				tag.innerHTML = `${skillName}<button type="button" class="remove-tag-btn"><span class="material-symbols-outlined text-sm text-blue-800 hover:text-red-500">close</span></button>`;
				mentorContainer.appendChild(tag);
				mentorInput.value = '';
			}
		});
	}

	// --- Learner Skills Tags ---
	const learnerInput = document.getElementById('learnerSkillInput');
	const learnerContainer = document.getElementById('learnerTagsContainer');
	if (learnerInput && learnerContainer) {
		learnerInput.addEventListener('keypress', (e) => {
			if (e.key === 'Enter' && learnerInput.value.trim() !== '') {
				e.preventDefault();
				const tag = document.createElement('span');
				tag.className = 'skill-tag inline-flex items-center gap-1 px-3 py-1.5 rounded-full text-sm font-medium';
				tag.style.background = '#fef3c7';
				tag.style.color = '#92400e';
				const skillName = learnerInput.value.trim();
				tag.innerHTML = `${skillName}<button type="button" class="remove-tag-btn"><span class="material-symbols-outlined text-sm text-amber-800 hover:text-red-500">close</span></button>`;
				learnerContainer.appendChild(tag);
				learnerInput.value = '';
			}
		});
	}

	// --- Event delegation for tag removal ---
	document.addEventListener('click', (e) => {
		if (e.target.closest('.remove-tag-btn')) {
			e.preventDefault();
			const tag = e.target.closest('.skill-tag');
			if (tag) tag.remove();
		}
	});

	// --- Avatar upload (placeholder) ---
	const avatarContainer = document.querySelector('.avatar-container');
	if (avatarContainer) {
		avatarContainer.addEventListener('click', () => {
			const input = document.createElement('input');
			input.type = 'file';
			input.accept = 'image/*';
			input.onchange = async (e) => {
				const file = e.target.files[0];
				if (!file) return;
				const formData = new FormData();
				formData.append('photo', file);
				try {
					const result = await fetchWithAuth('/me/photo', {
						method: 'POST',
						body: formData,
						headers: {}, // Let fetch set Content-Type for FormData
					});
					if (result.ok) {
						const img = avatarContainer.querySelector('img');
						if (img) img.src = URL.createObjectURL(file);
						alert('✅ Photo de profil mise à jour !');
					} else {
						alert('❌ Erreur lors du téléchargement');
					}
				} catch (err) {
					console.error(err);
					alert('❌ Erreur de connexion');
				}
			};
			input.click();
		});
	}

	// --- Profile update form ---
	const profileForm = document.querySelector('form');
	if (profileForm) {
		profileForm.addEventListener('submit', async (e) => {
			e.preventDefault();
			const submitBtn = profileForm.querySelector('button[type="submit"]');
			if (submitBtn) {
				submitBtn.disabled = true;
				submitBtn.innerHTML = '<span class="material-symbols-outlined animate-spin">sync</span> Enregistrement...';
			}

			// Collect mentor and learner skills
			const mentorSkills = Array.from(document.querySelectorAll('#mentorTagsContainer .skill-tag'))
				.map(tag => {
					const text = tag.textContent.replace('close', '').trim();
					return text;
				})
				.filter(Boolean);
			const learnerSkills = Array.from(document.querySelectorAll('#learnerTagsContainer .skill-tag'))
				.map(tag => {
					const text = tag.textContent.replace('close', '').trim();
					return text;
				})
				.filter(Boolean);

				const formInputs = profileForm.querySelectorAll('input, select, textarea');
			const nameValue = (formInputs[0]?.value || '').trim();
			const nameParts = nameValue.split(' ');
			const updateData = {
				first_name: nameParts[0] || '',
				last_name: nameParts.slice(1).join(' ') || '',
				phone: formInputs[2]?.value || '',
				bio: profileForm.querySelector('textarea')?.value || '',
				department: profileForm.querySelectorAll('select')[0]?.value || '',
				academic_level: profileForm.querySelectorAll('select')[1]?.value || '',
				mentor_skills: mentorSkills,
				learner_skills: learnerSkills,
			};

			try {
				const result = await apiRequest('/me', {
					method: 'PATCH',
					body: JSON.stringify(updateData),
				});

				if (result.success) {
					alert('✅ Profil mis à jour avec succès !');
					window.location.href = 'mon-profile.html';
				} else {
					alert(`❌ ${result.message || 'Erreur lors de la mise à jour'}`);
				}
			} catch (error) {
				console.error(error);
				alert('❌ Erreur de connexion au serveur');
			} finally {
				if (submitBtn) {
					submitBtn.disabled = false;
					submitBtn.innerHTML = 'Enregistrer les modifications';
				}
			}
		});
	}

	// --- Availability toggle (if exists) ---
	document.querySelectorAll('.availability-cell').forEach(cell => {
		cell.addEventListener('mouseenter', () => {
			if (cell.classList.contains('bg-primary/20')) {
				cell.style.boxShadow = '0 0 10px rgba(0, 95, 172, 0.3)';
			}
		});
		cell.addEventListener('mouseleave', () => {
			cell.style.boxShadow = 'none';
		});
	});

	// --- Binary animation (if exists) ---
	const binaryStrips = document.querySelectorAll('.binary-divider');
	if (binaryStrips.length > 0) {
		setInterval(() => {
			binaryStrips.forEach(strip => {
				const text = strip.innerText;
				if (text.length > 10) {
					const newText = text.substring(1) + (Math.random() > 0.5 ? '1' : '0');
					strip.innerText = newText;
				}
			});
		}, 1000);
	}
});
