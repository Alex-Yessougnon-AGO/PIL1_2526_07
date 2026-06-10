import { fetchWithoutAuth, setTokens, clearTokens } from './api.js';

async function login(identifier, password) {
    const result = await fetchWithoutAuth('/auth/login', {
        method: 'POST',
        body: JSON.stringify({ identifier, password }),
    });

    if (result.ok && result.payload?.success) {
        const data = result.payload.data;
        setTokens(data);
        if (data.user?.id) {
            localStorage.setItem('user_id', data.user.id);
        }
        return { success: true, data };
    }

    return {
        success: false,
        message: result.payload?.message || 'Unable to sign in. Please try again.',
    };
}

async function register(registerData) {
    const result = await fetchWithoutAuth('/auth/register', {
        method: 'POST',
        body: JSON.stringify(registerData),
    });

    if (result.ok && result.payload?.success) {
        const data = result.payload.data;
        setTokens(data);
        // Check both data.user.id (login format) and data.user_id (alternative format)
        const userId = data.user?.id || data.user_id;
        if (userId) {
            localStorage.setItem('user_id', userId);
        }
        return { success: true, data };
    }

    return {
        success: false,
        message: result.payload?.message || 'Unable to register. Please check your input.',
    };
}

function logout() {
    clearTokens();
    localStorage.removeItem('user_id');
    window.location.href = 'login.html';
}

export { login, register, logout };