import { apiRequest, requireAuth, updateUserHeader } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
	if (!requireAuth()) return;
	await updateUserHeader();

	const notifContainer = document.querySelector('.space-y-3');
	const markAllReadBtn = Array.from(document.querySelectorAll('button')).find(btn => /tout marquer lu/i.test(btn.textContent || ''));
	const badge = document.querySelector('.sidebar-item.active .ml-auto');

	let allNotifications = [];

	// --- Setup filter buttons (client-side) ---
	const filterBtns = document.querySelectorAll('.flex.gap-1.bg-slate-100 button');
	filterBtns.forEach(btn => {
		btn.addEventListener('click', function() {
			filterBtns.forEach(b => {
				b.classList.remove('bg-white', 'text-blue-600', 'shadow-sm');
				b.classList.add('text-slate-600');
			});
			this.classList.add('bg-white', 'text-blue-600', 'shadow-sm');
			this.classList.remove('text-slate-600');

			const filter = this.textContent.trim();
			applyFilter(filter);
		});
	});

	function applyFilter(filter) {
		let filtered = allNotifications;
		switch (filter) {
			case 'Non lues':
				filtered = allNotifications.filter(n => !n.is_read);
				break;
			case 'Mentorat':
				filtered = allNotifications.filter(n => n.type === 'NEW_MATCH' || n.type === 'MATCH_REJECTED');
				break;
			case 'Messages':
				filtered = allNotifications.filter(n => n.type === 'NEW_MESSAGE');
				break;
			case 'Sessions':
				filtered = allNotifications.filter(n => n.type === 'MATCH_ACCEPTED' || n.type === 'VERIFICATION_APPROVED' || n.type === 'VERIFICATION_REJECTED');
				break;
		}
		renderNotifications(filtered);
	}

	// --- Setup Paramètres button ---
	const settingsBtn = Array.from(document.querySelectorAll('button')).find(btn => /paramètres|parametres/i.test(btn.textContent || ''));
	if (settingsBtn) {
		settingsBtn.addEventListener('click', () => {
			window.location.href = 'settings.html';
		});
	}

	// --- Load Notifications ---
	try {
		const res = await apiRequest('/notifications');
		if (res.success) {
			allNotifications = res.data || [];
			renderNotifications(allNotifications);
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
			const route = getNotificationRoute(notif.type);
			card.dataset.notificationId = String(notif.id || '');
			card.dataset.route = route;
			
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
						<button type="button" class="view-notif-btn text-sm bg-blue-600 text-white px-4 py-1.5 rounded-lg hover:bg-blue-700 transition-all">Voir</button>
					</div>
				</div>
			`;
			
			const markAsRead = async () => {
				try {
					await apiRequest('/notifications/read', {
						method: 'POST',
						body: JSON.stringify({ ids: [notif.id] }),
					});
					card.classList.remove('unread');
					const dot = card.querySelector('.pulse-dot');
					if (dot) dot.remove();
					if (badge) {
						const unread = document.querySelectorAll('.notif-card.unread').length;
						badge.textContent = String(unread);
					}
				} catch (e) {
					console.error("Error marking notification as read", e);
				}
			};

			card.addEventListener('click', (event) => {
				if (event.target.closest('.view-notif-btn')) return;
				markAsRead();
			});

			card.querySelector('.view-notif-btn')?.addEventListener('click', (event) => {
				event.preventDefault();
				event.stopPropagation();
				markAsRead();
				const targetRoute = card.dataset.route || route;
				if (targetRoute) {
					window.location.assign(targetRoute);
				}
			});
			
			notifContainer.appendChild(card);
		});
	}

	function getNotificationRoute(type) {
		switch (type) {
			case 'NEW_MESSAGE':
			case 'MATCH_ACCEPTED':
			case 'MATCH_REJECTED':
				return 'message.html';
			case 'NEW_MATCH':
				return 'matching-results.html';
			default:
				return 'mon-profile.html';
		}
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
			const unreadCards = Array.from(document.querySelectorAll('.notif-card.unread'));
			const unreadIds = unreadCards
				.map(card => card.dataset.notificationId)
				.filter(Boolean);

			try {
				await apiRequest('/notifications/read', {
					method: 'POST',
					body: JSON.stringify({ ids: unreadIds }),
				});
				unreadCards.forEach(card => {
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
