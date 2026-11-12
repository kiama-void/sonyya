# Sonyya

A minimalist Jekyll personal blog for notes, research, and technical writing.

## Local development

```bash
bundle install
bundle exec jekyll serve --livereload
```

Then open `http://localhost:4000`.

## Publish to GitHub Pages

Push the repository to GitHub and enable GitHub Pages in the repository settings. For a repository site, use the default branch (`main`) and the root folder (`/`).

## Writing a new post

Create a new file in `_posts/` named like:

```bash
_posts/2026-11-15-example-post.md
```

With front matter:

```yaml
---
layout: post
title: "Example Title"
date: 2026-11-15
categories: [machine-learning]
description: "A short summary for the homepage and archive."
reading_time: "4 min read"
---
```
