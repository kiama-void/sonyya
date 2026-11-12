---
layout: post
title: "Token"
categories: [tokenization]
tags: [llm, tokenization]
---


- A token is a piece of text, a short sequence of bytes, that an LLM treats as one unit. 
- The vocabulary lives in the tokenizer and maps text to IDs. The embedding table is the first layer of the LLM and maps IDs to vectors.

Two things I had wrong going in. They were my assumptions, not necessarily yours.

> **Is a character the smallest piece a token can be?**
>
> No. Tokenizers split bytes, not characters. One symbol can be many bytes, and many tokens:
>
> | Symbol | Bytes | Split into tokens (o200k_base) |
> |---|---|---|
> | 👍 plain | 4 | 👍 → `82514` |
> | 👍🏽 skin tone | 8 | 👍 → `82514` + 🏽 colour → `52622, 121` |
> | 中 common Chinese | 3 | 中 → `1404` |
> | 龘 rare Chinese | 3 | bytes `E9 BE` → `54462` + byte `98` → `246` |
>
> ![The family emoji encoded with o200k_base: three person emojis, each two tokens, joined by two \u200d characters of one token each]({{ '/assets/images/tokenization/family-emoji-tokens.png' | relative_url }})
>
> <!-- TODO: Why does a rare Chinese character take more than one token when 中 may not? Why does the family emoji take 18 bytes? Two lines. -->
{: .note }

> **Does a token have its own vector?**
>
> Yes , but only a starting point
> "Bank" starts from the same row in *river bank* and *bank account*. The model's layers reshape it using context.
{: .note data-thread="embedding-training"}

<!-- TODO (Q4): Add the emoji figure. Show one emoji, its token IDs, and each token decoded on its own (the unreadable symbols). -->




## Why subwords

Text can be split at any level: sentence, word, subword, character, byte.

**Sentences.** Sentences have no maximum length, so the number of possible sentences has no limit. No finite vocabulary can hold them, and any sentence the tokenizer hasn't seen has no ID.

**Words.** *car* and *cars* get unrelated IDs, and so do *play*, *playing* and *played*. Nothing links them, so the model learns each one separately. 

**Characters.** The vocabulary is tiny, but [sequences](#term:sequence-length) get much longer.

> **How much longer is text at character level?**
>
> Measured on this post's own text, scaled to 1,000 words:
>
> | Split by | Sequence length |
> |---|---|
> | Words | 1,000 |
> | Tokens (o200k_base) | ~1,260 |
> | Characters | ~5,600 |
>
> Characters make the sequence longer than tokens do. Attention compares every token with every other one, so its cost grows with the square of the length. 
{: .note .misconception}

| | Vocabulary size | [Sequence length](#term:sequence-length) | Unseen words | Related words share pieces |
|---|---|---|---|---|
| Word | Very large | Short | Fail | No |
| Character | Tiny | Very long | Handled | Not as meaningful units |
| Subword | Tens to hundreds of thousands | Short | Split into smaller pieces | Sometimes |


## Where tokens live

The tokenizer sits outside the model and is trained separately, on its own data. It has four parts:

1. **Vocabulary:** the list of tokens and their IDs.
2. **Regex pattern:** pre-splits text into chunks before merging.
3. **Merge rules:** which pairs combine into a new token.
4. **Special tokens:** added by hand, not learned, for example end-of-text.

A byte-level tokenizer has no unknown token. Every input is bytes, and all 256 bytes are in the vocabulary.

## When tokenization happens

The tokenizer is built from a corpus with [BPE](#term:bpe) before the model is trained, then frozen.

At runtime, input text is encoded into IDs. At each output step the model scores every ID in the vocabulary, one ID is picked, and it is decoded back to text.

{% include experiment.html id="token-counts" %}