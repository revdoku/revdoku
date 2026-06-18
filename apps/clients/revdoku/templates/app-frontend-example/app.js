/*
 * Revdoku app-site frontend reference.
 *
 * Shows the canonical pattern for a Turnstile-protected public app:
 *   - read a list with GET  /_revdoku/app/<action>
 *   - submit a write with POST /_revdoku/app/<action> + cf_turnstile_token
 *   - unwrap the Cloudflare D1 result envelope
 *
 * Pair it with a backend template from templates/app-safe-actions.json that
 * exposes `list_ideas` (public read) and `submit_idea` (public write, turnstile).
 */
(function () {
  'use strict';

  var API = '/_revdoku/app/';

  // From bucket_app_database_get -> app_database.turnstile_site_key.
  // Replace before publishing. If the app database does not require Turnstile,
  // the widget is simply unused and writes go through without a token.
  var SITE_KEY = 'YOUR_TURNSTILE_SITE_KEY';

  /* ---- Cloudflare D1 returns { ok, result: [ { results: [...] } ] } ---- */
  function rowsOf(data) {
    if (!data) return [];
    if (Array.isArray(data)) return data;
    var r = data.result;
    if (Array.isArray(r) && r[0] && Array.isArray(r[0].results)) return r[0].results;
    if (Array.isArray(r)) return r;
    return data.results || data.rows || [];
  }

  /* ---- Turnstile: one VISIBLE MANAGED widget, token read on submit ---- *
   * Do NOT use appearance:'interaction-only' on a hidden widget. A visitor
   * Cloudflare decides to challenge would have nothing to solve, so no token is
   * ever issued and every write fails. A visible managed widget stays invisible
   * for most visitors and only shows a checkbox when a challenge is needed.    */
  var widgetId = null;
  function renderTurnstile() {
    if (window.turnstile && widgetId === null) {
      widgetId = window.turnstile.render('#cf-turnstile', { sitekey: SITE_KEY });
    }
  }
  function whenTurnstileReady() {
    if (window.turnstile) { renderTurnstile(); return; }
    var n = 0;
    var iv = setInterval(function () {
      if (window.turnstile) { clearInterval(iv); renderTurnstile(); }
      else if (++n > 100) clearInterval(iv); // ~10s
    }, 100);
  }
  function turnstileToken() {
    return (widgetId !== null && window.turnstile && window.turnstile.getResponse(widgetId)) || '';
  }
  function resetTurnstile() {
    try { if (widgetId !== null) window.turnstile.reset(widgetId); } catch (e) {}
  }

  /* ---- read ---- */
  function loadIdeas() {
    return fetch(API + 'list_ideas', { headers: { Accept: 'application/json' }, credentials: 'same-origin' })
      .then(function (r) { return r.json(); })
      .then(function (data) {
        var ul = document.getElementById('list');
        ul.textContent = '';
        var rows = rowsOf(data);
        if (!rows.length) { ul.innerHTML = '<li>No ideas yet — be the first.</li>'; return; }
        rows.forEach(function (it) {
          var li = document.createElement('li');
          li.textContent = it.title || '(untitled)';
          ul.appendChild(li);
        });
      })
      .catch(function () { document.getElementById('list').innerHTML = '<li>Could not load.</li>'; });
  }

  /* ---- write ---- */
  function onSubmit(e) {
    e.preventDefault();
    var title = document.getElementById('title');
    var btn = document.getElementById('submit');
    var msg = document.getElementById('msg');
    var text = title.value.trim();
    if (!text) { title.focus(); return; }

    var token = turnstileToken();
    if (!token) { msg.textContent = 'Please complete the verification check, then post.'; return; }

    btn.disabled = true; msg.textContent = 'Posting…';
    fetch(API + 'submit_idea', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Accept: 'application/json' },
      credentials: 'same-origin',
      body: JSON.stringify({ title: text, cf_turnstile_token: token })
    })
      .then(function (r) {
        return r.json().catch(function () { return {}; }).then(function (j) {
          if (!r.ok) throw new Error((j && (j.error || j.message)) || ('Failed (' + r.status + ')'));
          return j;
        });
      })
      .then(function () {
        title.value = ''; msg.textContent = 'Posted — thanks!';
        return loadIdeas();
      })
      .catch(function (err) { msg.textContent = err.message || 'Could not post.'; })
      // Always reset so the next write gets a fresh token.
      .then(function () { resetTurnstile(); btn.disabled = false; });
  }

  document.getElementById('form').addEventListener('submit', onSubmit);
  whenTurnstileReady();
  loadIdeas();
})();
