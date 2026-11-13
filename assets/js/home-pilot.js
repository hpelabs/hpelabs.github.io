document.addEventListener('DOMContentLoaded', function () {
  const chips = Array.from(document.querySelectorAll('.lab-topic-chip'));
  const labs = document.getElementById('home-labs');
  const filtered = document.getElementById('filtered-labs');
  const featured = document.querySelector('.home-pilot .home-featured');
  const status = document.getElementById('lab-filter-status');
  if (!chips.length || !labs || !filtered || !status) return;

  const cards = Array.from(filtered.querySelectorAll('.home-card'));

  function applyTopic(topic) {
    const active = chips.find(chip => chip.dataset.topic === topic);
    if (!active) return;
    const showAll = topic === 'all';
    let count = 0;

    chips.forEach(chip => {
      const selected = chip === active;
      chip.classList.toggle('active', selected);
      if (selected) chip.setAttribute('aria-current', 'true');
      else chip.removeAttribute('aria-current');
    });
    cards.forEach(card => {
      const matches = (card.dataset.topics || '').split(/\s+/).includes(topic);
      card.hidden = !matches;
      if (matches) count++;
    });
    labs.hidden = !showAll;
    filtered.hidden = showAll;
    if (featured) featured.hidden = !showAll;
    status.textContent = showAll ? '' : count + (count === 1 ? ' lab found.' : ' labs found.');
  }

  chips.forEach(chip => {
    chip.addEventListener('click', function (event) {
      event.preventDefault();
      const topic = chip.dataset.topic;
      applyTopic(topic);
      history.replaceState(null, '', topic === 'all' ? '#available-labs' : '#' + topic);
    });
  });

  function applyHash() {
    const topic = location.hash.slice(1);
    applyTopic(chips.some(chip => chip.dataset.topic === topic) ? topic : 'all');
  }
  window.addEventListener('hashchange', applyHash);
  applyHash();
});
