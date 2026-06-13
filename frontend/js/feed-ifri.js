import { apiRequest, requireAuth, updateUserHeader } from './api.js';

let allPosts = [];

document.addEventListener('DOMContentLoaded', async () => {
    if (!requireAuth()) return;
    await updateUserHeader();

    const postsContainer = document.querySelector('.grid.grid-cols-1.md\\:grid-cols-2.lg\\:grid-cols-3');
    if (!postsContainer) return;

    try {
        const res = await apiRequest('/posts?status=OPEN');
        if (res.success) {
            allPosts = res.data || [];
            renderPosts(allPosts, postsContainer);
        } else {
            const cards = postsContainer.querySelectorAll('.glass-card');
            cards.forEach(card => card.remove());
            postsContainer.innerHTML = '<div class="col-span-1 md:col-span-2 lg:col-span-3 text-center py-12"><span class="material-symbols-outlined text-5xl text-slate-300 mb-3">cloud_off</span><p class="text-sm text-slate-400">Impossible de charger les publications.</p><button onclick="location.reload()" class="mt-4 px-4 py-2 bg-blue-600 text-white text-sm font-semibold rounded-xl hover:bg-blue-700 transition-all">Reessayer</button></div>';
        }
    } catch (e) {
        console.error('Error loading posts', e);
        const cards = postsContainer.querySelectorAll('.glass-card');
        cards.forEach(card => card.remove());
        postsContainer.innerHTML = '<div class="col-span-1 md:col-span-2 lg:col-span-3 text-center py-12"><span class="material-symbols-outlined text-5xl text-slate-300 mb-3">cloud_off</span><p class="text-sm text-slate-400">Erreur de connexion. Veuillez reessayer.</p><button onclick="location.reload()" class="mt-4 px-4 py-2 bg-blue-600 text-white text-sm font-semibold rounded-xl hover:bg-blue-700 transition-all">Reessayer</button></div>';
    }

    initTabFiltering();
    initDropdownFilters();
    initSearchBar();
    initReplyModal();

    function renderPosts(posts, container) {
        const cards = container.querySelectorAll('.glass-card');
        cards.forEach(card => card.remove());

        if (posts.length === 0) {
            container.innerHTML = '<div class="col-span-1 md:col-span-2 lg:col-span-3 text-center py-12"><span class="material-symbols-outlined text-5xl text-slate-300 mb-3">dynamic_feed</span><p class="text-sm text-slate-400">Aucune publication pour le moment.</p><p class="text-xs text-slate-400 mt-1">Soyez le premier à publier une demande ou une offre.</p></div>';
            return;
        }

        posts.forEach((post, index) => {
            const isOffer = post.type === 'OFFER';
            const creator = post.creator || {};
            const card = document.createElement('div');
            card.className = 'glass-card rounded-2xl p-5 flex flex-col card-animate';
            card.style.animationDelay = `${index * 0.05}s`;
            card.innerHTML = `
                <div class="flex justify-between items-start mb-4">
                    <div class="flex items-center gap-3">
                        <div class="relative">
                            <a href="student-profile.html?id=${creator.id || ''}">
                                <img class="w-12 h-12 rounded-full object-cover ring-2 ring-${isOffer ? 'emerald' : 'blue'}-100"
                                    src="https://ui-avatars.com/api/?name=${encodeURIComponent((creator.first_name||'') + '+' + (creator.last_name||''))}&background=${isOffer ? '059669' : '2563EB'}&color=fff&size=48"
                                    alt="avatar">
                            </a>
                            <div class="absolute -bottom-0.5 -right-0.5 w-3.5 h-3.5 ${isOffer ? 'bg-emerald-500' : 'bg-red-500'} rounded-full border-2 border-white"></div>
                        </div>
                        <div>
                            <a href="student-profile.html?id=${creator.id || ''}"><h3 class="font-bold text-slate-800">${creator.first_name || ''} ${(creator.last_name || '')[0] || ''}.</h3></a>
                            <p class="text-xs text-slate-500">${post.format || ''}</p>
                        </div>
                    </div>
                    <span class="${isOffer ? 'badge-offer' : 'badge-need'} px-3 py-1 rounded-full text-[11px] font-bold uppercase tracking-wide">${isOffer ? 'Expertise' : "Besoin d'aide"}</span>
                </div>
                <h4 class="text-lg font-bold text-slate-800 mb-2">${post.subject}</h4>
                <p class="text-sm text-slate-500 leading-relaxed mb-4 line-clamp-2">${post.description || 'Aucune description fournie.'}</p>
                <div class="flex flex-wrap gap-2 mb-5">
                    <span class="tag bg-slate-100 text-slate-700 px-3 py-1 rounded-full text-xs font-medium">#${post.format || 'General'}</span>
                </div>
                <div class="mt-auto pt-4 border-t border-slate-100 grid grid-cols-2 gap-4 items-center">
                    <div class="flex flex-col gap-1.5">
                        <div class="flex items-center gap-1.5 ${isOffer ? 'text-blue-600' : 'text-emerald-600'}">
                            <span class="material-symbols-outlined text-base">${isOffer ? 'videocam' : 'location_on'}</span>
                            <span class="text-xs font-medium">${post.format === 'ONLINE' ? 'En ligne' : post.format === 'PHYSICAL' ? 'Sur campus' : 'Hybride'}</span>
                        </div>
                        <div class="flex items-center gap-1.5 text-slate-500">
                            <span class="material-symbols-outlined text-base">schedule</span>
                            <span class="text-xs">${post.status || 'Disponible'}</span>
                        </div>
                    </div>
                    ${isOffer 
                        ? '<button class="bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-semibold py-2.5 rounded-xl text-sm hover:shadow-lg hover:scale-[1.02] transition-all btn-contact-offer" data-creator-id="' + (creator.id || '') + '" data-creator="' + (creator.first_name || '') + ' ' + (creator.last_name || '') + '" data-subject="' + post.subject + '">Contacter →</button>'
                        : '<button class="bg-gradient-to-r from-blue-600 to-indigo-600 text-white font-semibold py-2.5 rounded-xl text-sm hover:shadow-lg hover:scale-[1.02] transition-all btn-respond" data-creator="' + (creator.first_name || '') + ' ' + (creator.last_name || '') + '" data-creator-id="' + (creator.id || '') + '" data-subject="' + post.subject + '">Repondre →</button>'
                    }
                </div>
            `;
            container.insertBefore(card, container.lastElementChild);
        });
        initReplyModal();
    }

    function getActiveFilters() {
        const filters = { type: null };
        document.querySelectorAll('.filter-select').forEach(sel => {
            const val = sel.value.trim();
            const placeholder = sel.options[0].text.trim();
            if (val !== placeholder) {
                const label = placeholder;
                if (label === 'Format') {
                    const map = { 'Sur campus': 'PHYSICAL', 'En ligne': 'ONLINE', 'Hybride': 'BOTH' };
                    filters.format = map[val];
                } else if (label === 'Filière') {
                    filters.department = val;
                } else if (label === 'Matière IFRI') {
                    filters.subject = val;
                }
            }
        });
        return filters;
    }

    function applyAllFilters() {
        const filters = getActiveFilters();
        const tabType = document.querySelector('.flex.gap-1.bg-slate-100.rounded-full.p-1 .bg-blue-600.text-white');
        const tabText = tabType?.textContent?.trim().toLowerCase() || '';
        const searchInput = document.querySelector('input[placeholder*="Rechercher"]');
        const searchQuery = searchInput?.value?.toLowerCase().trim() || '';

        const filtered = allPosts.filter(post => {
            if (tabText === 'demandes' && post.type !== 'REQUEST') return false;
            if (tabText === 'offres' && post.type !== 'OFFER') return false;
            if (filters.format && post.format !== filters.format) return false;
            if (filters.subject && !post.subject?.toLowerCase().includes(filters.subject.toLowerCase())) return false;
            if (filters.department && !(post.creator?.department || '').toLowerCase().includes(filters.department.toLowerCase())) return false;
            if (searchQuery) {
                const title = post.subject?.toLowerCase() || '';
                const desc = post.description?.toLowerCase() || '';
                if (!title.includes(searchQuery) && !desc.includes(searchQuery)) return false;
            }
            return true;
        });

        renderPosts(filtered, document.querySelector('.grid.grid-cols-1.md\\:grid-cols-2.lg\\:grid-cols-3'));
    }

    function initTabFiltering() {
        document.querySelectorAll('button').forEach(btn => {
            const txt = btn.textContent.trim().toLowerCase();
            if ((txt === 'demandes' || txt === 'offres') || (txt.includes('demande') && !txt.includes('offre')) || (txt.includes('offre') && !txt.includes('demande'))) {
                btn.addEventListener('click', () => {
                    document.querySelectorAll('[class*="rounded-full"]').forEach(b => {
                        if (b.tagName === 'BUTTON' || b.tagName === 'A') {
                            b.classList.remove('bg-blue-600', 'text-white');
                            b.classList.add('text-slate-600');
                        }
                    });
                    btn.classList.add('bg-blue-600', 'text-white');
                    btn.classList.remove('text-slate-600');
                    applyAllFilters();
                });
            }
        });
    }

    function initDropdownFilters() {
        document.querySelectorAll('.filter-select').forEach(sel => {
            sel.addEventListener('change', applyAllFilters);
        });
    }

    function initSearchBar() {
        const searchInput = document.querySelector('input[placeholder*="Rechercher"]');
        if (!searchInput) return;

        searchInput.addEventListener('input', () => {
            applyAllFilters();
        });
    }

    function initReplyModal() {
        // Event delegation for OFFER "Contacter" buttons (handles dynamically added buttons)
        document.addEventListener('click', async (e) => {
            const btn = e.target.closest('.btn-contact-offer');
            if (!btn) return;
            const creatorId = btn.dataset.creatorId;
            if (!creatorId) {
                alert('Impossible de contacter cet utilisateur.');
                return;
            }
            btn.disabled = true;
            btn.textContent = 'Chargement...';
            try {
                const conv = await apiRequest('/conversations', {
                    method: 'POST',
                    body: JSON.stringify({ user_id: creatorId }),
                });
                if (conv.success && (conv.data?.conversation_id || conv.data?.data?.id || conv.data?.id)) {
                    const convId = conv.data.conversation_id || conv.data.data?.id || conv.data.id;
                    window.location.href = `message.html?conversationId=${convId}`;
                } else {
                    window.location.href = `message.html?userId=${creatorId}`;
                }
            } catch (e) {
                console.error('Error creating conversation', e);
                window.location.href = `message.html?userId=${creatorId}`;
            }
        });

        // Event delegation for NEED "Repondre" buttons
        document.addEventListener('click', (e) => {
            const btn = e.target.closest('.btn-respond');
            if (!btn) return;
            const studentName = btn.dataset.creator || 'cet etudiant';
            const subject = btn.dataset.subject || 'ce sujet';
            const creatorId = btn.dataset.creatorId;
            if (!creatorId) return;

            const overlay = document.createElement('div');
            overlay.className = 'fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50';
            overlay.innerHTML = `
                <div class="bg-white rounded-xl max-w-md w-full p-4 border border-slate-200 shadow-lg">
                    <div class="flex justify-between items-center mb-4">
                        <h3 class="text-lg font-bold text-slate-800">Contacter ${studentName}</h3>
                        <button class="close-modal text-slate-400 hover:text-red-500"><span class="material-symbols-outlined">close</span></button>
                    </div>
                    <p class="text-sm text-slate-600 mb-4">Vous vous appretes a repondre a l'annonce : <strong>${subject}</strong>.</p>
                    <div class="mb-4">
                        <label class="block text-sm font-semibold mb-1 text-slate-700">Votre message</label>
                        <textarea class="w-full bg-slate-50 border border-slate-200 rounded-lg p-2 text-sm focus:ring-2 focus:ring-blue-500 focus:outline-none" rows="4" placeholder="Salut ! Je suis disponible..."></textarea>
                    </div>
                    <div class="flex justify-end gap-2">
                        <button class="close-modal px-4 py-2 border border-slate-200 rounded-lg text-sm text-slate-600 hover:bg-slate-50">Annuler</button>
                        <button class="px-4 py-2 bg-blue-600 text-white font-bold rounded-lg text-sm hover:opacity-90">Envoyer</button>
                    </div>
                </div>
            `;
            document.body.appendChild(overlay);
            const close = () => overlay.remove();
            overlay.querySelectorAll('.close-modal').forEach(el => el.addEventListener('click', close));
            overlay.querySelector('button:last-child')?.addEventListener('click', async () => {
                const textarea = overlay.querySelector('textarea');
                const message = textarea?.value?.trim() || '';
                try {
                    const conv = await apiRequest('/conversations', {
                        method: 'POST',
                        body: JSON.stringify({ user_id: creatorId }),
                    });
                    if (conv.success && conv.data) {
                        const convId = conv.data.conversation_id || conv.data.data?.id || conv.data.id;
                        if (convId && message) {
                            await apiRequest('/messages', {
                                method: 'POST',
                                body: JSON.stringify({ conversation_id: convId, content: message }),
                            });
                        }
                        close();
                        window.location.href = `message.html?conversationId=${convId}`;
                    } else {
                        close();
                        window.location.href = `message.html?userId=${creatorId}`;
                    }
                } catch (e) {
                    console.error('Error sending message', e);
                    close();
                    window.location.href = `message.html?userId=${creatorId}`;
                }
            });
            overlay.addEventListener('click', (ev) => { if (ev.target === overlay) close(); });
        });
    }
});
