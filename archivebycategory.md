---
layout: page
title: Archive
permalink: /categoryview/
sitemap: false
---
    
<font size="6">Categories</font>
<div>
    {% assign categories = site.categories | sort %}
    {% for category in categories %}
     <span class="site-category">
        <a href="#{{ category | first | slugify }}">
               <font size="4" style="font-variant: small-caps"> {{ category[0] | replace:'-', ' ' }} ({{ category | last | size }}) </font>
        </a>
        &nbsp;
    </span>
    {% endfor %}
</div>

<br>
<br>

<font size="6">Tags</font>
<div>
    {% assign tags = site.tags | sort %}
    {% for tag in tags %}
     <span class="site-tag">
        <a href="#{{ tag | first | slugify }}">
               <font size="3"> {{ tag[0] | replace:'-', ' ' }} ({{ tag | last | size }}) </font>
        </a>
        &nbsp;
    </span>
    {% endfor %}
</div>

<br>
<br>


<font size="6">Post by Categories</font>
<div id="category-index">
    {% for category in categories %}
        <a name="{{ category[0] }}"></a><strong><font size="5" style="font-variant: small-caps">{{ category[0] | replace:'-', ' ' }} ({{ category | last | size }}) </font></strong>
        <br>
    {% assign sorted_posts = site.posts | sort: 'title' %}
    {% for post in sorted_posts %}
    {%if post.categories contains category[0]%}
     <a href="{{ site.baseurl }}{{ post.url }}" title="{{ post.title }}">{{ post.title }}</a>
    <br>
    {%endif%}
    {% endfor %}
    <br>
    {% endfor %}
</div>

<small><a href="#">Go to top</a></small>

<br>
<br>


<font size="6">Post by Tags</font>
<div id="tag-index">
    {% for tag in tags %}
        <a name="{{ tag[0] }}"></a><strong>{{ tag[0] | replace:'-', ' ' }} ({{ tag | last | size }}) </strong>
        <br>
    {% assign sorted_posts = site.posts | sort: 'title' %}
    {% for post in sorted_posts %}
    {%if post.tags contains tag[0]%}
     <a href="{{ site.baseurl }}{{ post.url }}" title="{{ post.title }}">{{ post.title }}</a>
    <br>
    {%endif%}
    {% endfor %}
    <br>
    {% endfor %}
</div>

<small><a href="#">Go to top</a></small>
