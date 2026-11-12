---
layout: default
title: Home
permalink: /
---

<section class="intro">
  <h1>Notes on learning, building, and thinking carefully.</h1>
  <p class="lead">
    I write about artificial intelligence, machine learning, engineering experiments,
    mathematics, and the kinds of ideas that only become clear after a few honest attempts.
  </p>
</section>

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
