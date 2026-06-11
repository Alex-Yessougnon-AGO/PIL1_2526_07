import { apiRequest, requireAuth, updateUserHeader } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
	if (!requireAuth()) return;
	await updateUserHeader();

	// --- User Info (greeting) ---
	try {
		const profile = await apiRequest('/me');
		if (profile.success) {
			const data = profile.data;
			const user = data.user || {};
			const greetingEl = document.querySelector('h2');
			if (greetingEl) greetingEl.textContent = `Bonjour, ${user.first_name || 'Utilisateur'} 👋`;
			localStorage.setItem('user_name', `${user.first_name || ''} ${user.last_name || ''}`.trim());
			localStorage.setItem('user_email', user.email || '');
		}
	} catch (e) {
		console.error("Error loading profile", e);
	}

	// --- Stats & Analytics ---
	try {
		const analytics = await apiRequest('/analytics/dashboard');
		if (analytics.success) {
			const stats = analytics.data;
			const statCards = document.querySelectorAll('.stat-card h3');
			if (statCards[0]) statCards[0].textContent = String(stats.posts_count || 0).padStart(2, '0');
			if (statCards[1]) statCards[1].textContent = String(stats.unread_notifications || 0).padStart(2, '0');
			if (statCards[2]) statCards[2].textContent = String(stats.pending_matches || 0).padStart(2, '0');
			
			const statLabels = document.querySelectorAll('.stat-card p.text-slate-500');
			if (statLabels[0]) statLabels[0].textContent = 'Posts actifs';
			if (statLabels[1]) statLabels[1].textContent = 'Notifications non lues';
			if (statLabels[2]) statLabels[2].textContent = 'Matchs en attente';

			// Also update hero stats if they exist
			const heroStats = document.querySelectorAll('.bg-white\\/20.backdrop-blur-sm.rounded-2xl .text-2xl');
			if (heroStats[0]) heroStats[0].textContent = String(stats.monthly_sessions || stats.posts_count || 0);
			if (heroStats[1]) heroStats[1].textContent = String(stats.completion_rate || Math.min(100, (stats.pending_matches || 0) * 10)) + '%';
		}
	} catch (e) {
		console.error("Error loading analytics", e);
	}

	// --- Notifications Badge ---
	try {
		const notifs = await apiRequest('/notifications');
		if (notifs.success) {
			const data = notifs.data || [];
			const unreadCount = data.filter(n => !n.is_read).length;
			const badges = document.querySelectorAll('.bg-blue-100.text-blue-700, .sidebar-item .ml-auto');
			badges.forEach(badge => { badge.textContent = String(unreadCount); });
		}
	} catch (e) {
		console.error("Error loading notifications", e);
	}

	// --- Matching Recommendations (Carousel) ---
	try {
		const recs = await apiRequest('/matching/recommendations');
		const container = document.getElementById('carousel-container');
		if (container) {
			const hardcodedCards = container.querySelectorAll('.min-w-\\[340px\\]');
			hardcodedCards.forEach(card => card.remove());

			if (recs.success && recs.data && recs.data.length > 0) {
				recs.data.forEach((match, index) => {
					const mentor = match.mentor || {};
					const score = match.score || 0;
					const skills = match.common_skills || [];
					const card = document.createElement('div');
					card.className = 'min-w-[340px] bg-white rounded-2xl border border-slate-200/80 p-6 snap-start shadow-lg hover:shadow-xl transition-all duration-300 hover:-translate-y-1';
					card.innerHTML = `
						<div class="flex justify-between items-start">
							<div class="flex gap-4">
								<img class="w-16 h-16 rounded-full object-cover avatar-ring" src="https://ui-avatars.com/api/?name=${encodeURIComponent((mentor.first_name||'') + '+' + (mentor.last_name||''))}&background=2563EB&color=fff&size=64" alt="mentor">
								<div>
									<h4 class="text-xl font-bold text-slate-800">${mentor.first_name || ''} ${mentor.last_name || ''}</h4>
									<p class="text-sm text-slate-500 font-medium">Match a ${Math.round(score)}%</p>
								</div>
							</div>
							<div class="bg-gradient-to-br from-blue-50 to-indigo-50 rounded-full px-3 py-1.5 text-center">
								<span class="text-sm font-black text-blue-700">${Math.round(score)}%</span>
								<span class="text-[10px] text-slate-500 block">match</span>
							</div>
						</div>
						<div class="flex flex-wrap gap-2 my-5">
							${skills.slice(0, 3).map(s => `<span class="bg-emerald-50 text-emerald-700 px-3 py-1.5 rounded-full text-xs font-bold">${s}</span>`).join('')}
							${skills.length === 0 ? '<span class="text-xs text-slate-400">Competences communes a explorer</span>' : ''}
						</div>
						<a href="student-profile.html?id=${mentor.id}" class="w-full bg-gradient-to-r from-blue-600 to-indigo-600 text-white py-3 rounded-xl font-bold shadow-md hover:shadow-lg hover:scale-[1.02] transition-all inline-block text-center">Consulter le profil →</a>
					`;
					container.appendChild(card);
				});
			} else {
				// Empty state
				const emptyCard = document.createElement('div');
				emptyCard.className = 'min-w-[340px] bg-white rounded-2xl border border-slate-200/80 p-6 snap-start shadow-lg flex items-center justify-center';
				emptyCard.innerHTML = '<div class="text-center"><span class="material-symbols-outlined text-4xl text-slate-300 mb-3">handshake</span><p class="text-sm text-slate-400">Aucune recommandation pour le moment.</p><p class="text-xs text-slate-400 mt-1">Completez votre profil pour obtenir des suggestions.</p></div>';
				container.appendChild(emptyCard);
			}
		}
	} catch (e) {
		console.error("Error loading recommendations", e);
	}

	// --- Activity Feed (replace hardcoded items with real notifications) ---
	try {
		const notifRes = await apiRequest('/notifications');
		const activityContainer = document.getElementById('activity-feed-container') || document.querySelector('.space-y-5');
		if (activityContainer) {
			activityContainer.innerHTML = '';
			if (notifRes.success && notifRes.data && notifRes.data.length > 0) {
				notifRes.data.slice(0, 4).forEach((notif, i) => {
					const iconMap = {
						'NEW_MATCH': ['bg-blue-100', 'check_circle', 'text-blue-600'],
						'NEW_MESSAGE': ['bg-amber-100', 'mail', 'text-amber-600'],
						'MATCH_ACCEPTED': ['bg-emerald-100', 'event', 'text-emerald-600'],
						'MATCH_REJECTED': ['bg-rose-100', 'event_busy', 'text-rose-600'],
					};
					const [bg, icon, color] = iconMap[notif.type] || ['bg-purple-100', 'insights', 'text-purple-600'];
					const line = document.createElement('div');
					line.className = 'flex gap-4 items-start';
					line.innerHTML = `
						<div class="relative flex-shrink-0">
							<div class="w-9 h-9 rounded-full ${bg} flex items-center justify-center ring-4 ring-white shadow-sm">
								<span class="material-symbols-outlined ${color} text-base">${icon}</span>
							</div>
							${i < notifRes.data.length - 1 ? '<div class="absolute top-9 left-4 w-0.5 h-12 bg-slate-200"></div>' : ''}
						</div>
						<div>
							<p class="font-semibold text-slate-800">${notif.title}</p>
							<p class="text-xs text-slate-500 mt-0.5">${new Date(notif.created_at).toLocaleDateString()}</p>
						</div>
					`;
					activityContainer.appendChild(line);
				});
			} else {
				activityContainer.innerHTML = '<div class="text-sm text-slate-400 text-center py-8">Aucune activité récente.</div>';
			}
		}
	} catch (e) {
		console.error("Error loading activity feed", e);
	}

	// Carousel scroll buttons
	const container = document.getElementById('carousel-container');
	const leftBtn = document.getElementById('scroll-left');
	const rightBtn = document.getElementById('scroll-right');
	if (leftBtn && rightBtn && container) {
		leftBtn.addEventListener('click', () => container.scrollBy({ left: -340, behavior: 'smooth' }));
		rightBtn.addEventListener('click', () => container.scrollBy({ left: 340, behavior: 'smooth' }));
	}
});
