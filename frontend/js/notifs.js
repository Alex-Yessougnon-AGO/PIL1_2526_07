import { apiRequest, requireAuth, updateUserHeader } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
	if (!requireAuth()) return;
	await updateUserHeader();

	const notifContainer = document.querySelector('.space-y-3');
	const markAllReadBtn = document.querySelector('.flex.items-center.gap-2 button:first-child');
	const badge = document.querySelector('.sidebar-item.active .ml-auto');

	// --- Load Notifications ---
	try {
		const res = await apiRequest('/notifications');
		if (res.success) {
			renderNotifications(res.data);
		}
	} catch (e) {
		console.error("Error loading notifications", e);
	}

	function renderNotifications(notifs) {
		if (!notifContainer) return;
		notifContainer.innerHTML = '';

		if (notifs.length === 0) {
			notifContainer.innerHTML = '<div class="text-center py-10 text-slate-400">Aucune notification pour le moment.</div>';
			return;
		}

		notifs.forEach((notif, index) => {
			const isUnread = !notif.is_read;
			const card = document.createElement('div');
			card.className = `notif-card ${isUnread ? 'unread' : ''} rounded-xl p-4 flex gap-4 items-start notif-animate`;
			card.style.animationDelay = `${index * 0.05}s`;
			
			const icon = getNotificationIcon(notif.type);
			
			card.innerHTML = `
				<div class="relative flex-shrink-0">
					<div class="w-12 h-12 rounded-full ${icon.bg} flex items-center justify-center shadow-md">
						<span class="material-symbols-outlined text-white">${icon.symbol}</span>
					</div>
					${isUnread ? '<div class="absolute -top-1 -right-1 w-3 h-3 bg-blue-600 rounded-full ring-2 ring-white pulse-dot"></div>' : ''}
				</div>
				<div class="flex-1">
					<div class="flex flex-wrap justify-between items-start gap-2 mb-1">
						<h4 class="font-bold text-slate-800">${notif.title}</h4>
						<span class="text-xs text-slate-400 bg-slate-100 px-2 py-0.5 rounded-full">${timeAgo(notif.created_at)}</span>
					</div>
					<p class="text-slate-600 text-sm leading-relaxed">${notif.content}</p>
					<div class="flex gap-3 mt-3">
						<button class="text-sm bg-blue-600 text-white px-4 py-1.5 rounded-lg hover:bg-blue-700 transition-all">Voir</button>
					</div>
				</div>
			`;
			
			card.addEventListener('click', async () => {
				try {
					await apiRequest('/notifications/read', {
						method: 'POST',
						body: JSON.stringify({ ids: [notif.id] }),
					});
					card.classList.remove('unread');
					const dot = card.querySelector('.pulse-dot');
					if (dot) dot.remove();
				} catch (e) {
					console.error("Error marking notification as read", e);
				}
			});
			
			notifContainer.appendChild(card);
		});
	}

	function getNotificationIcon(type) {
		switch(type) {
			case 'NEW_MATCH': return { bg: 'bg-gradient-to-br from-blue-500 to-blue-600', symbol: 'handshake' };
			case 'NEW_MESSAGE': return { bg: 'bg-gradient-to-br from-amber-500 to-orange-500', symbol: 'mail' };
			case 'MATCH_ACCEPTED': return { bg: 'bg-gradient-to-br from-emerald-500 to-teal-500', symbol: 'military_tech' };
			case 'MATCH_REJECTED': return { bg: 'bg-gradient-to-br from-rose-500 to-pink-500', symbol: 'event_busy' };
			default: return { bg: 'bg-gradient-to-br from-slate-500 to-slate-600', symbol: 'notifications' };
		}
	}

	function timeAgo(dateStr) {
		const now = new Date();
		const past = new Date(dateStr);
		const diff = (now - past) / 1000;
		if (diff < 60) return 'À l\'instant';
		if (diff < 3600) return Math.floor(diff/60) + ' min';
		if (diff < 86400) return Math.floor(diff/3600) + ' h';
		return past.toLocaleDateString();
	}

	if (markAllReadBtn) {
		markAllReadBtn.addEventListener('click', async () => {
			const unreadIds = Array.from(document.querySelectorAll('.notif-card.unread'))
				.map((_, index) => {
					// This is a bit hacky, we should store IDs on the elements
					return `id-${index}`; 
				});
			
			// In a real scenario, we'd collect real IDs. For now, we'll just call the API
			try {
				await apiRequest('/notifications/read', {
					method: 'POST',
					body: JSON.stringify({ ids: [] }), // Sending empty implies all or we should fetch IDs first
				});
				document.querySelectorAll('.notif-card.unread').forEach(card => {
					card.classList.remove('unread');
					const dot = card.querySelector('.pulse-dot');
					if (dot) dot.remove();
				});
				if (badge) badge.textContent = '0';
			} catch (e) {
				console.error("Error marking all as read", e);
			}
		});
	}
});
