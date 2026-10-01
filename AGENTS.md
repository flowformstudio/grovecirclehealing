# Grove Circle Healing website — notes for AI coding agents (Codex, Claude Code)

Static HTML site. Pushing to `main` on GitHub deploys to www.grovecirclehealing.com via Vercel.
Two people edit this repo (Chris and Igor), so always sync first.

## Before you change anything

1. Run `git pull --rebase origin main` and confirm it succeeded.
2. If there are uncommitted local changes, commit or stash them first; never discard someone else's work to make a pull succeed.

## When you are done

1. `git pull --rebase origin main` again, resolve any conflicts by keeping BOTH sides' intent.
2. Commit with a clear message, then `git push origin main`.
3. Never use `git push --force`, `git reset --hard origin/...`, or overwrite files wholesale from an older copy.

## Search / AI-search data that must stay in sync

These files are invisible to visitors but are what Google and AI assistants (ChatGPT, Perplexity, Claude, Gemini) read. Keep them; do not delete or regenerate them.

- `<script type="application/ld+json">` blocks in every page's `<head>` (structured data).
- `events.html` JSON-LD lists every upcoming event. **When you add, change, or remove an event on the page, update the matching `Event` entry** (name, startDate/endDate with `-07:00`/`-08:00` Pacific offset, location, offers URL, image).
- `temple-of-expression.html` JSON-LD `subEvent` holds the next Temple date.
- `llms.txt` has an "Upcoming events" list and facts/prices; update it when events or prices change.
- `sitemap.xml`: add new public pages; bump `<lastmod>` for pages you change.
- `robots.txt`: leave as is.
- Keep `<title>`, `<meta name="description">`, `<link rel="canonical">`, and `og:` tags on every page. New pages should copy this head pattern from an existing page.

## Images and video

- Resize photos before adding them: max ~2400px on the long edge, JPEG quality ~80, ideally under 500 KB. Phone photos (4000px+, 2–6 MB) slow the site down.
- Hero video on the home page: `hero.av1.mp4` + `hero.h264.mp4` + `hero-poster.jpg`. Replace all three together if the video changes.
