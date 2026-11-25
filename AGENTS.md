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
- `membership.html` is the on-site Grove Circle Membership page (sign-up, free preview and sign-in buttons go to Thinkific). Its "Next Class" card (title, description, date line, the countdown's `data-deadline`, artwork), the curriculum list, the "When is the next class?" FAQ answer and the matching `FAQPage` JSON-LD all go out of date after each monthly class. **Whenever the next membership class changes on `events.html`, update all of those on `membership.html` in the same commit.**
- `empowering-the-artist.html` and `the-bodys-wisdom.html` are the on-site course pages; enrollment buttons go to Thinkific. Keep their prices and lesson counts matching Thinkific.
- Every "Membership" link on the site points to `membership.html`, not to Thinkific. Keep it that way.
- FAQ sections on `soundhealing.html` and `events-retreats-and-corporate.html` each have a matching `FAQPage` JSON-LD block. If a visible question or answer changes, change it there too.
- Prices, services, service area (Sonoma County + SF Bay Area), credentials: keep the JSON-LD (`Service`, `areaServed`, `Person`) and `llms.txt` matching the visible pages.
- `llms.txt` has an "Upcoming events" list (with an "as of" date) plus facts, prices, background and Q&A; update it whenever any of those change.
- New page: copy the `<head>` pattern from an existing page (title, description, canonical, `og:`/`twitter:` tags, JSON-LD) and link it from `llms.txt`.
- `sitemap.xml`: updated automatically by `.github/workflows/sitemap-dates.yml` after each push (dates for changed pages, new pages added). You don't need to edit it, and a bot commit "Update sitemap dates (automatic)" may appear; that's why you always pull first.
- `robots.txt`: leave as is.
- Keep `<title>`, `<meta name="description">`, `<link rel="canonical">`, and `og:` tags on every page.

## Stylesheet version

Every page links `styles.css?v=YYYYMMDD`. Whenever you change `styles.css`, change that version (to today's date) on every page in the same commit, or returning visitors keep seeing the old styles.

## Images and video

- Resize photos before adding them: max ~2400px on the long edge, JPEG quality ~80, ideally under 500 KB. Phone photos (4000px+, 2–6 MB) slow the site down.
- Hero video on the home page: `hero.av1.mp4` + `hero.h264.mp4` + `hero-poster.jpg`. Replace all three together if the video changes.

## IndexNow (automatic search-engine ping)

`.github/workflows/indexnow.yml` notifies Bing of changed pages after every push to `main`. It needs the key file `d70462cd3ff3e807d19c6573b881ad75.txt` at the root. Never delete or rename either one.

## Thinkific theme (grovecirclehealing.thinkific.com)

`thinkific/` holds the master copy of the brand styling for the Thinkific school (not part of the website; `.vercelignore` keeps it off Vercel). Git does not update Thinkific by itself.

- `gch-thinkific-theme.css` = the brand CSS. `theme_wide_css-append.liquid` = the same CSS wrapped as the block that sits at the end of **Theme → Snippets → `theme_wide_css`** in the live theme "Vogue (Copy 2)" (id 669653). Rebuild the append file whenever the CSS changes.
- `upcoming-classes.md` = Chris's wording for the coming membership classes.
- **Workflow:** edit the CSS here first → rebuild the append file → paste it over the brand block in Thinkific's `theme_wide_css` and save (goes live on save) → commit and push here. If Thinkific and this folder ever disagree, copy what's live in Thinkific back into this folder before editing.
- **Any styling change to the website (`styles.css`, colours, fonts, buttons) must be mirrored in `gch-thinkific-theme.css` and pasted into Thinkific**, so the school keeps matching the site.
- Monthly class update on Thinkific: countdown heading/subheading and end time (UTC: 18:00 in winter, 17:00 in summer = 10 AM Pacific) in the site builder, and the artwork URL in the "Next class artwork" block of the CSS.
