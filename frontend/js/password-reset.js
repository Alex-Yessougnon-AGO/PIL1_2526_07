import { fetchWithoutAuth } from './api.js';

document.addEventListener('DOMContentLoaded', () => {
	const resetForm = document.getElementById('reset-form');
	const resendBtn = document.getElementById('resend-link');
	const card = document.getElementById('reset-card');

	if (resetForm) {
		resetForm.addEventListener('submit', handleReset);
	}

	if (resendBtn) {
		resendBtn.addEventListener('click', async () => {
			const email = document.getElementById('display-email')?.innerText || '';
			if (!email) return;
			await sendResetLink(email);
		});
	}

	if (card) {
		document.addEventListener('mousemove', (e) => {
			if (window.innerWidth > 768) {
				const rect = card.getBoundingClientRect();
				const x = e.clientX - rect.left;
				const y = e.clientY - rect.top;

				const centerX = rect.width / 2;
				const centerY = rect.height / 2;

				const rotateX = (y - centerY) / 30;
				const rotateY = (centerX - x) / 30;

				card.style.transform = `perspective(1000px) rotateX(${rotateX}deg) rotateY(${rotateY}deg)`;
			}
		});

		card.addEventListener('mouseleave', () => {
			card.style.transform = `perspective(1000px) rotateX(0deg) rotateY(0deg)`;
		});
	}
});

async function sendResetLink(email) {
	const initial = document.getElementById('initial-state');
	const success = document.getElementById('success-state');
	const displayEmail = document.getElementById('display-email');
	const card = document.getElementById('reset-card');
	const submitBtn = document.querySelector('#reset-form button[type="submit"]');

	if (submitBtn) {
		submitBtn.innerHTML = `<span class="material-symbols-outlined animate-spin">refresh</span>`;
		submitBtn.disabled = true;
	}

	try {
		const res = await fetchWithoutAuth('/auth/request-reset', {
			method: 'POST',
			body: JSON.stringify({ email }),
		});

		if (res.ok && res.payload?.success) {
			if (displayEmail) displayEmail.innerText = email;
			if (initial) initial.classList.add('hidden');
			if (success) success.classList.remove('hidden');
			if (card) {
				card.classList.remove('border-outline-variant');
				card.classList.add('border-secondary');
			}
		} else {
			alert(res.payload?.message || 'Error requesting reset link');
		}
	} catch (e) {
		alert('Error connecting to server');
	} finally {
		if (submitBtn) {
			submitBtn.disabled = false;
			submitBtn.innerHTML = 'Send Reset Link';
		}
	}
}

async function handleReset(event) {
	event.preventDefault();
	const email = document.getElementById('email').value.trim();
	if (!email) return;
	await sendResetLink(email);
}
