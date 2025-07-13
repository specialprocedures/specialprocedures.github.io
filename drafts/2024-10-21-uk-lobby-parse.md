---
layout: post
title: "UK Lobbying Data: Part 1"
subtitle: "Initial exploration and declaration modelling"
date: 2021-07-01 16:45:13 -0400
background: '/img/posts/helloworld/jekyll-hyde.jpg'
---
## Fixing lobbyist reporting with LLMs
One of the biggest quality issues with Ministerial Returns is that we are not able do any systematic analysis of the lobbyists at meetings. 

The information is present in the data, but in a free-text form which is tough to parse. For example, a Minister may report that they had a meeting with:

> "Eldon Tyrell of the Tyrell Corporation & his assistant Rachel, Rick Deckard of the LAPD, and UA Northride (a subsidiary of Weyland-Yutani Corporation)". 

Why is this a problem? The Open Access platform (and good old regular expressions) provide effective ways to *search* records, helping us identify **how many times a lobbyist has met a Minister**, but this data **can't easily tell us all the lobbyists a Minister has met**.