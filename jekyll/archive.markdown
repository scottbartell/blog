---
title: Archive
layout: page
---

Here are all of the posts I've written. Bam.

{% for post in site.posts %}
* [{{ post.title }}]({{ post.url }})<span> &mdash; {{ post.date | date_to_string }}</span>
{% endfor %}
