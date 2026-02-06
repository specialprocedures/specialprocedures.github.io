(() => {
  'use strict';

  // Wait for DOM to be ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initHaikuScrollSpy);
  } else {
    initHaikuScrollSpy();
  }

  function initHaikuScrollSpy() {
    const haikuDisplay = document.getElementById('haiku-display');
    if (!haikuDisplay) return; // Not on a haiku page

    // Find all haiku sections with data-haiku-text attribute
    const haikuSections = document.querySelectorAll('.haiku-section[data-haiku-text]');
    if (haikuSections.length === 0) return;

    // Extract haiku data from each section
    const haikus = Array.from(haikuSections).map((section, index) => {
      const haikuText = section.getAttribute('data-haiku-text');
      
      return {
        element: section,
        text: haikuText,
        index: index
      };
    }).filter(h => h.text); // Only keep sections with text

    if (haikus.length === 0) return;

    // Create Intersection Observer
    const observerOptions = {
      root: null,
      rootMargin: '-40% 0px -40% 0px', // Trigger when section is in middle 20% of viewport
      threshold: 0
    };

    let currentHaikuIndex = -1;

    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          const haiku = haikus.find(h => h.element === entry.target);
          if (haiku && haiku.index !== currentHaikuIndex) {
            currentHaikuIndex = haiku.index;
            updateHaikuDisplay(haiku.text);
          }
        }
      });
    }, observerOptions);

    // Observe all haiku sections
    haikus.forEach(haiku => {
      observer.observe(haiku.element);
    });

    // Function to update the displayed haiku text
    function updateHaikuDisplay(text) {
      // Set the HTML directly (text can contain <br> tags)
      haikuDisplay.innerHTML = `<div class="haiku-line">${text}</div>`;
      
      // Add a fade-in animation
      haikuDisplay.classList.remove('haiku-fade-in');
      void haikuDisplay.offsetWidth; // Force reflow
      haikuDisplay.classList.add('haiku-fade-in');
    }

    // Initialize with first haiku
    if (haikus.length > 0) {
      updateHaikuDisplay(haikus[0].text);
    }
  }
})();
