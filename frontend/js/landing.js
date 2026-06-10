document.addEventListener('DOMContentLoaded', () => {
	initCardMicroInteractions();
});

/**
 * Gère les effets d'élévation et de micro-animations fluides
 * sur les cartes de la grille méthodologique lors du survol.
 */
function initCardMicroInteractions() {
	const cards = document.querySelectorAll('.group');

	cards.forEach(card => {
		card.addEventListener('mouseenter', () => {
			card.style.transform = 'translateY(-4px)';
		});

		card.addEventListener('mouseleave', () => {
			card.style.transform = 'translateY(0)';
		});
	});
}