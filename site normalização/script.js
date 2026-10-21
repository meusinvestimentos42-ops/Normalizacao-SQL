// ===== MENU LATERAL FIXO / HIGHLIGHT DE SEÇÃO =====
// Seleciona o índice e as seções presentes na página atual.
const tutorialLinks = document.querySelectorAll('.tutorial-nav a');
const sections = document.querySelectorAll('.article-section');

// Sincroniza o tema selecionado entre as páginas do site.
const themeSelects = document.querySelectorAll('.theme-select');
const supportedThemes = ['light', 'dark', 'colorblind'];
const savedTheme = localStorage.getItem('site-theme');
const initialTheme = supportedThemes.includes(savedTheme) ? savedTheme : 'light';

document.documentElement.dataset.theme = initialTheme;
themeSelects.forEach((select) => {
  select.value = initialTheme;
  select.addEventListener('change', () => {
    if (supportedThemes.includes(select.value)) {
      document.documentElement.dataset.theme = select.value;
      localStorage.setItem('site-theme', select.value);
      themeSelects.forEach((themeSelect) => {
        themeSelect.value = select.value;
      });
    }
  });
});

// Mantém destacado o link associado à seção selecionada.
const setActiveLink = (id) => {
  tutorialLinks.forEach((link) => {
    const isActive = link.getAttribute('href') === `#${id}`;
    link.classList.toggle('active', isActive);
    if (isActive) {
      link.setAttribute('aria-current', 'location');
    } else {
      link.removeAttribute('aria-current');
    }
  });
};

if (document.body.classList.contains('participants-page')) {
  // Troca os perfis e sincroniza a seleção com o histórico do navegador.
  const participantSections = document.querySelectorAll('.participant-section');

  const showParticipantSection = (targetId) => {
    const targetExists = Array.from(participantSections).some(
      (section) => section.id === targetId
    );
    if (!targetExists) {
      return;
    }

    participantSections.forEach((section) => {
      section.classList.toggle('is-visible', section.id === targetId);
    });
    setActiveLink(targetId);
  };

  if (participantSections.length) {
    const initialId = window.location.hash.slice(1);
    showParticipantSection(
      Array.from(participantSections).some((section) => section.id === initialId)
        ? initialId
        : 'agradecimento'
    );

    document.querySelectorAll('a[href^="#"]').forEach((link) => {
      link.addEventListener('click', (event) => {
        const targetId = link.getAttribute('href').slice(1);
        const targetExists = Array.from(participantSections).some(
          (section) => section.id === targetId
        );
        if (targetExists) {
          event.preventDefault();
          window.history.pushState(null, '', `#${targetId}`);
          showParticipantSection(targetId);
        }
      });
    });

    const syncFromHash = () => {
      const targetId = window.location.hash.slice(1);
      showParticipantSection(
        Array.from(participantSections).some((section) => section.id === targetId)
          ? targetId
          : 'agradecimento'
      );
    };
    window.addEventListener('popstate', syncFromHash);
    window.addEventListener('hashchange', syncFromHash);
  }
} else if (tutorialLinks.length && sections.length) {
  // No artigo, acompanha a rolagem para destacar a seção atualmente visível.
  const initialId = window.location.hash.slice(1);
  const hasInitialSection = Array.from(sections).some(
    (section) => section.id === initialId
  );
  setActiveLink(hasInitialSection ? initialId : sections[0].id);

  tutorialLinks.forEach((link) => {
    link.addEventListener('click', () => {
      setActiveLink(link.getAttribute('href').slice(1));
    });
  });
  window.addEventListener('hashchange', () => {
    const targetId = window.location.hash.slice(1);
    if (Array.from(sections).some((section) => section.id === targetId)) {
      setActiveLink(targetId);
    }
  });

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
      threshold: 0,
    }
  );

  sections.forEach((section) => observer.observe(section));
}
