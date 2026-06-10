import { apiRequest, requireAuth, updateUserHeader } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
    if (!requireAuth()) return;
    await updateUserHeader();

    const params = new URLSearchParams(window.location.search);
    const userId = params.get('id');

    if (!userId) {
        const main = document.querySelector('main');
        if (main) main.innerHTML = '<div class="p-8 text-center py-12"><div class="max-w-md mx-auto"><span class="material-symbols-outlined text-5xl text-slate-300 mb-4">person_off</span><h2 class="text-xl font-bold text-slate-700 mb-2">Profil non trouvé</h2><p class="text-slate-500 mb-6">Aucun identifiant utilisateur fourni. Veuillez sélectionner un profil depuis la liste des résultats.</p><a href="feed-ifri.html" class="inline-block px-6 py-2.5 bg-blue-600 text-white font-semibold rounded-xl hover:bg-blue-700 transition-all">Explorer les profils</a></div></div>';
        return;
    }

    try {
        const res = await apiRequest(`/profiles/${userId}`);
        if (res.success) {
            const data = res.data;
            const user = data.user || {};

            // Page title
            document.title = `MentorLink | Profil de ${user.first_name || ''} ${user.last_name || ''}`;

            // Update name
            document.querySelectorAll('h1, .text-3xl').forEach(el => {
                el.textContent = `${user.first_name || ''} ${user.last_name || ''}`.trim();
            });

            // Update header subtitle (department + level)
            const subtitle = document.querySelector('.text-blue-600.font-semibold, .text-slate-500.text-sm');
            if (subtitle) {
                subtitle.textContent = `${data.department || ''}${data.department && data.academic_level ? ' • ' : ''}${data.academic_level || ''}`;
            }

            // Update bio
            const bio = document.querySelector('.text-slate-600.leading-relaxed');
            if (bio) bio.textContent = data.bio || 'Aucune biographie fournie.';

            // Update avatars
            const nameEncoded = encodeURIComponent((user.first_name||'') + '+' + (user.last_name||''));
            document.querySelectorAll('img').forEach(img => {
                if (img.classList.contains('rounded-full') || img.classList.contains('rounded-2xl')) {
                    // Skip decorative / unsplash images
                    if (img.src.includes('unsplash')) return;
                    img.src = data.profile_photo || `https://ui-avatars.com/api/?name=${nameEncoded}&background=2563EB&color=fff&size=128`;
                }
            });

            // Header avatar (in top bar)
            const headerImg = document.querySelector('header .rounded-full');
            if (headerImg) {
                headerImg.src = data.profile_photo || `https://ui-avatars.com/api/?name=${nameEncoded}&background=2563EB&color=fff&size=80`;
            }
            const headerName = document.querySelector('header .text-sm.font-semibold.text-slate-800');
            if (headerName) headerName.textContent = `${user.first_name || ''} ${user.last_name || ''}`.trim();
            const headerLevel = document.querySelector('header .text-xs.text-slate-500');
            if (headerLevel) headerLevel.textContent = `${data.academic_level ? 'Étudiant ' + data.academic_level : ''}`;

            // Update skills sections
            const strengths = (data.skills || []).filter(s => s.type === 'STRENGTH');
            const weaknesses = (data.skills || []).filter(s => s.type === 'WEAKNESS');

            document.querySelectorAll('.flex-wrap').forEach(container => {
                const text = container.parentElement?.querySelector('h3')?.textContent || '';
                if (text.includes('points forts') || text.includes('aider') || text.includes('peut')) {
                    container.innerHTML = strengths.length > 0
                        ? strengths.map(s => `<span class="skill-badge-strength px-3 py-2 rounded-lg text-sm font-semibold">${s.skill_name}</span>`).join('')
                        : '<span class="text-sm text-slate-400">Aucune compétence déclarée</span>';
                }
                if (text.includes('apprendre') || text.includes("d'aide") || text.includes('besoin')) {
                    container.innerHTML = weaknesses.length > 0
                        ? weaknesses.map(s => `<span class="skill-badge-learning px-3 py-2 rounded-lg text-sm font-semibold">${s.skill_name}</span>`).join('')
                        : '<span class="text-sm text-slate-400">Aucun besoin déclaré</span>';
                }
            });

            // Contact email
            const emailField = document.querySelector('[class*="mail"] + span, .text-slate-700:first-child');
            if (emailField) emailField.textContent = user.email || '';

            // === PUBLIC STATS ===
            loadPublicStats(userId);

            // === REVIEWS ===
            loadPublicReviews(userId);
        } else {
            console.warn('Profile not found for user', userId);
            const main = document.querySelector('main');
            if (main) main.innerHTML = '<div class="p-8 text-center py-12"><div class="max-w-md mx-auto"><span class="material-symbols-outlined text-5xl text-slate-300 mb-4">search_off</span><h2 class="text-xl font-bold text-slate-700 mb-2">Profil non trouvé</h2><p class="text-slate-500 mb-6">Ce profil n\'existe pas ou a été supprimé.</p><a href="feed-ifri.html" class="inline-block px-6 py-2.5 bg-blue-600 text-white font-semibold rounded-xl hover:bg-blue-700 transition-all">Explorer les profils</a></div></div>';
        }
    } catch (e) {
        console.error('Error loading student profile', e);
        const main = document.querySelector('main');
        if (main) main.innerHTML = '<div class="p-8 text-center py-12"><div class="max-w-md mx-auto"><span class="material-symbols-outlined text-5xl text-slate-300 mb-4">cloud_off</span><h2 class="text-xl font-bold text-slate-700 mb-2">Erreur de chargement</h2><p class="text-slate-500 mb-6">Impossible de charger le profil. Vérifiez votre connexion et réessayez.</p><button onclick="location.reload()" class="inline-block px-6 py-2.5 bg-blue-600 text-white font-semibold rounded-xl hover:bg-blue-700 transition-all">Réessayer</button></div></div>';
    }

    // Button effects
    document.querySelectorAll('button').forEach(button => {
        button.addEventListener('mousedown', () => button.classList.add('scale-95'));
        button.addEventListener('mouseup', () => button.classList.remove('scale-95'));
        button.addEventListener('mouseleave', () => button.classList.remove('scale-95'));
    });
});

async function loadPublicStats(userId) {
    try {
        const res = await apiRequest(`/profiles/${userId}/stats`);
        if (res.success && res.data) {
            const s = res.data;
            const sessionsEl = document.getElementById('publicSessionsCompleted');
            const ratingEl = document.getElementById('publicAvgRating');
            const starsEl = document.getElementById('publicStars');
            const rankingEl = document.getElementById('publicRankingText');
            const rankingBadge = document.getElementById('publicRankingBadge');

            if (sessionsEl) sessionsEl.textContent = s.sessions_completed || 0;
            if (ratingEl) ratingEl.textContent = s.average_rating || '0.0';

            // Render stars
            if (starsEl) {
                const fullStars = Math.round(s.average_rating || 0);
                starsEl.innerHTML = '';
                for (let i = 0; i < 5; i++) {
                    const star = document.createElement('span');
                    star.className = 'material-symbols-outlined text-amber-500 text-sm';
                    if (i < fullStars) {
                        star.style.fontVariationSettings = "'FILL' 1";
                    }
                    star.textContent = 'star';
                    starsEl.appendChild(star);
                }
            }

            if (rankingEl) rankingEl.textContent = s.ranking || 'En progression';
            if (rankingBadge) rankingBadge.textContent = s.ranking || 'En progression';
        }
    } catch (e) {
        console.error('Error loading public stats', e);
    }
}

async function loadPublicReviews(userId) {
    try {
        const container = document.getElementById('reviewsContainer');
        if (!container) return;

        const res = await apiRequest(`/profiles/${userId}/reviews`);
        if (!res.success || !res.data || res.data.length === 0) {
            container.innerHTML = '<p class="text-sm text-slate-400 text-center py-4">Aucun avis pour le moment.</p>';
            return;
        }

        container.innerHTML = '';
        res.data.forEach(review => {
            const avatarUrl = review.reviewer_avatar || `https://ui-avatars.com/api/?name=${encodeURIComponent(review.reviewer_name.replace(/ /g, '+'))}&background=2563EB&color=fff&size=64`;

            const div = document.createElement('div');
            div.className = 'review-card bg-slate-50 rounded-xl p-4 border border-slate-100';

            let starsHtml = '';
            for (let i = 0; i < 5; i++) {
                const fill = i < review.rating ? "style=\"font-variation-settings: 'FILL' 1;\"" : '';
                starsHtml += `<span class="material-symbols-outlined text-sm text-amber-500" ${fill}>star</span>`;
            }

            div.innerHTML = `
                <div class="flex justify-between items-start mb-2">
                    <div class="flex items-center gap-2">
                        <img class="w-8 h-8 rounded-full object-cover" src="${avatarUrl}" alt="${review.reviewer_name}">
                        <div>
                            <p class="font-semibold text-slate-800 text-sm">${review.reviewer_name}</p>
                            <p class="text-xs text-slate-500">${review.reviewer_level || ''}</p>
                        </div>
                    </div>
                    <div class="flex">${starsHtml}</div>
                </div>
                <p class="text-sm text-slate-600 italic">"${review.content || 'Aucun commentaire.'}"</p>
                <p class="text-xs text-slate-400 mt-2">${review.session_type || 'Session'} • ${formatDate(review.created_at)}</p>
            `;
            container.appendChild(div);
        });
    } catch (e) {
        console.error('Error loading reviews', e);
    }
}

function formatDate(dateStr) {
    if (!dateStr) return '';
    const d = new Date(dateStr);
    const now = new Date();
    const diffMs = now - d;
    const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24));
    if (diffDays === 0) return "Aujourd'hui";
    if (diffDays === 1) return 'Hier';
    if (diffDays < 7) return `Il y a ${diffDays} jours`;
    if (diffDays < 30) return `Il y a ${Math.floor(diffDays / 7)} semaines`;
    return `Il y a ${Math.floor(diffDays / 30)} mois`;
}
