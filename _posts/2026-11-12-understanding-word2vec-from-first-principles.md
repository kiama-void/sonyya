---
layout: post
title: "Understanding Word2Vec from First Principles"
date: 2026-11-12
categories: [machine-learning, embeddings]
description: "Exploring CBOW and Skip-gram through implementation, intuition, and the geometry of distributed representations."
reading_time: "7 min read"
---

Word2Vec is often described as a small miracle: an embedding model that learns meaningful similarity structure from raw text with no manual labels. The beauty is not in the complexity of the model, but in the way a simple prediction objective turns co-occurrence patterns into geometry.

At its core, the model asks a deceptively simple question: given a word, can I predict nearby words? The answer is yes, and the intermediate representation becomes a map of meaning.

## The intuition

The central idea is that words appearing in similar contexts should have similar vector representations. If two words are used in comparable syntactic and semantic environments, they should cluster together in embedding space.

This is not a magical assumption. It is a consequence of distributional semantics: language meaning is encoded by context.

## Continuous bag-of-words and skip-gram

Word2Vec offers two complementary formulations:

- CBOW predicts a target word from its surrounding context.
- Skip-gram predicts the surrounding context from the target word.

In other words, one model treats the context as evidence and the other treats the token as evidence. Despite the asymmetry, they optimize related objectives.

### Why the objective matters

The model is not memorizing word lists. It learns to produce vector representations that make plausible words near a given token more likely than implausible ones. Over many examples, this turns a vocabulary into a structured semantic space.

The resulting vectors are useful because distance and direction can reflect semantic relationships. This is why words like "king" and "queen" or "cat" and "dog" often land in similar neighborhoods.

## A first-principles view

If we define the probability of a neighboring word given a token as a function of their vectors, the optimization problem becomes a structured classification task. The model updates embeddings to improve these conditional probabilities across a corpus.

The result is not merely a compressed representation. It is a learned coordinate system for language.

> The most important idea is that the meaning is not stored explicitly in a dictionary; it emerges from repeated contextual relationships.

The elegance of the method is that it transforms local statistical regularities into global geometric structure.

## Implementation notes

The practical implementation usually includes:

1. A vocabulary built from the corpus.
2. Context windows that define neighboring words.
3. Dense embeddings for both input and output vectors.
4. A negative sampling or softmax-based training objective.

In a simple implementation, the training loop is straightforward: sample pairs of words from nearby positions, compute the score between their representations, and update gradients to improve the likelihood of observed co-occurrences.

This is still one of the clearest examples of representation learning in AI: a model learns a useful internal structure from raw data without any handcrafted feature engineering.

## What makes it enduring

Word2Vec remains influential for several reasons:

- It is conceptually simple.
- It scales surprisingly well.
- It produces reusable vectors.
- It connects language structure with geometric intuition.

Even in modern transformer-era systems, the idea of learning context-sensitive embeddings remains essential. The premise is still the same: useful representations come from structure in data, not from labels alone.

The challenge now is not whether embeddings are useful, but how to make them dynamic, contextual, and richly expressive across tasks.

That is the larger arc of representation learning: from static meaning to dynamic meaning, from local context to global abstraction.
