---
id: 1836
title: Dealing with Numbers
date: 2016-06-10
author: Brad Boehmke
layout: page
permalink: /section3_numbers/
---

* [Integer vs. Double](http://uc-r.github.io/integer_double)
* [Generating sequence of non-random numbers](http://uc-r.github.io/generating_sequence_numbers)
* [Generating sequence of random numbers](http://uc-r.github.io/generating_random_numbers)
* [Setting the seed for reproducible random numbers](http://uc-r.github.io/setting_seed)
* [Comparing numeric values](http://uc-r.github.io/comparing_numeric_values)
* [Rounding numbers](http://uc-r.github.io/rounding/)

<br>



## Key functions you'll find in this section

<table class="w3-table-all" style="width:100%">
<tr>
	<th>Operator/Function</th>
	<th>Description</th>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/integer_double/#type"><code>typeof()</code></a></td>
	<td>identify if numbers are integer or double</td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/integer_double/#integer"><code>L</code></a></td>
	<td>explicitly states number should be an integer</td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/integer_double/#convert"><code>as.numeric()</code></a></td>
	<td>change value(s) to numeric (specifically double precision floating point numbers)</td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/generating_sequence_numbers/#seq1"><code>:</code></a></td>
	<td>create sequence of numbers from m to n (increments of 1)</td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/generating_sequence_numbers/#seq1"><code>c()</code></a></td>
	<td>combine numeric values into a sequence</td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/generating_sequence_numbers/#seq2"><code>seq()</code></a></td>
	<td>create sequence of numbers with specific arithmetic progression</td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/generating_sequence_numbers/#seq3"><code>rep()</code></a></td>
	<td>create collated and non-collated repetitions of numbers</td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/generating_random_numbers/#uniform"><code>sample()</code></a></td>
	<td>take random sample with or without replacement</td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/generating_random_numbers/#uniform"><code>runif()</code></a></td>
	<td>generate random numbers from a uniform distribution</td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/generating_random_numbers/#normal"><code>rnorm()</code></a></td>
	<td>generate random numbers from a normal distribution - prefix options: <code>d</code>, <code>p</code>, or <code>q</code> for density function, cumulative function, or quantiles respectively</td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/generating_random_numbers/#poisson"><code>rpois()</code></a></td>
	<td>generate random numbers from a poisson distribution - prefix options: <code>d</code>, <code>p</code>, or <code>q</code></td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/generating_random_numbers/#exponential"><code>rexp()</code></a></td>
	<td>generate random numbers from an exponential distribution - prefix options: <code>d</code>, <code>p</code>, or <code>q</code></td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/generating_random_numbers/#gamma"><code>rgamma()</code></a></td>
	<td>generate random numbers from a gamma distribution - prefix options: <code>d</code>, <code>p</code>, or <code>q</code></td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/setting_seed/"><code>set.seed()</code></a></td>
	<td>sets the seed number for reproducible random number generation</td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/comparing_numeric_values/#numeric_comparison"><code><, >, <=, >=, ==, !=</code></a></td>
	<td>logic operators to compare values of each element</td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/comparing_numeric_values/#numeric_exact"><code>identical()</code></a></td>
	<td>test if all values in two objects are exactly equal</td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/comparing_numeric_values/#numeric_near"><code>all.equal()</code></a></td>
	<td>test for ‘near equality’ values in two objects</td>
</tr>
<tr>
	<td><a href="http://uc-r.github.io/rounding"><code>round()</code></a></td>
	<td>round values to the nearest integer</td>
</tr>
</table>
