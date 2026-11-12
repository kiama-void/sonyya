---
layout: default
title: Home
permalink: /
---

<section class="intro">
  <p class="eyebrow">Sonyya</p>
  <h1>Notes on learning, building, and thinking carefully.</h1>
  <p class="lead">
    I write about artificial intelligence, machine learning, engineering experiments,
    mathematics, and the kinds of ideas that only become clear after a few honest attempts.
  </p>
</section>

<section class="home-posts">
  <div class="section-heading">
    <h2>Writing</h2>
    <a href="{{ '/archive/' | relative_url }}">Archive</a>
  </div>

  {% for post in site.posts limit:6 %}
    <article class="post-preview">
      <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %-d, %Y" }}</time>
      <h3><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h3>
      {% if post.description %}
        <p>{{ post.description }}</p>
      {% endif %}
    </article>
  {% endfor %}
</section>

<section class="home-about">
  <p>
    This is a notebook for ideas in progress: a place to document experiments, trace reasoning,
    and keep the useful parts of exploration from disappearing into the noise.
  </p>
</section>
