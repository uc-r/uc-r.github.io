---
layout: page
title: NULL
---

[R Vocab Topics](index) &#187; [Character Strings](characters) &#187; Character string basics

* <a href="#creating">Creating character strings</a> 
* <a href="#converting">Converting to character strings</a> 
* <a href="#printing">Printing strings</a>
* <a href="#counting_elements">Assessing number of elements in string</a>
* <a href="#counting_char">Assessing number of characters in string</a>

<br>

<a name="creating"></a>

## Creating Strings

The most basic way to create strings is to use quotation marks and assign a string to an object similar to creating number sequences.

{% highlight r %}
a <- "learning to create"    # create string a
b <- "character strings"     # create string b
{% endhighlight %}

The `paste()` function provides a versatile means for creating and building strings. It takes one or more R objects, converts them to "character", and then it concatenates (pastes) them to form one or several character strings.


{% highlight r %}
# paste together string a & b
paste(a, b)                      
## [1] "learning to create character strings"

# paste character and number strings (converts numbers to character class)
paste("The life of", pi)           
## [1] "The life of 3.14159265358979"

# paste multiple strings
paste("I", "love", "R")            
## [1] "I love R"

# paste multiple strings with a separating character
paste("I", "love", "R", sep = "-")  
## [1] "I-love-R"

# use paste0() to paste without spaces btwn characters
paste0("I", "love", "R")            
## [1] "IloveR"

# paste objects with different lengths
paste("R", 1:5, sep = " v1.")       
## [1] "R v1.1" "R v1.2" "R v1.3" "R v1.4" "R v1.5"
{% endhighlight %}

<br>

<a name="converting"></a>

## Converting to Strings
Test if strings are characters with `is.character()` and convert strings to character with `as.character()` or with `toString()`.

{% highlight r %}
a <- "The life of"    
b <- pi

is.character(a)
## [1] TRUE

is.character(b)
## [1] FALSE

c <- as.character(b)
is.character(c)
## [1] TRUE

toString(c("Aug", 24, 1980))
## [1] "Aug, 24, 1980"
{% endhighlight %}


<br>

<a name="printing"></a>

## Printing Strings
The common printing methods include:


**Function**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**Description**

<a href="#print">`print()`</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;generic printing

<a href="#noquote">`noquote()`</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;print with no quotes

<a href="#cat">`cat()`</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;concatenate

<a href="#sprintf">`sprintf()`</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printing

<br>

<a name="print"></a>

### print()
The primary printing function in R is `print()`

{% highlight r %}
x <- "learning to print strings"    

# basic printing
print(x)                
## [1] "learning to print strings"

# print without quotes
print(x, quote = FALSE)  
## [1] learning to print strings
{% endhighlight %}


<br>

<a name="noquote"></a>

### noquote()
An alternative to printing without quotes.

{% highlight r %}
noquote(x)
## [1] learning to print strings
{% endhighlight %}


<br>

<a name="cat"></a>

### cat()
Another very useful function is `cat()` which allows us to concatenate objects and print them either on screen or to a file.  The output result is very similar to `noquote()`; however, `cat()` does not print the numeric line indicator.  As a result, `cat()` can be useful for printing nicely formated responses to users.


{% highlight r %}
# basic printing (similar to noquote)
cat(x)                   
## learning to print strings

# combining character strings
cat(x, "in R")           
## learning to print strings in R

# basic printing of alphabet
cat(letters)             
## a b c d e f g h i j k l m n o p q r s t u v w x y z

# specify a seperator between the combined characters
cat(letters, sep = "-")  
## a-b-c-d-e-f-g-h-i-j-k-l-m-n-o-p-q-r-s-t-u-v-w-x-y-z

# collapse the space between the combine characters
cat(letters, sep = "")   
## abcdefghijklmnopqrstuvwxyz
{% endhighlight %}

You can also format the line width for printing long strings using the `fill` argument:

{% highlight r %}
x <- "Today I am learning how to print strings."
y <- "Tomorrow I plan to learn about textual analysis."
z <- "The day after I will take a break and drink a beer."

cat(x, y, z, fill = 0)
## Today I am learning how to print strings. Tomorrow I plan to learn about textual analysis. The day after I will take a break and drink a beer.

cat(x, y, z, fill = 5)
## Today I am learning how to print strings. 
## Tomorrow I plan to learn about textual analysis. 
## The day after I will take a break and drink a beer.
{% endhighlight %}

<br>

<a name="sprintf"></a>

### sprintf()
A wrapper for the C function `sprintf`, that returns a character vector containing a formatted combination of text and variable values.

To substitute in a string or string variable, use `%s`:

{% highlight r %}
x <- "print strings"

# substitute a single string/variable
sprintf("Learning to %s in R", x)    
## [1] "Learning to print strings in R"

# substitute multiple strings/variables
y <- "in R"
sprintf("Learning to %s %s", x, y)   
## [1] "Learning to print strings in R"
{% endhighlight %}


For integers, use `%d` or a variant:

{% highlight r %}
version <- 3

# substitute integer
sprintf("This is R version:%d", version)
## [1] "This is R version:3"

# print with leading spaces
sprintf("This is R version:%4d", version)   
## [1] "This is R version:   3"

# can also lead with zeros
sprintf("This is R version:%04d", version)   
## [1] "This is R version:0003"
{% endhighlight %}


For floating-point numbers, use `%f` for standard notation, and `%e` or `%E` for exponential notation:

{% highlight r %}
sprintf("%f", pi)         # '%f' indicates 'fixed point' decimal notation
## [1] "3.141593"

sprintf("%.3f", pi)       # decimal notation with 3 decimal digits
## [1] "3.142"

sprintf("%1.0f", pi)      # 1 integer and 0 decimal digits
## [1] "3"

sprintf("%5.1f", pi)      # decimal notation with 5 total decimal digits and only 1 to the right of the decimal point
## [1] "  3.1"

sprintf("%05.1f", pi)     # same as above but fill empty digits with zeros
## [1] "003.1"

sprintf("%+f", pi)        # print with sign (positive)
## [1] "+3.141593"

sprintf("% f", pi)        # prefix a space
## [1] " 3.141593"

sprintf("%e", pi)         # exponential decimal notation 'e'
## [1] "3.141593e+00"

sprintf("%E", pi)         # exponential decimal notation 'E'
## [1] "3.141593E+00"
{% endhighlight %}


<br>

<a name="counting_elements"></a>

## Counting Elements
To count the number of elements in a string use `length()`:

{% highlight r %}
length("How many elements are in this string?")
## [1] 1

length(c("How", "many", "elements", "are", "in", "this", "string?"))
## [1] 7
{% endhighlight %}

<br>

<a name="counting_char"></a>

## Counting Characters
To count the number of characters in a string use `nchar()`:

{% highlight r %}
nchar("How many characters are in this string?")
## [1] 39

nchar(c("How", "many", "characters", "are", "in", "this", "string?"))
## [1]  3  4 10  3  2  4  7
{% endhighlight %}

<br>

<small><a href="#">Go to top</a></small>
