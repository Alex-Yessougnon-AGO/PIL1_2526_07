import { apiRequest, requireAuth, updateUserHeader } from './api.js';
import { connectToConversation, disconnectChatSocket, sendChatSocketMessage } from './chat.js';

document.addEventListener('DOMContentLoaded', async () => {
	if (!requireAuth()) return;
	await updateUserHeader();

	const conversationItems = document.getElementById('conversation-items');
	const conversationListContainer = document.getElementById('conversation-list');
	const chatPanel = document.getElementById('chat-thread');
	const backBtn = document.getElementById('back-button');
	const messageForm = document.getElementById('message-form');
	const messagesContainer = document.getElementById('messages-container');
	const threadTitle = document.getElementById('thread-title');
	const threadStatus = document.getElementById('thread-status');
	const messageInput = document.getElementById('message-input');
	const threadAvatar = document.getElementById('thread-avatar');
	const threadHeader = document.getElementById('thread-header');
	const searchInput = document.querySelector('#conversation-list input[type="text"]');

	let currentConversation = null;
	let chatSocket = null;
	let refreshInterval = null;
	const currentUserId = localStorage.getItem('user_id');
	let conversationList = [];

	// Read query params
	const params = new URLSearchParams(window.location.search);
	const targetUserId = params.get('userId');
	const targetConversationId = params.get('conversationId');

	async function loadConversations() {
		try {
			const res = await apiRequest('/conversations');
			if (res.success) {
				const convs = res.data || res.results || [];
				conversationList = convs;
				if (convs.length > 0) {
					renderConversations(convs);
				} else {
					if (conversationItems) {
						conversationItems.innerHTML = '<div class="p-md flex items-center justify-center text-center py-8"><div><span class="material-symbols-outlined text-4xl text-outline mb-2">chat</span><p class="text-label-md text-outline">Aucune conversation pour le moment.</p></div></div>';
					}
				}
			}
		} catch (error) {
			console.error('Error loading conversations', error);
			if (conversationItems) {
				conversationItems.innerHTML = '<div class="p-md flex items-center justify-center text-center py-8"><div><span class="material-symbols-outlined text-4xl text-outline mb-2">error</span><p class="text-label-md text-outline">Erreur de chargement.</p></div></div>';
			}
		}
	}

	function getOtherMember(conv) {
		return (conv.members || []).find(m => String(m.id) !== String(currentUserId)) || conv.members?.[0] || {};
	}

	function getConversationTitle(conv) {
		const other = getOtherMember(conv);
		return other ? `${other.first_name || ''} ${other.last_name || ''}`.trim() || 'Conversation' : 'Conversation';
	}

	function getConversationPreview(conv) {
		if (!conv.last_message) return 'Démarrer une conversation...';
		const prefix = String(conv.last_message.sender_id) === String(currentUserId) ? 'Vous: ' : '';
		return prefix + (conv.last_message.content?.substring(0, 60) || '');
	}

	function getConversationTime(conv) {
		if (!conv.last_message?.created_at) return '';
		const d = new Date(conv.last_message.created_at);
		const now = new Date();
		const diffDays = Math.floor((now - d) / (1000 * 60 * 60 * 24));
		if (diffDays === 0) return d.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
		if (diffDays === 1) return 'Hier';
		if (diffDays < 7) return d.toLocaleDateString([], { weekday: 'short' });
		return d.toLocaleDateString([], { day: 'numeric', month: 'short' });
	}

	function renderConversations(convs) {
		if (!conversationItems) return;
		const searchTerm = searchInput?.value?.toLowerCase().trim() || '';
		conversationItems.innerHTML = '';

		convs.forEach(conv => {
			const other = getOtherMember(conv);
			const title = getConversationTitle(conv);
			if (searchTerm && !title.toLowerCase().includes(searchTerm)) return;

			const item = document.createElement('button');
			item.type = 'button';
			item.dataset.convId = conv.id;
			const isSelected = currentConversation && String(conv.id) === String(currentConversation.id);
			item.className = `w-full text-left p-4 hover:bg-surface-container transition-all border-b border-outline-variant flex gap-3 items-start ${isSelected ? 'bg-surface-container-high' : ''}`;
			item.innerHTML = `
				<div class="relative flex-shrink-0">
					<img class="w-12 h-12 rounded-full object-cover" src="${other.profile_photo || 'https://ui-avatars.com/api/?name=' + encodeURIComponent((other.first_name||'') + '+' + (other.last_name||'')) + '&background=005fac&color=fff&size=48'}" alt="avatar" />
					<span class="absolute bottom-0 right-0 w-3 h-3 bg-secondary border-2 border-surface-container-lowest rounded-full"></span>
				</div>
				<div class="flex-1 min-w-0">
					<div class="flex justify-between items-center mb-0.5">
						<p class="font-semibold text-on-surface truncate text-sm">${title}</p>
						<span class="text-[11px] text-outline flex-shrink-0 ml-2">${getConversationTime(conv)}</span>
					</div>
					<p class="text-xs text-on-surface-variant truncate">${getConversationPreview(conv)}</p>
				</div>
			`;
			item.addEventListener('click', () => selectConversation(conv.id));
			conversationItems.appendChild(item);
		});

		if (conversationItems.children.length === 0) {
			conversationItems.innerHTML = '<div class="p-md flex items-center justify-center text-center py-8"><div><span class="material-symbols-outlined text-4xl text-outline mb-2">search_off</span><p class="text-label-md text-outline">Aucun résultat</p></div></div>';
		}
	}

	async function selectConversation(convId) {
		// Find conversation in our list or fetch it
		let conv = conversationList.find(c => String(c.id) === String(convId));
		if (!conv) {
			try {
				const res = await apiRequest(`/conversations/${convId}`);
				if (res.success) conv = res.data;
			} catch (e) {
				console.error('Error fetching conversation', e);
				return;
			}
		}
		if (!conv) return;

		currentConversation = conv;
		const other = getOtherMember(conv);

		// Show header and form now that a conversation is selected
		if (threadHeader) threadHeader.classList.remove('hidden');
		if (messageForm) messageForm.classList.remove('hidden');

		if (threadTitle) threadTitle.innerText = getConversationTitle(conv);
		if (threadStatus) threadStatus.innerHTML = `<span class="w-2 h-2 rounded-full bg-secondary"></span> En ligne`;
		if (threadAvatar) {
			threadAvatar.src = other.profile_photo || `https://ui-avatars.com/api/?name=${encodeURIComponent((other.first_name||'') + '+' + (other.last_name||''))}&background=005fac&color=fff&size=40`;
		}

		// Update URL without reload
		const url = new URL(window.location);
		url.searchParams.set('conversationId', conv.id);
		url.searchParams.delete('userId');
		window.history.replaceState({}, '', url);

		// Mobile view
		if (window.innerWidth < 768 && conversationListContainer && chatPanel) {
			conversationListContainer.classList.add('hidden');
			chatPanel.classList.remove('hidden');
			chatPanel.classList.add('flex');
		}

		// Highlight selected
		document.querySelectorAll('[data-conv-id]').forEach(el => {
			el.classList.toggle('bg-surface-container-high', String(el.dataset.convId) === String(conv.id));
		});

		await loadMessages(conv.id);
		chatSocket = connectToConversation(conv.id, {
			onMessage: handleSocketMessage,				onOpen: () => {
				console.log('Chat socket connected');
				// Send READ signal to mark all messages from other users as read
				if (chatSocket && chatSocket.readyState === WebSocket.OPEN) {
					chatSocket.send(JSON.stringify({ type: 'READ' }));
				}
				// Recharger les messages pour voir read_at mis à jour
				setTimeout(() => loadMessages(conv.id), 300);
			},
			onClose: () => console.log('Chat socket disconnected'),
			onError: (error) => console.error('Chat socket error', error),
		});
	}

	async function loadMessages(conversationId) {
		if (!messagesContainer) return;
		messagesContainer.innerHTML = '<div class="flex items-center justify-center h-full"><span class="material-symbols-outlined text-4xl text-outline animate-spin">progress_activity</span></div>';
		try {
			const res = await apiRequest(`/messages?conversation=${conversationId}`);
			if (res.success) {
				const msgs = res.data?.results || res.data || [];
				renderMessages(msgs);
			} else {
				messagesContainer.innerHTML = '<div class="flex flex-col items-center justify-center h-full text-center p-8"><span class="material-symbols-outlined text-5xl text-outline mb-3">error</span><p class="text-body-md text-outline">Erreur de chargement des messages.</p></div>';
			}
		} catch (error) {
			console.error('Error loading messages', error);
			messagesContainer.innerHTML = '<div class="flex flex-col items-center justify-center h-full text-center p-8"><span class="material-symbols-outlined text-5xl text-outline mb-3">error</span><p class="text-body-md text-outline">Erreur de connexion.</p></div>';
		}
	}

	function formatMessageDate(dateStr) {
		const d = new Date(dateStr);
		const now = new Date();
		const diffDays = Math.floor((now - d) / (1000 * 60 * 60 * 24));
		if (diffDays === 0) return "Aujourd'hui";
		if (diffDays === 1) return 'Hier';
		return d.toLocaleDateString([], { weekday: 'long', day: 'numeric', month: 'long' });
	}

	function shouldShowDateSeparator(msg, prevMsg) {
		if (!prevMsg) return true;
		const d1 = new Date(msg.created_at);
		const d2 = new Date(prevMsg.created_at);
		return d1.toDateString() !== d2.toDateString();
	}

	function renderMessages(messages) {
		if (!messagesContainer) return;
		messagesContainer.innerHTML = '';
		if (!messages || messages.length === 0) {
			messagesContainer.innerHTML = '<div class="flex flex-col items-center justify-center h-full text-center p-8"><span class="material-symbols-outlined text-5xl text-outline mb-3">forum</span><p class="text-body-md text-outline">Aucun message. Envoyez le premier message !</p></div>';
			return;
		}
		let prevMsg = null;
		messages.forEach(msg => {
			if (shouldShowDateSeparator(msg, prevMsg)) {
				const sep = document.createElement('div');
				sep.className = 'flex justify-center my-4';
				sep.innerHTML = `<span class="text-[11px] text-outline bg-surface-container-lowest px-3 py-1 rounded-full">${formatMessageDate(msg.created_at)}</span>`;
				messagesContainer.appendChild(sep);
			}
			appendMessage(msg);
			prevMsg = msg;
		});
		messagesContainer.scrollTop = messagesContainer.scrollHeight;
	}

	function appendMessage(msg) {
		if (!messagesContainer) return;
		const isMe = String(msg.sender_id || msg.sender?.id) === String(currentUserId);
		const wrapper = document.createElement('div');
		wrapper.className = `flex ${isMe ? 'justify-end' : 'justify-start'} mb-2 px-gutter`;
		const time = msg.created_at
			? new Date(msg.created_at).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
			: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

		wrapper.innerHTML = `
			<div class="max-w-[75%] md:max-w-[60%] p-3 rounded-2xl ${isMe ? 'bg-primary text-on-primary rounded-br-sm' : 'bg-surface-container-high text-on-surface rounded-bl-sm'}">
				<p class="text-sm leading-relaxed">${escapeHtml(msg.content)}</p>
				<div class="flex items-center justify-end gap-1 mt-1">
					<span class="text-[10px] ${isMe ? 'text-primary/70' : 'text-outline'}">${time}</span>
					${isMe ? `<span class="material-symbols-outlined text-[14px] ${msg.read_at ? 'text-on-primary' : 'text-primary/50'}">${msg.read_at ? 'done_all' : 'done'}</span>` : ''}
				</div>
			</div>
		`;
		messagesContainer.appendChild(wrapper);
		messagesContainer.scrollTop = messagesContainer.scrollHeight;
	}

	function escapeHtml(text) {
		const div = document.createElement('div');
		div.textContent = text;
		return div.innerHTML;
	}

	function handleSocketMessage(event) {
		if (!event) return;
		const received = event.event === 'MESSAGE_RECEIVED' || event.type === 'MESSAGE_RECEIVED';
		if (received && event.message) {
			appendMessage(event.message);
			// Refresh conversation list to update preview
			loadConversations();
		}
	}

	// Handle message form submit
	if (messageForm) {
		messageForm.addEventListener('submit', async (e) => {
			e.preventDefault();
			if (!currentConversation || !messageInput || !messageInput.value.trim()) return;

			const content = messageInput.value.trim();
			messageInput.value = '';
			messageInput.style.height = 'auto';

			try {
				if (!chatSocket || chatSocket.readyState !== WebSocket.OPEN) {
					// Fallback: send via REST API
					await apiRequest('/messages', {
						method: 'POST',
						body: JSON.stringify({ conversation_id: currentConversation.id, content }),
					});
					await loadMessages(currentConversation.id);
					loadConversations();
					return;
				}
				sendChatSocketMessage(content);
			} catch (error) {
				console.error('Send failed', error);
			}
		});
	}

	// Enter to send, Shift+Enter for newline
	if (messageInput) {
		messageInput.addEventListener('keydown', (e) => {
			if (e.key === 'Enter' && !e.shiftKey) {
				e.preventDefault();
				messageForm?.requestSubmit();
			}
		});
		messageInput.addEventListener('input', () => {
			messageInput.style.height = 'auto';
			messageInput.style.height = Math.min(messageInput.scrollHeight, 128) + 'px';
		});
	}

	// Back button (mobile)
	if (backBtn) {
		backBtn.addEventListener('click', () => {
			if (chatPanel && conversationListContainer) {
				chatPanel.classList.add('hidden');
				chatPanel.classList.remove('flex');
				conversationListContainer.classList.remove('hidden');
			}
			if (threadHeader) threadHeader.classList.add('hidden');
			if (messageForm) messageForm.classList.add('hidden');
			currentConversation = null;
			disconnectChatSocket();
			// Clear conversationId from URL
			const url = new URL(window.location);
			url.searchParams.delete('conversationId');
			url.searchParams.delete('userId');
			window.history.replaceState({}, '', url);
		});
	}

	// Responsive handling
	window.addEventListener('resize', () => {
		if (window.innerWidth >= 768 && conversationListContainer) {
			conversationListContainer.classList.remove('hidden');
		}
	});

	// Search/filter conversations
	if (searchInput) {
		searchInput.addEventListener('input', () => {
			renderConversations(conversationList);
		});
	}

	// Refresh conversation list periodically
	function startRefreshInterval() {
		if (refreshInterval) clearInterval(refreshInterval);
		refreshInterval = setInterval(() => {
			loadConversations();
		}, 5000);
	}

	// === INITIALIZATION ===

	// Step 1: Load conversations first
	await loadConversations();

	// Step 2: Handle query params
	if (targetConversationId) {
		await selectConversation(targetConversationId);
	} else if (targetUserId) {
		// Auto-create/get conversation with the specified user
		try {
			// Check if conversation already exists
			let foundConv = null;
			for (const conv of conversationList) {
				const other = getOtherMember(conv);
				if (String(other.id) === String(targetUserId)) {
					foundConv = conv;
					break;
				}
			}
			if (foundConv) {
				await selectConversation(foundConv.id);
			} else {
				const res = await apiRequest('/conversations', {
					method: 'POST',
					body: JSON.stringify({ user_id: targetUserId }),
				});
				if (res.success) {
					const convId = res.data?.conversation_id || res.data?.data?.id || res.data?.id;
					if (convId) {
						await loadConversations();
						await selectConversation(convId);
					}
				}
			}
		} catch (e) {
			console.error('Error auto-creating conversation', e);
		}
	}

	startRefreshInterval();
});
