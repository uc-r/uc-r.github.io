---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Data Structures](data_structures) &#187; Vector

<br>

The basic structure in R is the vector.  A vector is a sequence of data elements of the same basic type: [integer](integer_double), [double](integer_double), logical, or [character](char_basics) (there are two additional vector types which I will not discuss - complex and raw). This tutorial provides you with the basics of managing vectors.

* <a href="#creating">Creating</a>
* <a href="#adding">Adding on to</a>
* <a href="#attributes">Adding attributes</a>
* <a href="#subsetting">Subsetting</a>

<br>

<a name="creating"></a>

## Creating
The `c()` function can be used to create vectors of objects by concatenating things together:

{% highlight r %}
# integer vector
w <- 8:17
w
##  [1]  8  9 10 11 12 13 14 15 16 17

# double vector
x <- c(0.5, 0.6, 0.2)
x
## [1] 0.5 0.6 0.2

# logical vector
y1 <- c(TRUE, FALSE, FALSE)
y1
## [1]  TRUE FALSE FALSE

y2 <- c(T, F, F) ## shorthand
y2
## [1]  TRUE FALSE FALSE

# Character vector
z <- c("a", "b", "c") ## character
z
## [1] "a" "b" "c"
{% endhighlight %}

You can also use the `as.vector()` function to initialize vectors or change the vector type:

{% highlight r %}
v <- as.vector(8:17)
v
##  [1]  8  9 10 11 12 13 14 15 16 17

# turn numerical vector to character
as.vector(v, mode = "character")
##  [1] "8"  "9"  "10" "11" "12" "13" "14" "15" "16" "17"
{% endhighlight %}

All elements of a vector must be the same type, so when you attempt to combine different types of elements they will be coerced to the most flexible type possible:

{% highlight r %}
# numerics are turned to characters
str(c("a", "b", "c", 1, 2, 3))
##  chr [1:6] "a" "b" "c" "1" "2" "3"

# logical are turned to numerical...
str(c(1, 2, 3, TRUE, FALSE))
##  num [1:5] 1 2 3 1 0

# or character
str(c("A", "B", "C", TRUE, FALSE))
##  chr [1:5] "A" "B" "C" "TRUE" "FALSE"
{% endhighlight %}

<br>

<a name="adding"></a>

## Adding on to
To add additional elements to a pre-existing vector we can continue to leverage the `c()` function.  Also, note that vectors are always flat so nested `c()` functions will not add additional dimensions to the vector:

{% highlight r %}
v1 <- 8:17

c(v1, 18:22)
##  [1]  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22

# same as
c(v1, c(18, c(19, c(20, c(21:22)))))
##  [1]  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22
{% endhighlight %}


<br>

<a name="attributes"></a>

## Adding attributes
The attributes that you can add vectors includes names and comments:

{% highlight r %}
# currently no attributes exist for vector v1
attributes(v1)
## NULL

# we can add names to vectors
names(v1) <- letters[1:length(v1)]
v1
##  a  b  c  d  e  f  g  h  i  j 
##  8  9 10 11 12 13 14 15 16 17
attributes(v1)
## $names
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j"

# adding names when creating vectors
v2 <- c(name1 = 1, name2 = 2, name3 = 3)
v2
## name1 name2 name3 
##     1     2     3
attributes(v2)
## $names
## [1] "name1" "name2" "name3"

# adding comments to vectors acts as a note to the user
# without changing how the vector behaves
comment(v1) <- "This is a comment on a vector"
v1
##  a  b  c  d  e  f  g  h  i  j 
##  8  9 10 11 12 13 14 15 16 17
attributes(v1)
## $names
##  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j"
## 
## $comment
## [1] "This is a comment on a vector"
{% endhighlight %}


<br>

<a name="subsetting"></a>

## Subsetting
The four main ways to subset a vector include combining square brackets [ ] with:

* <a href="#positive">Positive integers</a>
* <a href="#negative">Negative integers</a>
* <a href="#logical">Logical values</a>
* <a href="#names">Names</a>

You can also subset with double brackets `[[ ]]` for <a href="#simplify">simplifying subsets</a>.

<a name="positive"></a>

### Positive Integers
Subsetting with positive integers returns the elements at the specified positions:

{% highlight r %}
v1
##  a  b  c  d  e  f  g  h  i  j 
##  8  9 10 11 12 13 14 15 16 17

v1[2]
## b 
## 9

v1[2:4]
##  b  c  d 
##  9 10 11

v1[c(2, 4, 6, 8)]
##  b  d  f  h 
##  9 11 13 15

# note that you can duplicate index positions
v1[c(2, 2, 4)]
##  b  b  d 
##  9  9 11
{% endhighlight %}

<a name="negative"></a>

### Negative Integers
Subsetting with negative integers will omit the elements at the specified positions:

{% highlight r %}
v1[-1]
##  b  c  d  e  f  g  h  i  j 
##  9 10 11 12 13 14 15 16 17

v1[-c(2, 4, 6, 8)]
##  a  c  e  g  i  j 
##  8 10 12 14 16 17
{% endhighlight %}

<a name="logical"></a>

### Logical values
Subsetting with logical values will select the elements where the corresponding logical value is `TRUE`:

{% highlight r %}
v1[c(TRUE, FALSE, TRUE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE, TRUE)]
##  a  c  e  f  g  j 
##  8 10 12 13 14 17

v1[v1 < 12]
##  a  b  c  d 
##  8  9 10 11

v1[v1 < 12 | v1 > 15]
##  a  b  c  d  i  j 
##  8  9 10 11 16 17

# if logical vector is shorter than the length of the vector being
# subsetted, it will be recycled to be the same length
v1[c(TRUE, FALSE)]
##  a  c  e  g  i 
##  8 10 12 14 16
{% endhighlight %}

<a name="names"></a>

### Names
Subsetting with names will return the elements with the matching names specified:

{% highlight r %}
v1["b"]
## b 
## 9

v1[c("a", "c", "h")]
##  a  c  h 
##  8 10 15
{% endhighlight %}

<a name="simplify"></a>

### Simplifying vs. Preserving
Its also important to understand the difference between simplifying and preserving subsetting.  **Simplifying** subsets returns the simplest possible data structure that can represent the output. **Preserving** subsets keeps the structure of the output the same as the input.

For vectors, subsetting with single brackets `[ ]` preserves while subsetting with double brackets `[[ ]]` simplifies.  The change you will notice when simplifying vectors is the removal of names and/or factor levels:

{% highlight r %}
v1[1]
## a 
## 8

v1[[1]]
## [1] 8

# drop factor levels
f <- factor(c("low", "medium", "high", "high", "low"), levels = c("low", "medium", "high"))
f[-2, drop = TRUE]
## [1] low  high high low 
## Levels: low high
{% endhighlight %}

<br>

<small><a href="#">Go to top</a></small>
