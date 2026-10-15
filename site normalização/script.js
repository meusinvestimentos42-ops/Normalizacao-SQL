// ===== MENU LATERAL FIXO / HIGHLIGHT DE SEÇÃO =====
const tutorialLinks = document.querySelectorAll('.tutorial-nav a');
const sections = document.querySelectorAll('.article-section');

const setActiveLink = (id) => {
  tutorialLinks.forEach((link) => {
    const isActive = link.getAttribute('href') === `#${id}`;
    link.classList.toggle('active', isActive);
  });
};

if (document.body.classList.contains('participants-page')) {
  const participantSections = document.querySelectorAll('.participant-section');

  const showParticipantSection = (targetId) => {
    participantSections.forEach((section) => {
      const shouldShow = section.id === targetId;
      section.classList.toggle('is-visible', shouldShow);
      section.style.display = shouldShow ? 'block' : 'none';
    });

    tutorialLinks.forEach((link) => {
      const isSelected = link.getAttribute('href') === `#${targetId}`;
      link.classList.toggle('active', isSelected);
    });
  };

  if (participantSections.length) {
    showParticipantSection('agradecimento');

    tutorialLinks.forEach((link) => {
      link.addEventListener('click', (event) => {
        event.preventDefault();
        const targetId = link.getAttribute('href').replace('#', '');
        showParticipantSection(targetId);
      });
    });
  }
} else if (tutorialLinks.length && sections.length) {
  const observer = new IntersectionObserver(
    (entries) => {
      const visibleEntry = entries
        .filter((entry) => entry.isIntersecting)
        .sort((a, b) => b.intersectionRatio - a.intersectionRatio)[0];

      if (visibleEntry) {
        setActiveLink(visibleEntry.target.id);
      }
    },
    {
      rootMargin: '-10% 0px -55% 0px',
      threshold: [0.2, 0.5, 0.8],
    }
  );

  sections.forEach((section) => observer.observe(section));
}
