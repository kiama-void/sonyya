---
layout: default
title: Home
permalink: /
---

<div class="home-grid">
  <section class="home-posts">
    <div class="section-heading">
      <h2>Articles <span class="count">{{ site.posts.size }}</span></h2>
      <a href="{{ '/archive/' | relative_url }}">All articles</a>
    </div>

    {% for post in site.posts limit:5 %}
      <article class="post-preview">
        <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%b %-d, %Y" }}</time>
        <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
        {% if post.description %}
          <p>{{ post.description }}</p>
        {% endif %}
      </article>
    {% else %}
      <p class="empty">No articles yet.</p>
    {% endfor %}
  </section>

  {% assign thoughts = site.thoughts | sort: 'date' | reverse %}
  <aside class="home-thoughts">
    <div class="section-heading">
      <h2>Thoughts <span class="count">{{ thoughts.size }}</span></h2>
      <a href="{{ '/thoughts/' | relative_url }}">All thoughts</a>
    </div>
    {% for t in thoughts limit:5 %}
      {% include thought-card.html thought=t %}
    {% else %}
      <p class="empty">Nothing here yet.</p>
    {% endfor %}
  </aside>
</div>
