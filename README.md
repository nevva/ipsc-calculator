# IPSC Stage Calculator

Mobile-friendly calculator for IPSC stage scores and hit factor — runs entirely in the browser, offline, with no dependencies.

**Live:** `https://<username>.github.io/<repo-name>/` *(update the link once Pages is enabled)*

### Features

- Large +/− buttons for A, C, D, steel, miss, FTE, no-shoot and procedure errors — press and hold to repeat
- Steel targets score 5 points regardless of power factor
- Miss and failure to engage (FTE) are tracked separately
- Round count, max points and percentage are calculated automatically from hits + misses
- Time via slider or numeric field (0.01 s steps)
- Major/Minor toggle that updates zone values instantly
- Hit factor, points and percent of max recalculated in real time in the sticky readout
- Swedish/English language toggle — follows the browser language by default and remembers your choice
- A single HTML file with no external dependencies — works offline at the range

### Scoring

| | Major | Minor |
|---|---|---|
| A | 5 | 5 |
| C (and B on Classic targets) | 4 | 3 |
| D | 2 | 1 |
| Steel (per falling target) | 5 | 5 |
| Miss | −10 | −10 |
| FTE (per unengaged target) | −10 | −10 |
| No-shoot (per hit) | −10 | −10 |
| Procedure error | −10 | −10 |

#### Rule references — IPSC Handgun Competition Rules, January 2026 edition ([ipsc.org](https://www.ipsc.org))

- **Comstock (Section 9.2):** unlimited time and unlimited rounds; the time runs from the start signal to the last shot, and hit factor = points ÷ time (the app shows 4 decimals). Per stage, competitors are ranked by hit factor — the best hit factor earns 100% of the stage points — so the app's "% of max" refers to points, not match results
- **Zone values (Appendix B) and power factor (Rule 5.6.1.2):** A = 5 regardless of factor; C = 4/3 and D = 2/1 (Major/Minor). Major is a higher power-factor rating that earns more points for peripheral hits on paper targets. The B zone on Classic targets scores the same as C
- **Steel (Rule 4.3.1.4, Appendix C):** scoring metal targets must be shot and fall or overturn to score, and plates do not recognize power — hence a flat 5 points. Standing steel scores zero plus a 10-point penalty, so it is entered as a miss
- **Misses (Section 9.4):** each miss is penalized minus 10 points, except for disappearing targets (Rule 9.9.2). Paper targets are normally shot with at least two rounds each, best two hits scoring — every required hit not on the target is a miss
- **No-shoots and procedure errors (Sections 9.4 and 10.1–10.2):** minus 10 points each; per the no-shoot rule, at most two penalty hits count per individual no-shoot target (the app cannot enforce this)
- **FTE (Rule 10.2.7):** failing to engage a scoring target with at least one round incurs one procedural penalty per target *plus* the applicable misses — which is why the FTE row comes on top of the Miss row: enter the target's misses as usual and add the FTE separately
- **Zero floor:** negative point totals do not produce a negative hit factor; stage points floor at 0
- **Round count (Rule 3.2.1):** the written stage briefing states the stage's minimum round count. Since every required hit is either a scoring hit or a recorded miss, hits + misses reconstruct that number automatically

### Publish with GitHub Pages

1. Create a new public repo on GitHub
2. Upload `index.html`, `README.md` and `LICENSE`
3. Go to **Settings → Pages**
4. Under **Build and deployment**: choose **Deploy from a branch**, branch `main`, folder `/ (root)`, click **Save**
5. After a minute or so the page is live at `https://<username>.github.io/<repo-name>/`

### Run locally

Open `index.html` in any browser — no build step, no server needed.

For a dev-style local server (auto-opens your browser, uses the Python 3 that ships with macOS):

```sh
make dev            # http://localhost:8000
make dev PORT=3000  # pick another port
```

Or with Docker (nginx):

```sh
make docker             # http://localhost:8000
make docker PORT=3000   # pick another port
```

### License

MIT — see [LICENSE](LICENSE).
