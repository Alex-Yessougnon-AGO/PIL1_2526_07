import { apiRequest, requireAuth, updateUserHeader } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
	if (!requireAuth()) return;
	await updateUserHeader();

	try {
		const profile = await apiRequest('/me');
		if (profile.success) {
			const data = profile.data;
			const user = data.user || {};

			// Identity Card
			const nameEl = document.querySelector('h1.text-3xl');
			if (nameEl) nameEl.textContent = `${user.first_name || ''} ${user.last_name || ''}`.trim() || 'Utilisateur';

			const subtitleEl = document.querySelector('.text-slate-500.text-sm');
			if (subtitleEl) {
				const dept = data.department || '';
				const level = data.academic_level || '';
				subtitleEl.innerHTML = `<span class="material-symbols-outlined text-base">school</span> ${dept}${dept && level ? ' • ' : ''}${level}`;
			}

			// Large profile avatar
			const profileImg = document.querySelector('.w-32.h-32.rounded-2xl.object-cover');
			if (profileImg) {
				profileImg.src = data.profile_photo || `https://ui-avatars.com/api/?name=${encodeURIComponent((user.first_name||'') + '+' + (user.last_name||''))}&background=2563EB&color=fff&size=128`;
			}

			// Bio
			const bioEl = document.querySelector('.text-slate-600.leading-relaxed');
			if (bioEl) bioEl.textContent = data.bio || 'Aucune biographie fournie.';

			// Skills - Mentor (STRENGTH)
			const allSkillContainers = document.querySelectorAll('.flex.flex-wrap.gap-2');
			allSkillContainers.forEach(container => {
				const parentText = container.parentElement?.querySelector('h3')?.textContent?.toLowerCase() || '';
				if (parentText.includes('peux aider') || parentText.includes('aider')) {
					container.innerHTML = '';
					const strengths = (data.skills || []).filter(s => s.type === 'STRENGTH');
					if (strengths.length > 0) {
						strengths.forEach(s => {
							const span = document.createElement('span');
							span.className = 'bg-emerald-50 text-emerald-700 px-3 py-1.5 rounded-full text-sm font-medium';
							span.textContent = s.skill_name;
							container.appendChild(span);
						});
					} else {
						container.innerHTML = '<span class="text-sm text-slate-400">Aucune compétence déclarée</span>';
					}
				}
				if (parentText.includes("d'aide") || parentText.includes('besoin')) {
					container.innerHTML = '';
					const weaknesses = (data.skills || []).filter(s => s.type === 'WEAKNESS');
					if (weaknesses.length > 0) {
						weaknesses.forEach(s => {
							const span = document.createElement('span');
							span.className = 'bg-amber-50 text-amber-700 px-3 py-1.5 rounded-full text-sm font-medium';
							span.textContent = s.skill_name;
							container.appendChild(span);
						});
					} else {
						container.innerHTML = '<span class="text-sm text-slate-400">Aucun besoin déclaré</span>';
					}
				}
			});

			// Contact info - update email dynamically
			const emailSections = document.querySelectorAll('.flex.items-center.gap-3.text-sm');
			emailSections.forEach(section => {
				const icon = section.querySelector('.material-symbols-outlined');
				if (icon && icon.textContent.includes('mail')) {
					const valueSpan = section.querySelector('span:not(.material-symbols-outlined)');
					if (valueSpan) valueSpan.textContent = user.email || 'Non renseigné';
				}
			});
			const phoneField = document.querySelectorAll('.text-slate-700');
			phoneField.forEach(el => {
				const icon = el.parentElement?.querySelector('.material-symbols-outlined');
				if (icon && icon.textContent.includes('call')) {
					el.textContent = user.phone || 'Non renseigné';
				}
			});

			// Update nav notification badge
			const sidebarBadge = document.querySelector('.sidebar-item.active .ml-auto, .sidebar-item .ml-auto');
			if (sidebarBadge) {
				try {
					const notifs = await apiRequest('/notifications');
					const unread = (notifs.data || []).filter(n => !n.is_read).length;
					sidebarBadge.textContent = String(unread);
				} catch (_) {}
			}

			// === PROFILE STATS ===
			loadProfileStats();

			// === ACTIVE PROPOSALS ===
			loadMyProposals();

			// === AVAILABILITY CALENDAR ===
			renderAvailability(data.availability || []);
		}
	} catch (e) {
		console.error("Error loading profile", e);
	}

	// Original effects
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

	const binaryStrips = document.querySelectorAll('.binary-divider');
	setInterval(() => {
		binaryStrips.forEach(strip => {
			const text = strip.innerText;
			if (text.length > 10) {
				const newText = text.substring(1) + (Math.random() > 0.5 ? '1' : '0');
				strip.innerText = newText;
			}
		});
	}, 1000);
});

async function loadProfileStats() {
	try {
		const res = await apiRequest('/me/stats');
		if (res.success && res.data) {
			const s = res.data;
			const sessionsGiven = document.getElementById('statSessionsGiven');
			const sessionsReceived = document.getElementById('statSessionsReceived');
			const completionRate = document.getElementById('statCompletionRate');
			const completionBar = document.getElementById('statCompletionBar');

			if (sessionsGiven) sessionsGiven.textContent = s.sessions_given || 0;
			if (sessionsReceived) sessionsReceived.textContent = s.sessions_received || 0;
			if (completionRate) completionRate.textContent = (s.completion_rate || 0) + '%';
			if (completionBar) completionBar.style.width = (s.completion_rate || 0) + '%';
		}
	} catch (e) {
		console.error('Error loading stats', e);
	}
}

async function loadMyProposals() {
	try {
		const res = await apiRequest('/me/proposals');
		const container = document.getElementById('proposalsContainer');
		if (!container) return;

		if (!res.success || !res.data || res.data.length === 0) {
			container.innerHTML = '<p class="text-sm text-slate-400 text-center py-4">Aucune proposition active pour le moment.</p>';
			return;
		}

		container.innerHTML = '';
		res.data.forEach(post => {
			const isOffer = post.type === 'OFFER';
			const icon = isOffer ? 'menu_book' : 'help_center';
			const iconBg = isOffer ? 'bg-emerald-100' : 'bg-amber-100';
			const iconColor = isOffer ? 'text-emerald-600' : 'text-amber-600';
			const hoverBorder = isOffer ? 'hover:border-emerald-200' : 'hover:border-amber-200';
			const hoverColor = isOffer ? 'group-hover:text-emerald-600' : 'group-hover:text-amber-600';
			const typeLabel = isOffer ? 'Offre' : 'Demande';

			const div = document.createElement('div');
			div.className = `flex items-center justify-between p-4 border border-slate-100 rounded-xl ${hoverBorder} hover:shadow-md transition-all cursor-pointer group`;
			div.innerHTML = `
				<div class="flex items-center gap-4">
					<div class="w-10 h-10 rounded-xl ${iconBg} flex items-center justify-center">
						<span class="material-symbols-outlined ${iconColor}">${icon}</span>
					</div>
					<div>
						<p class="font-semibold text-slate-800 ${hoverColor} transition-colors">${post.subject}</p>
						<p class="text-xs text-slate-500 mt-0.5">${typeLabel} • ${post.format || 'En ligne'}</p>
					</div>
				</div>
				<span class="material-symbols-outlined text-slate-400 group-hover:text-blue-600">chevron_right</span>
			`;
			container.appendChild(div);
		});
	} catch (e) {
		console.error('Error loading proposals', e);
	}
}

function renderAvailability(slots) {
	const container = document.getElementById('availabilityGrid');
	if (!container) return;

	if (!slots || slots.length === 0) {
		container.innerHTML = '<p class="text-sm text-slate-400 text-center py-4">Aucune disponibilité définie. <a href="modiffier_profil.html" class="text-blue-600 hover:underline">Ajouter</a></p>';
		return;
	}

	// Map French period labels to English keys
	const periodMap = { 'Matin': 'morning', 'Midi': 'midday', 'Après-m': 'afternoon', 'Soir': 'evening' };
	const timeSlots = ['Matin', 'Midi', 'Après-m', 'Soir'];
	const dayOrder = ['MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY'];
	const dayAbbr = ['L', 'M', 'M', 'J', 'V'];

	// For each day, determine which periods are available
	const availability = {};
	dayOrder.forEach(d => { availability[d] = { morning: false, midday: false, afternoon: false, evening: false }; });

	slots.forEach(slot => {
		if (!availability[slot.day_of_week]) return;
		const hour = parseInt(slot.start_time.split(':')[0]);
		if (hour < 12) availability[slot.day_of_week].morning = true;
		else if (hour < 14) availability[slot.day_of_week].midday = true;
		else if (hour < 18) availability[slot.day_of_week].afternoon = true;
		else availability[slot.day_of_week].evening = true;
	});

	let html = '<div class="grid grid-cols-6 gap-1.5 text-center text-xs font-medium mb-3"><div></div>';
	dayAbbr.forEach(d => { html += `<div class="text-slate-500">${d}</div>`; });
	html += '</div>';

	timeSlots.forEach(period => {
		html += `<div class="grid grid-cols-6 gap-1.5 mb-1.5 items-center">`;
		html += `<div class="text-right text-xs text-slate-500 pr-1">${period}</div>`;
		const periodKey = periodMap[period];
		dayOrder.forEach(day => {
			const isAvail = availability[day][periodKey];
			if (isAvail) {
				html += `<div class="h-7 rounded-md bg-blue-600/80 border border-blue-600/30"></div>`;
			} else {
				html += `<div class="h-7 rounded-md bg-slate-100 border border-slate-200"></div>`;
			}
		});
		html += '</div>';
	});

	container.innerHTML = html;
}
