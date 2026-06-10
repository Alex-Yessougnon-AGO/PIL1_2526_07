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

	let currentConversation = null;
	let chatSocket = null;
	const currentUserId = localStorage.getItem('user_id');

	async function loadConversations() {
		try {
			const res = await apiRequest('/conversations');
			if (res.success && res.data && res.data.length > 0) {
				renderConversations(res.data);
			} else {
				if (conversationItems) {
					conversationItems.innerHTML = '<div class="p-md flex items-center justify-center text-center py-8"><div><span class="material-symbols-outlined text-4xl text-outline mb-2">chat</span><p class="text-label-md text-outline">Aucune conversation pour le moment.</p></div></div>';
				}
			}
		} catch (error) {
			console.error('Error loading conversations', error);
			if (conversationItems) {
				conversationItems.innerHTML = '<div class="p-md flex items-center justify-center text-center py-8"><div><span class="material-symbols-outlined text-4xl text-outline mb-2">error</span><p class="text-label-md text-outline">Erreur de chargement.</p></div></div>';
			}
		}
	}

	function getConversationTitle(conv) {
		const other = (conv.members || []).find(member => String(member.id) !== String(currentUserId));
		return other ? `${other.first_name || ''} ${other.last_name || ''}`.trim() : 'Conversation';
	}

	function getConversationPreview(conv) {
		return conv.last_message?.content || 'Démarrer une conversation...';
	}

	function renderConversations(convs) {
		if (!conversationItems) return;
		conversationItems.innerHTML = '';

		convs.forEach(conv => {
			const other = (conv.members || []).find(member => String(member.id) !== String(currentUserId)) || conv.members?.[0] || {};
			const item = document.createElement('button');
			item.type = 'button';
			item.className = 'w-full text-left p-4 hover:bg-surface-container transition-all border-b border-outline-variant flex gap-3 items-start';
			item.innerHTML = `
				<div class="relative flex-shrink-0">
					<img class="w-12 h-12 rounded-full object-cover" src="${other.profile_photo || 'https://ui-avatars.com/api/?name=' + encodeURIComponent((other.first_name||'') + '+' + (other.last_name||'')) + '&background=2563EB&color=fff&size=48'}" alt="avatar" />
					<span class="absolute bottom-0 right-0 w-3.5 h-3.5 bg-secondary border-2 border-surface-container-lowest rounded-full"></span>
				</div>
				<div class="flex-1 min-w-0">
					<div class="flex justify-between items-start mb-1">
						<p class="font-semibold text-slate-800 truncate">${getConversationTitle(conv)}</p>
						<span class="text-[10px] text-slate-400">${conv.last_message ? "Aujourd'hui" : 'Aucun message'}</span>
					</div>
					<p class="text-sm text-slate-500 truncate">${getConversationPreview(conv)}</p>
					${conv.last_message ? `<span class="text-[10px] text-slate-400">${new Date(conv.last_message.created_at).toLocaleDateString()}</span>` : ''}
				</div>
			`;
			item.addEventListener('click', () => selectConversation(conv));
			conversationItems.appendChild(item);
		});
	}

	async function selectConversation(conv) {
		currentConversation = conv;
		if (threadTitle) threadTitle.innerText = getConversationTitle(conv);
		if (threadStatus) threadStatus.innerHTML = `<span class="w-2 h-2 rounded-full bg-secondary"></span> En ligne`;
		if (window.innerWidth < 768 && conversationListContainer && chatPanel) {
			conversationListContainer.classList.add('hidden');
			chatPanel.classList.remove('hidden');
			chatPanel.classList.add('flex');
		}

		await loadMessages(conv.id);
		chatSocket = connectToConversation(conv.id, {
			onMessage: handleSocketMessage,
			onOpen: () => console.log('Chat socket connected'),
			onClose: () => console.log('Chat socket disconnected'),
			onError: (error) => console.error('Chat socket error', error),
		});
	}

	async function loadMessages(conversationId) {
		if (!messagesContainer) return;
		try {
			const res = await apiRequest(`/messages?conversation=${conversationId}`);
			if (res.success) {
				const msgs = res.data.results || res.data || [];
				renderMessages(msgs);
			} else {
				messagesContainer.innerHTML = '<div class="flex flex-col items-center justify-center h-full text-center p-8"><span class="material-symbols-outlined text-5xl text-outline mb-3">error</span><p class="text-body-md text-outline">Erreur de chargement des messages.</p></div>';
			}
		} catch (error) {
			console.error('Error loading messages', error);
			messagesContainer.innerHTML = '<div class="flex flex-col items-center justify-center h-full text-center p-8"><span class="material-symbols-outlined text-5xl text-outline mb-3">error</span><p class="text-body-md text-outline">Erreur de connexion.</p></div>';
		}
	}

	function renderMessages(messages) {
		if (!messagesContainer) return;
		messagesContainer.innerHTML = '';
		if (!messages || messages.length === 0) {
			messagesContainer.innerHTML = '<div class="flex flex-col items-center justify-center h-full text-center p-8"><span class="material-symbols-outlined text-5xl text-outline mb-3">forum</span><p class="text-body-md text-outline">Aucun message. Envoyez le premier message !</p></div>';
			return;
		}
		messages.forEach(msg => appendMessage(msg));
		messagesContainer.scrollTop = messagesContainer.scrollHeight;
	}

	function appendMessage(msg) {
		if (!messagesContainer) return;
		const isMe = String(msg.sender_id) === String(currentUserId);
		const wrapper = document.createElement('div');
		wrapper.className = `flex ${isMe ? 'justify-end' : 'justify-start'} mb-4`;
		wrapper.innerHTML = `
			<div class="max-w-[70%] p-3 rounded-2xl ${isMe ? 'bg-primary text-on-primary rounded-tr-none' : 'bg-surface-container-high text-on-surface rounded-tl-none'}">
				<p class="text-sm">${msg.content}</p>
				<span class="text-[10px] ${isMe ? 'text-primary/70' : 'text-slate-500'} block text-right mt-1">${new Date(msg.created_at).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</span>
			</div>
		`;
		messagesContainer.appendChild(wrapper);
		messagesContainer.scrollTop = messagesContainer.scrollHeight;
	}

	function handleSocketMessage(event) {
		if (!event) return;
		// Le backend envoie: { type: "chat.message", event: "MESSAGE_RECEIVED", message: {...} }
		// On verifie event.event ET event.type pour couvrir les deux formats
		const received = event.event === 'MESSAGE_RECEIVED' || event.type === 'MESSAGE_RECEIVED';
		if (received && event.message) {
			appendMessage(event.message);
		}
	}

	if (messageForm) {
		messageForm.addEventListener('submit', async (e) => {
			e.preventDefault();
			if (!currentConversation || !messageInput || !messageInput.value.trim()) return;

			const content = messageInput.value.trim();
			messageInput.value = '';

			try {
				sendChatSocketMessage(content);
				appendMessage({ sender_id: currentUserId, content, created_at: new Date().toISOString() });
			} catch (error) {
				console.error('WebSocket send failed', error);
				alert('Unable to send message right now.');
			}
		});
	}

	if (messageInput) {
		messageInput.addEventListener('keydown', (e) => {
			if (e.key === 'Enter' && !e.shiftKey) {
				e.preventDefault();
				messageForm?.requestSubmit();
			}
		});
	}

	if (backBtn) {
		backBtn.addEventListener('click', () => {
			if (chatPanel && conversationListContainer) {
				chatPanel.classList.add('hidden');
				chatPanel.classList.remove('flex');
				conversationListContainer.classList.remove('hidden');
			}
			disconnectChatSocket();
		});
	}

	window.addEventListener('resize', () => {
		if (window.innerWidth >= 768 && conversationListContainer) {
			conversationListContainer.classList.remove('hidden');
		}
	});

	await loadConversations();
});
