# CLAUDE.md — working notes for AI assistants

Guidance for continuing this project without re-reading the whole codebase. Read this
first, then `docs/CODEMAP.md` if you need to know *where* something lives in `index.html`.
Keep both files up to date when you change the structure or conventions.

## What this is

A **mobile-first IPSC stage score calculator**. You tap counts for each target zone and
penalty, enter the stage time, and it shows points, hit factor, % of max and round count
in real time. Used one-handed at a shooting range, often offline.

## Hard constraints — do not break these

- **Single file.** Everything (HTML, CSS, JS) lives in `index.html`. No build step, no
  bundler, no `npm install`, **no external dependencies or CDN links**. It must work by
  opening the file directly (`file://`) and offline. Do not introduce a framework.
- **Vanilla ES5-flavoured JS** inside one IIFE (`(function(){ "use strict"; ... })()`).
  Match the existing style: `var`, no arrow functions, no template literals, no optional
  chaining. This keeps it running on old range phones without transpilation.
- **Bilingual.** Every user-visible string exists in both Swedish (`sv`) and English
  (`en`). Never hard-code display text in the DOM or JS — go through the i18n system.
- **Offline-safe.** Any browser API that can be blocked (e.g. `localStorage`) must be
  wrapped in try/catch and degrade gracefully. See `storedLang`/`storeLang`.

## How to run and verify

```sh
make dev             # python http.server on :8000, opens browser
make dev PORT=3000   # different port
make docker          # same via nginx in Docker
```

Or just open `index.html` in a browser. There is **no test suite**. To sanity-check JS
before committing, extract the inline script and run Node's syntax checker:

```sh
python3 -c "import re;open('/tmp/a.js','w').write(re.search(r'<script>(.*)</script>',open('index.html').read(),re.S).group(1))" && node --check /tmp/a.js
```

For behaviour changes, actually drive it in a browser (`make dev`) — tap the steppers,
toggle Major/Minor and SV/EN, set a time, and confirm the readout + calculation card.

## Domain rules (IPSC scoring)

The authoritative human-readable explanation is in `README.md` ("Scoring" + "Rule
references"). The short version the code implements:

- Zone points (Major/Minor): A = 5/5, C = 4/3, D = 2/1, Steel = 5/5. B-zone on Classic
  targets is entered as C.
- Miss, No-shoot, Procedure error = −10 each.
- **There is no FTE (failure-to-engage) input** — it was removed intentionally. A FTE is
  entered as the target's misses plus one Procedure error. Don't re-add an FTE row.
- Stage points floor at 0 (never negative). Hit factor = points ÷ time (4 decimals),
  shown as "—" until a time > 0 is entered.
- Round count is derived, not entered: `A + C + D + Steel + Miss`. Max points = rounds × 5.

## Conventions when editing

- **Adding/removing a target or penalty:** edit `zoneDefs` / `penaltyDefs` and the
  `state.counts` object — that's mostly it. The grid, steppers, press-and-hold and
  rendering are all driven off those definitions. See `docs/CODEMAP.md` for the full
  checklist (also update `calc`, `buildCalc`, `ariaNames`, and the footnote).
- **Adding a translatable string:** add the key to *both* `I18N.sv` and `I18N.en`, then
  reference it via `data-i18n="key"` in the HTML (static text) or `T().key` in JS
  (dynamic text). `applyLang` swaps all `data-i18n` nodes automatically.
- **Layout:** inputs are a 2-column CSS grid of `.card`s. An odd last card auto-spans both
  columns via `.grid > .card:last-child:nth-child(odd)` — no JS needed. Keep touch targets
  large (buttons are 56px).
- **Commits:** small, focused, imperative subject line. Branch off `main` before
  committing per repo policy; push only when asked.

## Gotchas

- Steppers use pointer events with a press-and-hold repeat (`pointerdown` → timeout →
  interval). Keyboard activation is handled separately via a `click` listener checking
  `e.detail === 0`. Touch both paths if you change stepper behaviour.
- The time slider and numeric field are kept in sync; the slider's `max` auto-grows when
  you type a larger number. Decimals display with `.` (dot) even though input accepts `,`.
- `render()` rewrites `#calc` with `innerHTML` — only ever interpolate numbers and
  controlled label strings there, never free user text.
