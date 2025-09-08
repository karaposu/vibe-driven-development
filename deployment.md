Here’s a clean, copy-paste-ready path to get an **mdBook** site online with **GitHub Pages**—free, fast, and fully Git-driven.

# 0) Prereqs

* A GitHub repo with your Markdown.
* Local mdBook:

  * macOS: `brew install mdbook`
  * Linux: `cargo install mdbook` (or grab a prebuilt binary from mdBook releases)
  * Windows: `cargo install mdbook` (or prebuilt binary)

---

# 1) Initialize mdBook

In your repo (root or a subfolder you choose as the book root):

```bash
cd <your-repo>
mdbook init .
```

This creates:

```
book.toml
src/
  SUMMARY.md
  chapter_1.md
```

---

# 2) Move your Markdown & define the nav

* Put all chapters into `src/`.
* Edit `src/SUMMARY.md` to define structure (order = nav). Example:

```markdown
# Summary

- [Introduction](intro.md)
- [Getting Started](getting-started.md)
- [Deep Dive](deep-dive/index.md)
  - [Part A](deep-dive/part-a.md)
  - [Part B](deep-dive/part-b.md)
- [Appendix](appendix.md)
```

---

# 3) Configure `book.toml`

Open `book.toml` and set basics:

```toml
[book]
title = "Your Book Title"
authors = ["<your name>"]
language = "en"
src = "src"

[build]
build-dir = "book"

[output.html]
default-theme = "light"
preferred-dark-theme = "ayu"
# Optional but nice: canonical URL (adjust for your repo or custom domain)
site-url = "https://<username>.github.io/<repo>/"

# "Edit this page" link (works on mdBook ≥ 0.4.28)
edit-url-template = "https://github.com/<username>/<repo>/edit/main/src/{path}"

# Optional extras
copy-fonts = true
no-section-label = false
```

> Tip: mdBook uses **relative links**, so it works fine under a subpath like `/repo/` on GitHub Pages.

---

# 4) Preview locally

```bash
mdbook serve -n 127.0.0.1 -p 3000
```

Open [http://127.0.0.1:3000](http://127.0.0.1:3000) to check navigation, search, and theming.

---

# 5) Commit your book source

```bash
git add book.toml src
git commit -m "Add mdBook structure"
git push
```

---

# 6) Set up **GitHub Actions** (recommended modern Pages flow)

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy mdBook to GitHub Pages

on:
  push:
    branches: [ "main" ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      # Fast installer for mdBook (prebuilt)
      - name: Install mdBook
        uses: taiki-e/install-action@v2
        with:
          tool: mdbook@latest

      - name: Build
        run: mdbook build

      # Ensure Pages doesn't run Jekyll on output
      - name: Add .nojekyll
        run: touch book/.nojekyll

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: book

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

Push it:

```bash
git add .github/workflows/deploy.yml
git commit -m "Add Pages deploy workflow"
git push
```

---

# 7) Flip the Pages switch (one-time)

On GitHub: **Settings → Pages → Build and deployment → Source = GitHub Actions**.
After the next push to `main`, your site publishes at:

```
https://<username>.github.io/<repo>/
```

---

# 8) (Optional) Custom domain

In **Settings → Pages**, set your domain (e.g., `docs.example.com`).
Add a `CNAME` DNS record to `username.github.io`.
If you prefer generating the `CNAME` file during build, add:

```yaml
- name: Add CNAME
  run: echo "docs.example.com" > book/CNAME
```

---

# 9) (Optional) Alternative: classic `gh-pages` branch

If you like the old push-to-branch flow:

```yaml
name: Deploy mdBook via gh-pages

on:
  push:
    branches: [ "main" ]
  workflow_dispatch:

permissions:
  contents: write

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: taiki-e/install-action@v2
        with:
          tool: mdbook@latest

      - run: mdbook build && touch book/.nojekyll

      - name: Publish to gh-pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: book
          force_orphan: true
```

Then set **Settings → Pages → Source = gh-pages**.

---

# 10) Quality-of-life tips

* Keep `book/` out of Git: add `book/` to `.gitignore`.
* Images: store under `src/` and reference relatively: `![alt](images/diagram.png)`.
* Internal links: use relative Markdown links (same as GitHub).
* Big repos/monorepos: place the book in `docs/` or `book/` subdir and update `src` in `book.toml`.

---
