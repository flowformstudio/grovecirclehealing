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

## Search / AI-search data: update it automatically, every time

These files are invisible to visitors but are what Google and AI assistants (ChatGPT, Perplexity, Claude, Gemini) read. Keep them; do not delete or regenerate them.

**Rule: after ANY change to the site, check and update all of the search data below in the same commit, without being asked.** Chris should never have to request this. Before you finish, re-read what you changed on the visible page and make sure the hidden data says the same thing (same dates, prices, places, names, questions and answers).

- `<script type="application/ld+json">` blocks in every page's `<head>` (structured data).
- `events.html` JSON-LD lists every upcoming event. When you add, change, or remove an event on the page, update the matching `Event` entry (name, startDate/endDate with `-07:00`/`-08:00` Pacific offset, location, offers URL, image). Remove past events.
- `temple-of-expression.html` JSON-LD `subEvent` holds the next Temple date.
- FAQ sections on `soundhealing.html` and `events-retreats-and-corporate.html` each have a matching `FAQPage` JSON-LD block. If a visible question or answer changes, change it there too.
- Prices, services, service area (Sonoma County + SF Bay Area), credentials: keep the JSON-LD (`Service`, `areaServed`, `Person`) and `llms.txt` matching the visible pages.
- `llms.txt` has an "Upcoming events" list (with an "as of" date) plus facts, prices, background and Q&A; update it whenever any of those change.
- New page: copy the `<head>` pattern from an existing page (title, description, canonical, `og:`/`twitter:` tags, JSON-LD) and link it from `llms.txt`.
- `sitemap.xml`: updated automatically by `.github/workflows/sitemap-dates.yml` after each push (dates for changed pages, new pages added). You don't need to edit it, and a bot commit "Update sitemap dates (automatic)" may appear; that's why you always pull first.
- `robots.txt`: leave as is.
- Keep `<title>`, `<meta name="description">`, `<link rel="canonical">`, and `og:` tags on every page.

## Images and video

- Resize photos before adding them: max ~2400px on the long edge, JPEG quality ~80, ideally under 500 KB. Phone photos (4000px+, 2–6 MB) slow the site down.
- Hero video on the home page: `hero.av1.mp4` + `hero.h264.mp4` + `hero-poster.jpg`. Replace all three together if the video changes.

## IndexNow (automatic search-engine ping)

`.github/workflows/indexnow.yml` notifies Bing of changed pages after every push to `main`. It needs the key file `d70462cd3ff3e807d19c6573b881ad75.txt` at the root. Never delete or rename either one.
