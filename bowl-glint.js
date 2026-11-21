/* Singing-bowl glint: one visible button at a time gets a soft glint
   around its edge (see .is-singing in styles.css). Rare and gentle. */
(function () {
  if (window.matchMedia && matchMedia('(prefers-reduced-motion: reduce)').matches) return;
  var SEL = '.btn, .nav__cta, .btn-submit, .inquiry-form-card__button, .newsletter-strip__btn';
  var DURATION = 6200;

  function visible(el) {
    var r = el.getBoundingClientRect();
    return r.width > 0 && r.height > 0 && r.bottom > 0 && r.top < window.innerHeight;
  }
  var HOVER_ONLY = '.offering-card';   // service tiles: glow on hover only
  var HOVER_DURATION = DURATION;

  function ring(el, ms) {
    if (!el || el.classList.contains('is-singing')) return;
    el.classList.add('is-singing');
    setTimeout(function () { el.classList.remove('is-singing'); }, ms || DURATION);
  }
  function tick() {
    if (!document.hidden) {
      var list = Array.prototype.filter.call(document.querySelectorAll(SEL), visible);
      if (list.length) ring(list[Math.floor(Math.random() * list.length)]);
    }
    setTimeout(tick, 6000 + Math.random() * 5000);
  }
  setTimeout(tick, 2500);

  document.addEventListener('pointerenter', function (e) {
    var t = e.target;
    if (!t || !t.matches) return;
    if (t.matches(SEL)) ring(t);
    else if (t.matches(HOVER_ONLY)) ring(t, HOVER_DURATION);
  }, true);
})();
