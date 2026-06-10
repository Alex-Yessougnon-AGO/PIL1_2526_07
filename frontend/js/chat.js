import { buildWebSocketUrl } from './api.js';

let socket = null;

export function connectToConversation(conversationId, callbacks = {}) {
    disconnectChatSocket();

    const wsUrl = buildWebSocketUrl(conversationId);
    socket = new WebSocket(wsUrl);

    socket.addEventListener('open', () => {
        callbacks.onOpen?.();
    });

    socket.addEventListener('message', (event) => {
        try {
            const payload = JSON.parse(event.data);
            callbacks.onMessage?.(payload);
        } catch (error) {
            console.error('Invalid WebSocket message', error);
        }
    });

    socket.addEventListener('close', () => {
        callbacks.onClose?.();
        socket = null;
    });

    socket.addEventListener('error', (error) => {
        callbacks.onError?.(error);
    });

    return socket;
}

export function disconnectChatSocket() {
    if (socket && socket.readyState !== WebSocket.CLOSED) {
        socket.close();
    }
    socket = null;
}

export function sendChatSocketMessage(content) {
    if (!socket || socket.readyState !== WebSocket.OPEN) {
        throw new Error('WebSocket is not connected');
    }

    const payload = {
        type: 'SEND_MESSAGE',
        content,
    };

    socket.send(JSON.stringify(payload));
}
