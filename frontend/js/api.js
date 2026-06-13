// --- Configuration ---
const API_PORT = '8001';
const API_HOST = window.location.hostname || 'localhost';
// Toujours utiliser http: pour les appels API, meme si la page est ouverte en file://
const API_BASE = `http://${API_HOST}:${API_PORT}/api/v1`;

// --- Token management ---
function getAccessToken() {
    return localStorage.getItem('access_token');
}

function getRefreshToken() {
    return localStorage.getItem('refresh_token');
}

function setTokens(tokens = {}) {
    if (tokens.access) {
        localStorage.setItem('access_token', tokens.access);
    }
    if (tokens.refresh) {
        localStorage.setItem('refresh_token', tokens.refresh);
    }
}

function clearTokens() {
    localStorage.removeItem('access_token');
    localStorage.removeItem('refresh_token');
    localStorage.removeItem('user_id');
    localStorage.removeItem('user_name');
    localStorage.removeItem('user_email');
}

// --- Auth guard ---
function requireAuth() {
    const token = getAccessToken();
    if (!token) {
        const publicPages = ['login.html', 'sign-up.html', 'password-reset.html'];
        const currentPage = window.location.pathname.split('/').pop();
        if (!publicPages.includes(currentPage) && !currentPage.includes('index')) {
            window.location.href = 'login.html';
            return false;
        }
    }
    return true;
}

async function safeJson(response) {
    try {
        return await response.json();
    } catch (error) {
        return null;
    }
}

async function request(endpoint, options = {}) {
    const response = await fetch(`${API_BASE}${endpoint}`, options);
    const payload = await safeJson(response);
    return {
        response,
        status: response.status,
        ok: response.ok,
        payload,
    };
}

async function fetchWithoutAuth(endpoint, options = {}) {
    const headers = {
        'Content-Type': 'application/json',
        ...options.headers,
    };

    return request(endpoint, {
        ...options,
        headers,
    });
}

async function refreshAccessToken() {
    const refreshToken = getRefreshToken();
    if (!refreshToken) {
        clearTokens();
        return null;
    }

    const result = await fetchWithoutAuth('/auth/refresh', {
        method: 'POST',
        body: JSON.stringify({ refresh: refreshToken }),
    });

    if (result.ok && result.payload?.success && result.payload.data) {
        setTokens(result.payload.data);
        return result.payload.data.access;
    }

    clearTokens();
    return null;
}

async function fetchWithAuth(endpoint, options = {}) {
    const accessToken = getAccessToken();
    const headers = {
        'Content-Type': 'application/json',
        ...options.headers,
    };

    if (accessToken) {
        headers.Authorization = `Bearer ${accessToken}`;
    }

    let result = await request(endpoint, {
        ...options,
        headers,
    });

    if (result.status === 401) {
        const refreshedAccess = await refreshAccessToken();
        if (refreshedAccess) {
            headers.Authorization = `Bearer ${refreshedAccess}`;
            result = await request(endpoint, {
                ...options,
                headers,
            });
        }
    }

    return result;
}

/**
 * Unified API request function.
 * Handles both normal responses { success, data } and paginated responses { success, data, count, next, previous }.
 * Returns: { success, data, message?, count?, next?, previous?, status }
 */
async function apiRequest(endpoint, options = {}) {
    const result = await fetchWithAuth(endpoint, options);
    const payload = result.payload || {};
    const data = payload.data !== undefined ? payload.data : (payload.results !== undefined ? payload.results : payload);

    if (payload.success === true || result.ok) {
        return {
            success: true,
            data,
            results: payload.results ?? data,
            message: payload.message,
            count: payload.count ?? (Array.isArray(data) ? data.length : undefined),
            next: payload.next,
            previous: payload.previous,
            status: result.status,
            ok: result.ok,
        };
    }

    return {
        success: result.ok,
        data,
        results: payload.results ?? data,
        message: payload.message,
        count: payload.count,
        next: payload.next,
        previous: payload.previous,
        status: result.status,
        ok: result.ok,
    };
}

function buildWebSocketUrl(conversationId) {
    const host = API_HOST;
    const token = encodeURIComponent(getAccessToken() || '');
    // Toujours utiliser ws: pour les WebSockets (le backend ne supporte pas WSS)
    return `ws://${host}:${API_PORT}/ws/chat/${conversationId}?token=${token}`;
}

/**
 * Update sidebar notification badge with unread count from notifications AND conversations.
 */
async function updateBadgeCount() {
    try {
        // Count unread notifications
        const notifs = await apiRequest('/notifications');
        const unreadNotifs = (notifs.data || []).filter(n => !n.is_read).length;
        // Count conversations with unread messages (messages not read by current user)
        let unreadMessages = 0;
        try {
            const convs = await apiRequest('/conversations');
            if (convs.success) {
                const convList = convs.data || convs.results || [];
                const currentUserId = localStorage.getItem('user_id');
                convList.forEach(conv => {
                    if (conv.last_message && String(conv.last_message.sender_id) !== String(currentUserId) && !conv.last_message.read_at) {
                        unreadMessages++;
                    }
                });
            }
        } catch (_) {}
        const total = unreadNotifs + unreadMessages;
        document.querySelectorAll('.sidebar-item .ml-auto, .sidebar-item .bg-blue-100.text-blue-700').forEach(el => {
            el.textContent = total > 0 ? String(total) : '0';
        });
    } catch (_) {}
}

/**
 * Centralized header/user info update.
 * Call this on every page to ensure the header shows the actual logged-in user.
 */
async function updateUserHeader() {
    try {
        const res = await apiRequest('/me');
        if (res.success) {
            const data = res.data || {};
            const user = data.user || {};
            const name = `${user.first_name || ''} ${user.last_name || ''}`.trim() || 'Utilisateur';
            const level = data.academic_level ? `Étudiant ${data.academic_level}` : '';
            const avatarUrl = data.profile_photo || `https://ui-avatars.com/api/?name=${encodeURIComponent((user.first_name||'') + '+' + (user.last_name||''))}&background=2563EB&color=fff&size=80`;

            // Update header name (try multiple selectors)
            const headerName = document.querySelector('header .text-sm.font-semibold.text-slate-800, header .font-semibold.text-slate-800');
            if (headerName) headerName.textContent = name;

            // Update header level
            const headerLevel = document.querySelector('header .text-xs.text-slate-500');
            if (headerLevel) headerLevel.textContent = level;

            // Update header avatar
            const headerImg = document.querySelector('header img.rounded-full, header img.w-9.h-9, header img.w-10.h-10');
            if (headerImg) {
                headerImg.src = avatarUrl;
            }
        }
    } catch (e) {
        console.warn('Could not load user header', e);
    }

    // Always update badge count
    await updateBadgeCount();
}

// Start periodic badge polling (every 30 seconds) after DOMContentLoaded
let badgePollInterval = null;
function startBadgePolling() {
    if (badgePollInterval) clearInterval(badgePollInterval);
    badgePollInterval = setInterval(() => {
        updateBadgeCount();
    }, 30000);
}

if (typeof document !== 'undefined') {
    document.addEventListener('DOMContentLoaded', () => {
        startBadgePolling();
    });
}

// Export for ES module usage
export {
    API_BASE,
    fetchWithAuth,
    fetchWithoutAuth,
    setTokens,
    clearTokens,
    getAccessToken,
    getRefreshToken,
    apiRequest,
    buildWebSocketUrl,
    requireAuth,
    updateUserHeader,
};
