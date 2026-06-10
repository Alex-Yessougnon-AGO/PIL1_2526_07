(function() {
  var SIDEBAR_HTML =
    '<aside class="hidden md:flex flex-col h-screen w-64 fixed left-0 top-0 bg-surface-container-lowest dark:bg-surface-dim border-r border-outline-variant dark:border-outline p-md gap-base z-50">' +
      '<div class="flex items-center gap-sm mb-lg">' +
        '<div class="w-10 h-10 bg-primary rounded-lg flex items-center justify-center text-white font-bold text-xl">ML</div>' +
        '<div>' +
          '<h1 class="font-headline-md text-headline-md font-bold text-primary dark:text-primary-fixed-dim leading-none">MentorLink</h1>' +
          '<p class="text-on-surface-variant text-caption">Apprentissage Pair-à-Pair</p>' +
        '</div>' +
      '</div>' +
      '<nav class="flex flex-col gap-xs flex-grow">' +
        '<a class="sidebar-link flex items-center gap-sm px-sm py-base rounded-lg transition-all duration-150" href="dashboard.html" data-page="dashboard">' +
          '<span class="material-symbols-outlined">dashboard</span>' +
          '<span class="font-label-md text-label-md">Tableau de bord</span>' +
        '</a>' +
        '<a class="sidebar-link flex items-center gap-sm px-sm py-base rounded-lg transition-all duration-150" href="feed-ifri.html" data-page="feed">' +
          '<span class="material-symbols-outlined">dynamic_feed</span>' +
          '<span class="font-label-md text-label-md">Publications</span>' +
        '</a>' +
        '<a class="sidebar-link flex items-center gap-sm px-sm py-base rounded-lg transition-all duration-150" href="matching-results.html" data-page="matching" data-hide="dashboard,feed,notifs,settings,profile,message,offer">' +
          '<span class="material-symbols-outlined">groups</span>' +
          '<span class="font-label-md text-label-md">Matching</span>' +
        '</a>' +
        '<a class="sidebar-link flex items-center gap-sm px-sm py-base rounded-lg transition-all duration-150" href="message.html" data-page="messages">' +
          '<span class="material-symbols-outlined">forum</span>' +
          '<span class="font-label-md text-label-md">Messages</span>' +
        '</a>' +
        '<a class="sidebar-link flex items-center gap-sm px-sm py-base rounded-lg transition-all duration-150" href="notifs.html" data-page="notifs">' +
          '<span class="material-symbols-outlined">notifications</span>' +
          '<span class="font-label-md text-label-md">Notifications</span>' +
        '</a>' +
        '<a class="sidebar-link flex items-center gap-sm px-sm py-base rounded-lg transition-all duration-150" href="mon-profile.html" data-page="profile">' +
          '<span class="material-symbols-outlined">person</span>' +
          '<span class="font-label-md text-label-md">Profil</span>' +
        '</a>' +
        '<a class="sidebar-link flex items-center gap-sm px-sm py-base rounded-lg transition-all duration-150" href="settings.html" data-page="settings">' +
          '<span class="material-symbols-outlined">settings</span>' +
          '<span class="font-label-md text-label-md">Paramètres</span>' +
        '</a>' +
      '</nav>' +
      '<a href="offer.html" class="mt-auto py-base px-md bg-primary text-white font-label-md text-label-md rounded-lg hover:opacity-90 transition-opacity flex items-center justify-center"> Trouver un Mentor </a>' +
    '</aside>';

  var SIDEBAR_CTA_HTML =
    '<aside class="hidden md:flex flex-col h-screen w-64 fixed left-0 top-0 bg-surface-container-lowest dark:bg-surface-dim border-r border-outline-variant dark:border-outline p-md gap-base z-50">' +
      '<div class="flex items-center gap-base mb-lg">' +
        '<div class="w-10 h-10 bg-primary rounded-lg flex items-center justify-center text-on-primary">' +
          '<span class="material-symbols-outlined" style="font-variation-settings: \'FILL\' 1;">school</span>' +
        '</div>' +
        '<div>' +
          '<h1 class="font-headline-md text-headline-md font-bold text-primary dark:text-primary-fixed-dim leading-none">MentorLink</h1>' +
          '<p class="font-caption text-caption text-on-surface-variant">Apprentissage Pair-à-Pair</p>' +
        '</div>' +
      '</div>' +
      '<nav class="flex flex-col gap-xs flex-grow">' +
        '<a class="sidebar-link flex items-center gap-sm px-md py-sm rounded-lg transition-all duration-150 font-label-md text-label-md" href="dashboard.html" data-page="dashboard">' +
          '<span class="material-symbols-outlined">dashboard</span> Tableau de bord' +
        '</a>' +
        '<a class="sidebar-link flex items-center gap-sm px-md py-sm rounded-lg transition-all duration-150 font-label-md text-label-md" href="feed-ifri.html" data-page="feed">' +
          '<span class="material-symbols-outlined" style="font-variation-settings: \'FILL\' 1;">dynamic_feed</span> Fil d\'actualité' +
        '</a>' +
        '<a class="sidebar-link flex items-center gap-sm px-md py-sm rounded-lg transition-all duration-150 font-label-md text-label-md" href="message.html" data-page="messages">' +
          '<span class="material-symbols-outlined">forum</span> Messages' +
        '</a>' +
        '<a class="sidebar-link flex items-center gap-sm px-md py-sm rounded-lg transition-all duration-150 font-label-md text-label-md" href="notifs.html" data-page="notifs">' +
          '<span class="material-symbols-outlined">notifications</span> Notifications' +
        '</a>' +
        '<a class="sidebar-link flex items-center gap-sm px-md py-sm rounded-lg transition-all duration-150 font-label-md text-label-md" href="mon-profile.html" data-page="profile">' +
          '<span class="material-symbols-outlined">person</span> Profil' +
        '</a>' +
        '<a class="sidebar-link flex items-center gap-sm px-md py-sm rounded-lg transition-all duration-150 font-label-md text-label-md" href="settings.html" data-page="settings">' +
          '<span class="material-symbols-outlined">settings</span> Paramètres' +
        '</a>' +
      '</nav>' +
      '<div class="mt-auto p-md bg-surface-container-low rounded-xl border border-outline-variant">' +
        '<p class="font-label-md text-label-md font-bold text-primary mb-xs">Besoin d\'un coup de pouce ?</p>' +
        '<p class="font-caption text-caption text-on-surface-variant mb-md">Trouvez des mentors prêts à vous aider avec vos projets semestriels.</p>' +
        '<a href="offer.html" class="w-full bg-primary text-on-primary font-label-md text-label-md py-sm rounded-lg hover:opacity-90 active:scale-95 transition-all flex items-center justify-center"> Trouver un Mentor </a>' +
      '</div>' +
    '</aside>';

  var SIDEBAR_ICON_HTML =
    '<aside class="hidden md:flex flex-col h-screen w-16 fixed left-0 top-0 bg-surface-container-lowest border-r border-outline-variant py-3 items-center z-50">' +
      '<div class="w-10 h-10 bg-primary rounded-xl flex items-center justify-center text-on-primary mb-6">' +
        '<span class="material-symbols-outlined">forum</span>' +
      '</div>' +
      '<nav class="flex flex-col gap-1 items-center flex-grow">' +
        '<a class="sidebar-icon-link flex items-center justify-center w-10 h-10 rounded-xl transition-all" href="dashboard.html" data-page="dashboard">' +
          '<span class="material-symbols-outlined">dashboard</span>' +
        '</a>' +
        '<a class="sidebar-icon-link flex items-center justify-center w-10 h-10 rounded-xl transition-all" href="feed-ifri.html" data-page="feed">' +
          '<span class="material-symbols-outlined">dynamic_feed</span>' +
        '</a>' +
        '<a class="sidebar-icon-link flex items-center justify-center w-10 h-10 rounded-xl transition-all" href="message.html" data-page="messages">' +
          '<span class="material-symbols-outlined" style="font-variation-settings: \'FILL\' 1;">forum</span>' +
        '</a>' +
        '<a class="sidebar-icon-link flex items-center justify-center w-10 h-10 rounded-xl transition-all" href="notifs.html" data-page="notifs">' +
          '<span class="material-symbols-outlined">notifications</span>' +
        '</a>' +
        '<a class="sidebar-icon-link flex items-center justify-center w-10 h-10 rounded-xl transition-all" href="mon-profile.html" data-page="profile">' +
          '<span class="material-symbols-outlined">person</span>' +
        '</a>' +
        '<a class="sidebar-icon-link flex items-center justify-center w-10 h-10 rounded-xl transition-all" href="settings.html" data-page="settings">' +
          '<span class="material-symbols-outlined">settings</span>' +
        '</a>' +
      '</nav>' +
      '<a href="offer.html" class="w-10 h-10 bg-primary text-on-primary rounded-xl flex items-center justify-center hover:opacity-90 transition-opacity" title="Trouver un Mentor">' +
        '<span class="material-symbols-outlined">search</span>' +
      '</a>' +
    '</aside>';

  var css = document.createElement('style');
  css.textContent =
    '.sidebar-link.nav-active{background-color:#d1e4ff;color:#001b39;font-weight:700}' +
    '.sidebar-link.nav-inactive{color:#44474e}' +
    '.sidebar-link.nav-inactive:hover{background-color:#e2e2e6}' +
    '.sidebar-icon-link.nav-active{background-color:#d1e4ff;color:#001b39}' +
    '.sidebar-icon-link.nav-inactive{color:#44474e}' +
    '.sidebar-icon-link.nav-inactive:hover{background-color:#e2e2e6}' +
    '.mobile-nav-link.nav-active{color:#005fac;font-weight:700}' +
    '.mobile-nav-link.nav-inactive{color:#44474e}' +
    '.dark .sidebar-link.nav-active{background-color:#005fac;color:#ffffff}' +
    '.dark .sidebar-link.nav-inactive{color:#c4c6d0}' +
    '.dark .sidebar-link.nav-inactive:hover{background-color:#2f3033}';
  document.head.appendChild(css);

  var SIDEBAR_COMPACT_HTML =
    '<aside class="flex flex-col h-full p-md gap-base bg-surface-container-lowest dark:bg-surface-dim h-screen w-64 fixed left-0 top-0 border-r border-outline-variant dark:border-outline z-50">' +
      '<div class="flex items-center gap-sm mb-lg">' +
        '<div class="w-10 h-10 bg-primary rounded-lg flex items-center justify-center text-white font-bold text-xl">ML</div>' +
        '<div>' +
          '<h1 class="font-headline-md text-headline-md font-bold text-primary dark:text-primary-fixed-dim leading-none">MentorLink</h1>' +
          '<p class="text-on-surface-variant text-caption">Apprentissage Pair-à-Pair</p>' +
        '</div>' +
      '</div>' +
      '<nav class="flex flex-col gap-xs flex-grow">' +
        '<a class="sidebar-link flex items-center gap-sm px-sm py-base rounded-lg transition-all duration-150" href="dashboard.html" data-page="dashboard">' +
          '<span class="material-symbols-outlined">dashboard</span>' +
          '<span class="font-label-md text-label-md">Tableau de bord</span>' +
        '</a>' +
        '<a class="sidebar-link flex items-center gap-sm px-sm py-base rounded-lg transition-all duration-150" href="feed-ifri.html" data-page="feed">' +
          '<span class="material-symbols-outlined">dynamic_feed</span>' +
          '<span class="font-label-md text-label-md">Publications</span>' +
        '</a>' +
        '<a class="sidebar-link flex items-center gap-sm px-sm py-base rounded-lg transition-all duration-150" href="message.html" data-page="messages">' +
          '<span class="material-symbols-outlined">forum</span>' +
          '<span class="font-label-md text-label-md">Messages</span>' +
        '</a>' +
      '</nav>' +
      '<a href="offer.html" class="mt-auto py-base px-md bg-primary text-white font-label-md text-label-md rounded-lg hover:opacity-90 transition-opacity flex items-center justify-center"> Trouver un Mentor </a>' +
    '</aside>';

  var sidebarMap = { standard: SIDEBAR_HTML, cta: SIDEBAR_CTA_HTML, icon: SIDEBAR_ICON_HTML, compact: SIDEBAR_COMPACT_HTML };

  function getPage() {
    return document.documentElement.getAttribute('data-page') || '';
  }

  function activate() {
    var currentPage = getPage();
    document.querySelectorAll('.sidebar-link, .sidebar-icon-link, .mobile-nav-link').forEach(function(link) {
      var page = link.getAttribute('data-page');
      link.classList.remove('nav-active', 'nav-inactive');
      var isHide = (link.getAttribute('data-hide') || '').split(',').indexOf(currentPage) !== -1;
      link.style.display = isHide ? 'none' : '';
      if (page === currentPage) {
        link.classList.add('nav-active');
      } else if (!isHide) {
        link.classList.add('nav-inactive');
      }
    });
  }

  document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('[data-sidebar]').forEach(function(el) {
      var type = el.getAttribute('data-sidebar');
      if (sidebarMap[type]) {
        el.outerHTML = sidebarMap[type];
      }
    });
    setTimeout(activate, 0);
  });
})();