import { login } from './auth.js';

document.addEventListener('DOMContentLoaded', () => {
    const passwordInput = document.getElementById('password');
    const wrapper = passwordInput.parentElement;

    const toggleBtn = document.createElement('button');
    toggleBtn.type = 'button';
    toggleBtn.className = 'absolute right-sm top-1/2 -translate-y-1/2 text-outline hover:text-primary transition-colors';
    toggleBtn.innerHTML = '<span class="material-symbols-outlined text-[20px]">visibility</span>';

    toggleBtn.addEventListener('click', () => {
        const isPassword = passwordInput.type === 'password';
        passwordInput.type = isPassword ? 'text' : 'password';
        toggleBtn.innerHTML = `<span class="material-symbols-outlined text-[20px]">${isPassword ? 'visibility_off' : 'visibility'}</span>`;
    });

    wrapper.appendChild(toggleBtn);
    passwordInput.classList.add('pr-[44px]');

    const binaryContainer = document.querySelector('.fixed.bottom-0');
    window.addEventListener('mousemove', (e) => {
        const x = e.clientX / window.innerWidth;
        const y = e.clientY / window.innerHeight;
        binaryContainer.style.transform = `translate(${x * 10}px, ${y * 10}px)`;
    });

    const loginForm = document.getElementById('login-form');
    if (loginForm) {
        loginForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            const submitBtn = loginForm.querySelector('button[type="submit"]');
            if (submitBtn) {
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<span class="material-symbols-outlined animate-spin">sync</span> connecting...';
            }

            const formData = new FormData(loginForm);
            const credentials = {
                identifier: formData.get('identifier'),
                password: formData.get('password'),
            };

            try {
                const result = await login(credentials.identifier, credentials.password);
                if (result.success) {
                    window.location.href = 'dashboard.html';
                } else {
                    alert(result.message || 'Login failed');
                }
            } catch (error) {
                alert('Error connecting to server');
            } finally {
                if (submitBtn) {
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = 'Login';
                }
            }
        });
    }
});
