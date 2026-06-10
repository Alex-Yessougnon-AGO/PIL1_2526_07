import { apiRequest, requireAuth, updateUserHeader } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
	if (!requireAuth()) return;
	await updateUserHeader();

	// --- Load Recommendations ---
	try {
		const result = await apiRequest('/matching/recommendations');
		if (result.success) {
			const recommendations = result.data || [];
			renderRecommendations(recommendations);
			// Update the total count in the filter bar
			const countSpan = document.querySelector('.font-extrabold.text-blue-600.text-lg');
			if (countSpan) countSpan.textContent = String(recommendations.length || 0);
		} else {
			removeLoadingState();
		}
	} catch (e) {
		console.error("Error loading matching recommendations", e);
		removeLoadingState();
	}

	// --- Handle Matching Actions ---
	document.addEventListener('click', async (e) => {
		const acceptBtn = e.target.closest('.btn-accept-match');
		if (acceptBtn) {
			const matchId = acceptBtn.dataset.matchId;
			try {
				const res = await apiRequest(`/matching/${matchId}/accept`, { method: 'POST' });
				if (res.success) {
					alert('Match accepté !');
					location.reload();
				}
			} catch (err) {
				alert('Error accepting match');
			}
		}

		const rejectBtn = e.target.closest('.btn-reject-match');
		if (rejectBtn) {
			const matchId = rejectBtn.dataset.matchId;
			try {
				const res = await apiRequest(`/matching/${matchId}/reject`, { method: 'POST' });
				if (res.success) {
					alert('Match refusé');
					location.reload();
				}
			} catch (err) {
				alert('Error rejecting match');
			}
		}
	});

	function removeLoadingState() {
		const container = document.querySelector('.grid.grid-cols-1.md\\:grid-cols-2.lg\\:grid-cols-3');
		if (!container) return;
		const loadingCards = container.querySelectorAll('.mentor-card');
		loadingCards.forEach(card => card.remove());
	}

	function renderRecommendations(matches) {
		const container = document.querySelector('.grid.grid-cols-1.md\\:grid-cols-2.lg\\:grid-cols-3');
		if (!container) return;

		// Clear existing static cards (preserve the "Invitation" card at the end)
		const staticCards = container.querySelectorAll('.mentor-card');
		staticCards.forEach(card => card.remove());

		// Empty state
		if (matches.length === 0) {
			const emptyCard = document.createElement('div');
			emptyCard.className = 'mentor-card rounded-2xl p-6 flex flex-col items-center justify-center card-animate col-span-1 md:col-span-2 lg:col-span-3';
			emptyCard.innerHTML = '<span class="material-symbols-outlined text-5xl text-slate-300 mb-3">handshake</span><p class="text-sm text-slate-400">Aucune recommandation pour le moment.</p><p class="text-xs text-slate-400 mt-1">Completez votre profil pour obtenir des suggestions personnalisees.</p>';
			container.appendChild(emptyCard);
			return;
		}

		const currentUserId = localStorage.getItem('user_id');

		matches.forEach((match, index) => {
			// API returns UserSerializer objects directly (not nested .user)
			const person = match.mentor || {};
			const score = match.score || 0;
			const offset = 282.7 - (282.7 * score / 100);
			const avatarUrl = `https://ui-avatars.com/api/?name=${encodeURIComponent((person.first_name||'') + '+' + (person.last_name||''))}&background=2563EB&color=fff&size=56`;

			const card = document.createElement('div');
			card.className = 'mentor-card rounded-2xl p-5 flex flex-col card-animate';
			card.style.animationDelay = `${index * 0.05}s`;
			card.innerHTML = `
				<div class="flex justify-between items-start mb-4">
					<div class="relative w-20 h-20">
						<svg class="w-full h-full -rotate-90" viewBox="0 0 100 100">
							<circle cx="50" cy="50" r="45" fill="none" stroke="#e2e8f0" stroke-width="6" />
							<circle cx="50" cy="50" r="45" fill="none" stroke="#2563EB" stroke-width="6" stroke-dasharray="282.7"
								stroke-dashoffset="${offset}" stroke-linecap="round" />
						</svg>
						<div class="absolute inset-0 flex flex-col items-center justify-center">
							<span class="text-xl font-black text-blue-600">${Math.round(score)}%</span>
						</div>
					</div>
					<div class="text-right">
						<span class="inline-block px-3 py-1 bg-blue-50 text-blue-700 rounded-full text-[11px] font-bold uppercase tracking-wide">Match</span>
						<p class="text-xs text-slate-500 mt-1">${person.email || ''}</p>
					</div>
				</div>
				<div class="flex items-center gap-3 mb-4">
					<img class="w-14 h-14 rounded-full object-cover ring-3 ring-blue-100 shadow-md" src="${avatarUrl}" alt="mentor">
					<div>
						<h3 class="text-lg font-bold text-slate-800">${person.first_name || ''} ${person.last_name || ''}</h3>
						<div class="flex items-center gap-1 text-slate-500 text-xs">
							<span class="material-symbols-outlined text-sm">location_on</span>
							<span>Campus IFRI</span>
						</div>
					</div>
				</div>
				<div class="mb-4">
					<p class="text-xs font-semibold text-slate-500 uppercase tracking-wide mb-2">Compétences communes</p>
					<div class="flex flex-wrap gap-2">
						${(match.common_skills || []).map(s => `<span class="bg-blue-50 text-blue-700 px-3 py-1 rounded-full text-xs font-medium">${s}</span>`).join('')}
						${(!match.common_skills || match.common_skills.length === 0) ? '<span class="text-xs text-slate-400">Aucune compétence commune</span>' : ''}
					</div>
				</div>
				<div class="mb-5">
					<p class="text-xs font-semibold text-slate-500 uppercase tracking-wide mb-2">Créneaux communs</p>
					<div class="flex items-center gap-2 text-slate-600 text-sm">
						<span class="material-symbols-outlined text-base">calendar_today</span>
						<span>${(match.common_slots || []).length > 0 ? match.common_slots.join(', ') : 'Voir les créneaux'}</span>
					</div>
				</div>
				<div class="grid grid-cols-2 gap-3 mt-auto pt-4 border-t border-slate-100">
					<button class="py-2.5 rounded-xl border border-blue-600 text-blue-600 font-semibold text-sm hover:bg-blue-600 hover:text-white transition-all" onclick="window.location.href='student-profile.html?id=${person.id}'">Profil</button>
					<button class="py-2.5 rounded-xl bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-semibold text-sm hover:shadow-lg transition-all flex items-center justify-center gap-1" onclick="window.location.href='message.html?userId=${person.id}'">
						<span class="material-symbols-outlined text-base">send</span> Message
					</button>
				</div>
			`;
			container.appendChild(card);
		});
	}
});
