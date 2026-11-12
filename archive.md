---
layout: page
title: Articles
permalink: /archive/
---

<p class="page-lead">Longer pieces: explanations, experiments, and worked-through ideas. <a href="{{ '/explore/' | relative_url }}">Filter by topic or tag →</a></p>

{% assign years = site.posts | group_by_exp: 'p', "p.date | date: '%Y'" %}
{% for y in years %}
  <section class="year-group">
    <h2 class="year-label">{{ y.name }} <span>{{ y.items.size }}</span></h2>
    <ol class="year-list">
      {% for post in y.items %}
        <li>
          <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%b %-d" }}</time>
          <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
          {% if post.categories.size > 0 %}<a class="row-tag" href="{{ '/explore/' | relative_url }}?topic={{ post.categories | first | slugify }}">{{ post.categories | first | replace: '-', ' ' }}</a>{% endif %}
        </li>
      {% endfor %}
    </ol>
  </section>
{% endfor %}
