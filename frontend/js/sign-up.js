import { register } from './auth.js';

document.addEventListener('DOMContentLoaded', () => {
    initStepNavigation();
    initTagToggles();
    initFormSubmission();
});

function showError(message) {
    let errEl = document.getElementById('form-error');
    if (!errEl) {
        errEl = document.createElement('div');
        errEl.id = 'form-error';
        errEl.className = 'bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded-xl text-sm mb-4 hidden';
        // Important : insérer l'erreur dans le panneau principal (toujours visible),
        // PAS à l'intérieur d'une étape cachée !
        const container = document.querySelector('.flex-1.p-8') || document.querySelector('.flex-1') || document.querySelector('.space-y-5')?.parentNode;
        if (container) {
            container.insertBefore(errEl, container.firstChild);
        }
    }
    errEl.textContent = message;
    errEl.classList.remove('hidden');
    // Défiler jusqu'à l'erreur pour qu'elle soit visible
    errEl.scrollIntoView({ behavior: 'smooth', block: 'center' });
}

function hideError() {
    const errEl = document.getElementById('form-error');
    if (errEl) {
        errEl.classList.add('hidden');
        errEl.textContent = '';
    }
}

function initStepNavigation() {
    const steps = [
        { id: 'step1', next: 'nextToStep2', back: null, nextStep: 'step2' },
        { id: 'step2', next: 'nextToStep3', back: 'backToStep1', nextStep: 'step3' },
        { id: 'step3', next: 'nextToStep4', back: 'backToStep2bis', nextStep: 'step4' },
        { id: 'step4', next: null, back: 'backToStep3', nextStep: null },
    ];

    const progressSteps = document.querySelectorAll('[data-step-go]');
    const globalProgress = document.getElementById('globalProgress');
    const progressText = document.getElementById('progressText');
    let currentStep = 1;

    function updateProgress(step) {
        const pct = ((step - 1) / 3) * 100;
        if (globalProgress) globalProgress.style.width = pct + '%';
        if (progressText) progressText.textContent = Math.round(pct) + '% complété';
        progressSteps.forEach((el, idx) => {
            const num = idx + 1;
            const dot = el.querySelector('.progress-step');
            if (!dot) return;
            dot.classList.remove('active', 'completed');
            if (num === step) dot.classList.add('active');
            else if (num < step) dot.classList.add('completed');
        });
    }

    function goToStep(step) {
        steps.forEach((s, idx) => {
            const el = document.getElementById(s.id);
            if (!el) return;
            const num = idx + 1;
            el.classList.remove('active-step', 'hidden-step');
            if (num === step) {
                el.classList.add('active-step');
            } else {
                el.classList.add('hidden-step');
            }
        });
        currentStep = step;
        updateProgress(step);
    }

    steps.forEach((s, idx) => {
        const num = idx + 1;
        if (s.next) {
            const btn = document.getElementById(s.next);
            if (btn) {
                btn.addEventListener('click', (e) => {
                    e.preventDefault();
                    if (num === 1) {
                        const fullName = document.getElementById('fullName')?.value.trim();
                        const email = document.getElementById('email')?.value.trim();
                        const password = document.getElementById('password')?.value;
                        const terms = document.getElementById('termsCheckbox')?.checked;
                        hideError();
                        if (!fullName) { showError('Veuillez entrer votre nom complet'); return; }
                        if (!email) { showError('Veuillez entrer votre email'); return; }
                        if (!password || password.length < 8) { showError('Le mot de passe doit contenir au moins 8 caractères'); return; }
                        if (!terms) { showError('Vous devez accepter les conditions d\'utilisation'); return; }
                    }
                    goToStep(num + 1);
                });
            }
        }
        if (s.back) {
            const btn = document.getElementById(s.back);
            if (btn) {
                btn.addEventListener('click', (e) => {
                    e.preventDefault();
                    goToStep(num - 1);
                });
            }
        }
    });

    updateProgress(1);
}

function initTagToggles() {
    document.querySelectorAll('.tag-selectable').forEach(tag => {
        tag.addEventListener('click', () => {
            tag.classList.toggle('selected');
        });
    });

    const newMastery = document.getElementById('newMastery');
    if (newMastery) {
        newMastery.addEventListener('keydown', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                const val = newMastery.value.trim();
                if (val) {
                    const span = document.createElement('span');
                    span.className = 'tag-selectable mastery px-3 py-1.5 rounded-full text-sm font-medium border selected';
                    span.textContent = val;
                    span.addEventListener('click', () => span.classList.toggle('selected'));
                    document.getElementById('masteryTags')?.appendChild(span);
                    newMastery.value = '';
                }
            }
        });
    }

    const newNeed = document.getElementById('newNeed');
    if (newNeed) {
        newNeed.addEventListener('keydown', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                const val = newNeed.value.trim();
                if (val) {
                    const span = document.createElement('span');
                    span.className = 'tag-selectable need px-3 py-1.5 rounded-full text-sm font-medium border selected';
                    span.textContent = val;
                    span.addEventListener('click', () => span.classList.toggle('selected'));
                    document.getElementById('needsTags')?.appendChild(span);
                    newNeed.value = '';
                }
            }
        });
    }
}

async function initFormSubmission() {
    const submitBtn = document.getElementById('submitBtn');
    if (!submitBtn) return;

    submitBtn.addEventListener('click', async (e) => {
        e.preventDefault();
        hideError();

        const fullName = document.getElementById('fullName')?.value.trim() || '';
        const email = document.getElementById('email')?.value.trim() || '';
        const phone = document.getElementById('phone')?.value.trim() || '';
        const password = document.getElementById('password')?.value || '';
        const terms = document.getElementById('termsCheckbox')?.checked || false;

        if (!fullName) { showError('Veuillez entrer votre nom complet'); return; }
        if (!email) { showError('Veuillez entrer votre email'); return; }
        if (!password || password.length < 8) { showError('Le mot de passe doit contenir au moins 8 caractères'); return; }
        if (!terms) { showError('Vous devez accepter les conditions d\'utilisation'); return; }

        const nameParts = fullName.split(' ');
        const first_name = nameParts[0] || '';
        const last_name = nameParts.slice(1).join(' ') || '';

        if (!first_name || !last_name) { showError('Veuillez entrer votre prénom ET votre nom'); return; }

        submitBtn.disabled = true;
        submitBtn.innerHTML = '<span class="material-symbols-outlined animate-spin">sync</span> Inscription...';

        const result = await register({
            first_name,
            last_name,
            email,
            password,
            phone: phone || undefined,
            terms_accepted: terms,
        });

        if (result.success) {
            submitBtn.innerHTML = '<span class="material-symbols-outlined">check_circle</span> Réussi !';
            submitBtn.classList.remove('from-emerald-500', 'to-teal-600');
            submitBtn.classList.add('from-green-500', 'to-green-600');
            setTimeout(() => {
                window.location.href = 'dashboard.html';
            }, 1000);
        } else {
            showError(result.message || 'Échec de l\'inscription');
            submitBtn.disabled = false;
            submitBtn.innerHTML = '<span class="material-symbols-outlined text-base">rocket_launch</span> S\'inscrire';
        }
    });
}
