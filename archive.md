---
layout: page
title: Archive
permalink: /archive/
---

<div class="archive-list">
  {% for post in site.posts %}
    <article class="archive-item">
      <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %-d, %Y" }}</time>
      <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
      <p>{{ post.description }}</p>
    </article>
  {% endfor %}
</div>
