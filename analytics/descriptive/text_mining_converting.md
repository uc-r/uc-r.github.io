---
layout: tutorial
title: Text Mining&#58; Converting Between Tidy & Non-tidy Formats
permalink: /text_conversion
---

In the previous text mining tutorials, we’ve been analyzing text using the __*tidy text*__ format: a table with one-token-per-document-per-row, such as is constructed by the `unnest_tokens` function. This allows us to efficiently pipe our analysis directly into the popular suite of tidy tools such as [`dplyr`](dplyr), [`tidyr`](tidyr), and [`ggplot2`](ggplot) to explore and visualize text data. We’ve demonstrated that many informative text analyses can be performed using these tools.

However, most of the existing R tools for natural language processing, with the exception of the `tidytext` package, do not use a tidy text format. The [CRAN Task View for Natural Language Processing](https://cran.r-project.org/web/views/NaturalLanguageProcessing.html) lists a large selection of packages that take other structures of input and provide non-tidy outputs. These packages are very useful in text mining applications, and many existing text datasets are structured according to these formats. Thus, its extremely important to understand how to convert back-and-forth between different formats.

The below image illustrates how an analysis might switch between tidy and non-tidy data structures and tools. 

<figure>
<img src="/public/images/analytics/descriptives/tidyflow.png" style="display: block; margin: auto;" />
<figcaption><font size="3" color="dimgrey">Fig1: A flowchart of a typical text analysis that combines tidytext with other tools and data formats, particularly the tm or quanteda packages (<a href="http://tidytextmining.com/">Silge & Robinson, 2017</a>).</font></figcaption>
</figure>

## tl'dr

This tutorial will focus on the process of tidying document-term matrices, as well as casting a tidy data frame into a __*sparse matrix*__.[^tidy] We’ll also expore how to tidy Corpus objects, which combine raw text with document metadata, into text data frames, leading to a case study of ingesting and analyzing financial articles.

1. [Replication requirements](#rep): What you’ll need to reproduce the analysis in this tutorial.
2. [Tidying a document-term matrix](#tidydtm): Tidying the most common text mining data structure.
3. [Casting tidy text data into a matrix](#casting): Be able to go from tidy to non-tidy.
4. [Tidying corpus objects with metadata](#meta): Tidying corpus data that includes metadata.


## Replication Requirements {#rep}

This tutorial leverages the data provided in the [`harrypotter` package](https://github.com/bradleyboehmke/harrypotter).  I constructed this package to supply the first seven novels in the Harry Potter series to illustrate text mining and analysis capabilities.  You can load the `harrypotter` package with the following:


```r
if (packageVersion("devtools") < 1.6) {
  install.packages("devtools")
}

devtools::install_github("bradleyboehmke/harrypotter")
```


```r
library(tidyverse)      # data manipulation & plotting
library(stringr)        # text cleaning and regular expressions
library(tidytext)       # provides additional text mining functions
library(harrypotter)    # provides the first seven novels of the Harry Potter series
```

The seven novels we are working with, and are provided by the `harrypotter` package, include:

- `philosophers_stone`: Harry Potter and the Philosophers Stone (1997)
- `chamber_of_secrets`: Harry Potter and the Chamber of Secrets (1998)
- `prisoner_of_azkaban`: Harry Potter and the Prisoner of Azkaban (1999)
- `goblet_of_fire`: Harry Potter and the Goblet of Fire (2000)
- `order_of_the_phoenix`: Harry Potter and the Order of the Phoenix (2003)
- `half_blood_prince`: Harry Potter and the Half-Blood Prince (2005)
- `deathly_hallows`: Harry Potter and the Deathly Hallows (2007)

Each text is in a character vector with each element representing a single chapter.  For instance, the following illustrates the raw text of the first two chapters of the `philosophers_stone`:


```r
philosophers_stone[1:2]
## [1] "THE BOY WHO LIVED　　Mr. and Mrs. Dursley, of number four, Privet Drive, were proud to say that they 
## were perfectly normal, thank you very much. They were the last people you'd expect to be involved in anything 
## strange or mysterious, because they just didn't hold with such nonsense.　　Mr. Dursley was the director of a 
## firm called Grunnings, which made drills. He was a big, beefy man with hardly any neck, although he did have a 
## very large mustache. Mrs. Dursley was thin and blonde and had nearly twice the usual amount of neck, which came
## in very useful as she spent so much of her time craning over garden fences, spying on the neighbors. The 
## Dursleys had a small son called Dudley and in their opinion there was no finer boy anywhere.　　The Dursleys 
## had everything they wanted, but they also had a secret, and their greatest fear was that somebody would 
## discover it. They didn't think they could bear it if anyone found out about the Potters. Mrs. Potter was Mrs. 
## Dursley's sister, but they hadn'... <truncated>
## [2] "THE VANISHING GLASS　　Nearly ten years had passed since the Dursleys had woken up to find their nephew on
## the front step, but Privet Drive had hardly changed at all. The sun rose on the same tidy front gardens and lit
## up the brass number four on the Dursleys' front door; it crept into their living room, which was almost exactly
## the same as it had been on the night when Mr. Dursley had seen that fateful news report about the owls. Only
## the photographs on the mantelpiece really showed how much time had passed. Ten years ago, there had been lots
## of pictures of what looked like a large pink beach ball wearing different-colored bonnets -- but Dudley Dursley
## was no longer a baby, and now the photographs showed a large blond boy riding his first bicycle, on a carousel 
## at the fair, playing a computer game with his father, being hugged and kissed by his mother. The room held no
## sign at all that another boy lived in the house, too.　　Yet Harry Potter was still there, asleep at the
## moment, but no... <truncated>
```


## Tidying DTM & DFMs {#tidydtm}

One of the most common structures that text mining packages work with is the [document-term matrix](https://en.wikipedia.org/wiki/Document-term_matrix) (or DTM). This is a matrix where:

- each row represents one document (such as a book or article),
- each column represents one term, and
- each value (typically) contains the number of appearances of that term in that document.

Since most pairings of document and term do not occur (they have the value zero), DTMs are usually implemented as sparse matrices. These objects can be treated as though they were matrices (for example, accessing particular rows and columns), but are stored in a more efficient format. We’ll discuss several implementations of these matrices in this tutorial.

DTM objects cannot be used directly with tidy tools, just as tidy data frames cannot be used as input for most text mining packages. Thus, the `tidytext` package provides two functions that convert between the two formats.

- __`tidy()`__ turns a document-term matrix into a tidy data frame. This function comes from the `broom` package, which provides similar tidying functions for many statistical models and objects.
- __`cast()`__ turns a tidy one-term-per-row data frame into a matrix. `tidytext` provides three variations of this function, each converting to a different type of matrix: `cast_sparse()` (converting to a sparse matrix from the Matrix package), `cast_dtm()` (converting to a DocumentTermMatrix object from tm), and `cast_dfm()` (converting to a dfm object from quanteda).

As shown in the introductory figure above, a DTM is typically comparable to a tidy data frame after a `count` or a `group_by`/`summarize` that contains counts or another statistic for each combination of a term and document.

Perhaps the most widely used implementation of DTMs in R is the `DocumentTermMatrix` class in the `tm` package. Many available text mining datasets are provided in this format.  Here, we convert the `philosophers_stone` data into a `DocumentTermMatrix`:


```r
library(tm)

ps_dtm <- VectorSource(philosophers_stone) %>%
  VCorpus() %>%
  DocumentTermMatrix(control = list(removePunctuation = TRUE,
                                    removeNumbers = TRUE,
                                    stopwords = TRUE))

inspect(ps_dtm)
## <<DocumentTermMatrix (documents: 17, terms: 8383)>>
## Non-/sparse entries: 20435/122076
## Sparsity           : 86%
## Maximal term length: 29
## Weighting          : term frequency (tf)
## Sample             :
##     Terms
## Docs back didnt got hagrid harry hermione like one ron said
##   1    15    22   7     10    17        0    9   6   0   32
##   10   10     6   9      0    62       15    9  13  38   37
##   12   24    15   7     18    65        5   20  18  38   45
##   15   19    12  10     39    65       18   12  16  10   54
##   16   16    19  23     14    85       45   12  27  48  104
##   17   15    10  13      9    58       11   11  16  17   56
##   5    19    13  16     77   102        0   13  20   0   83
##   6    19    17  25      9    70        8   11  19  50   90
##   7     9    10  10      3    41        2   13  14   9   30
##   9    17    11  11      2    45       13    9   8  31   44
```

We see that this dataset contains documents (chapters 1-17 of `philosophers_stone`) along the rows and terms (distinct words) along the columns. Notice that this DTM is 86% sparse (86% of document-word pairs are zero). We could access the terms in the document with the `Terms()` function.


```r
terms <- Terms(ps_dtm)
head(terms)
## [1] "　　a"                   "　　aaaargh　　quirrell"
## [3] "　　aha"                 "　　all"                
## [5] "　　and"                 "　　as"
```

If we wanted to analyze this data with tidy tools, we would first need to turn it into a data frame with one-token-per-document-per-row. The broom package introduced the `tidy()` function, which takes a non-tidy object and turns it into a tidy data frame. The `tidytext` package implements this method for DocumentTermMatrix objects.


```r
ps_tidy <- tidy(ps_dtm)
ps_tidy
## # A tibble: 20,435 × 3
##    document           term count
##       <chr>          <chr> <dbl>
## 1         1 　　dumbledore     1
## 2         1         　　my     1
## 3         1        　　yes     1
## 4         1           able     2
## 5         1         across     2
## 6         1            act     1
## 7         1         acting     1
## 8         1       admiring     1
## 9         1         affect     1
## 10        1      afternoon     1
## # ... with 20,425 more rows
```

Notice that we now have a tidy three-column data frame, with variables *document*, *term*, and *count*.  This form is convenient for analysis with the `dplyr`, `tidytext` and `ggplot2` packages. For example, we can efficiently roll into a frequency analysis with this data structure to identify the top 5 most used terms in each chapter:


```r
# note that I use drlib functions for ordering bars within facets
# you can download this package with devtools::install_github("dgrtwo/drlib") 

ps_tidy %>%
  group_by(document) %>%
  top_n(5) %>%
  ungroup() %>%
  mutate(document = factor(as.numeric(document), levels = 1:17)) %>%
  ggplot(aes(drlib::reorder_within(term, count, document), count)) +
  geom_bar(stat = "identity") +
  xlab("Top 5 Common Words") +
  drlib::scale_x_reordered() +
  coord_flip() +
  facet_wrap(~ document, scales = "free")
```

<img src="/public/images/analytics/descriptives/convert_freq-1.png" style="display: block; margin: auto;" />


Another common text mining approach is to use *Document-Feature-Matrix* (`dfm`) objects.  For example, we can convert the `philosophers_stone` text data into a `dfm` using the `quanteda` package.


```r
ps_dfm <- quanteda::dfm(philosophers_stone, verbose = FALSE)

ps_dfm
## Document-feature matrix of: 17 documents, 5,992 features (79.7% sparse).
```

We can also use the `tidy` function on this type of object to convert it into a tidied data frame:


```r
ps_tidy <- tidy(ps_dfm)
ps_tidy
## # A tibble: 20,688 × 3
##    document  term count
##       <chr> <chr> <dbl>
## 1     text1   the   204
## 2     text2   the   181
## 3     text3   the   222
## 4     text4   the   127
## 5     text5   the   274
## 6     text6   the   282
## 7     text7   the   252
## 8     text8   the   147
## 9     text9   the   207
## 10   text10   the   256
## # ... with 20,678 more rows
```


## Casting Tidy Text Data into a Matrix {#casting}

As we saw above, the `tidy` function can be used to tidy common text mining objects.  However, there are many reasons that these popular text mining packages use these non-tidy data objects.  Most importantly, it allows for efficient algorithmic procedures.  Thus, it is important to be able to switch back and forth between tidy and non-tidy text mining objects.  

For example, an analyst may tidy up their text data and perform some common text mining procedures with the `tidytext` package as we've seen in the previous text mining tutorials ([here](tidy_text), [here](sentiment_analysis), [here](tf-idf_analysis), and [here](word_relationships)).  The analyst may then want to convert to a DTM or DFM to perform a bootstrap to resample across the corpus (or some other analytic technique) and then convert back to a tidy object.

We can use `cast`, which provides three variations of converting a tidy text object to a matrix: `cast_sparse()` (converting to a sparse matrix from the Matrix package), `cast_dtm()` (converting to a DocumentTermMatrix object from tm), and `cast_dfm()` (converting to a dfm object from quanteda.


```r
# cast tidy data to a DFM
ps_tidy %>%
  cast_dfm(term, document, count)
## Document-feature matrix of: 5,992 documents, 17 features (79.7% sparse).

# cast tidy data to a DTM
ps_tidy %>%
  cast_dtm(term, document, count)
## <<DocumentTermMatrix (documents: 5992, terms: 17)>>
## Non-/sparse entries: 20688/81176
## Sparsity           : 80%
## Maximal term length: 6
## Weighting          : term frequency (tf)

# cast tidy data to a sparse matrix
ps_tidy %>%
  cast_sparse(term, document, count) %>%
  dim
## [1] 5992   17
```

This casting process allows for reading, filtering, and processing to be done using dplyr and other tidy tools, after which the data can be converted into a document-term matrix for machine learning applications.


## Tidying Corpus Objects with Metadata {#meta}

Many text mining packages provide a data structure that is designed to store document collections before tokenization, called a “corpus”. One common example is `Corpus` objects from the `tm` package. These store text alongside metadata, which may include an ID, date/time, title, or language for each document.

For example, 


```r
# turning philosophers_stone into a corpus
ps_corpus <- VectorSource(philosophers_stone) %>%
  VCorpus()

# viewing corpus
ps_corpus
## <<VCorpus>>
## Metadata:  corpus specific: 0, document level (indexed): 0
## Content:  documents: 17
```

A corpus object is structured like a list, with each item containing both text and metadata. This is a flexible storage method for documents, but doesn’t lend itself to processing with tidy tools.


```r
# viewing document 1 in the corpus
ps_corpus[[1]]
## <<PlainTextDocument>>
## Metadata:  7
## Content:  chars: 25928
```

We can thus use the `tidy()` method to construct a table with one row per document, including the metadata (such as ID and date-time stamps) as columns alongside the text. The example below is not very interesting because the `philosophers_stone` data does not have any metadata other than `id` (chapter) and `datetimestamp` (if no date-time stamp is available then the current date-time will be filled in).


```r
ps_tidy <- tidy(ps_corpus)
ps_tidy
## # A tibble: 17 × 8
##    author       datetimestamp description heading    id language origin
##     <lgl>              <dttm>       <lgl>   <lgl> <chr>    <chr>  <lgl>
## 1      NA 2017-05-16 08:07:49          NA      NA     1       en     NA
## 2      NA 2017-05-16 08:07:49          NA      NA     2       en     NA
## 3      NA 2017-05-16 08:07:49          NA      NA     3       en     NA
## 4      NA 2017-05-16 08:07:49          NA      NA     4       en     NA
## 5      NA 2017-05-16 08:07:49          NA      NA     5       en     NA
## 6      NA 2017-05-16 08:07:49          NA      NA     6       en     NA
## 7      NA 2017-05-16 08:07:49          NA      NA     7       en     NA
## 8      NA 2017-05-16 08:07:49          NA      NA     8       en     NA
## 9      NA 2017-05-16 08:07:49          NA      NA     9       en     NA
## 10     NA 2017-05-16 08:07:49          NA      NA    10       en     NA
## 11     NA 2017-05-16 08:07:49          NA      NA    11       en     NA
## 12     NA 2017-05-16 08:07:49          NA      NA    12       en     NA
## 13     NA 2017-05-16 08:07:49          NA      NA    13       en     NA
## 14     NA 2017-05-16 08:07:49          NA      NA    14       en     NA
## 15     NA 2017-05-16 08:07:49          NA      NA    15       en     NA
## 16     NA 2017-05-16 08:07:49          NA      NA    16       en     NA
## 17     NA 2017-05-16 08:07:49          NA      NA    17       en     NA
## # ... with 1 more variables: text <chr>
```



To give a better example, let's look at the built-in data set `acq` provided by the `tm` package.


```r
data("acq")
acq
## <<VCorpus>>
## Metadata:  corpus specific: 0, document level (indexed): 0
## Content:  documents: 50
```

`acq` contains 50 articles from the news service Reuters.  If we look at the first document we see that it includes metadata. Note that a corpus is structured like a list so we can index it just like we index a list.


```r
acq[[1]]
## <<PlainTextDocument>>
## Metadata:  15
## Content:  chars: 1287
```

If we use `tidy` on this data set you now notice that the metadata is more informative and provides additional variables to analyze our data.  We could now look at most commons word by article, author, date, analyze the titles (*heading*), or a mariad of other analyses.  Bottom line, the metadata can be very informative in our analysis and using `tidy` allows us to include this information as variables.


```r
(tidy_acq <- tidy(acq))
## # A tibble: 50 × 16
##                       author       datetimestamp description
##                        <chr>              <dttm>       <chr>
## 1                       <NA> 1987-02-26 10:18:06            
## 2                       <NA> 1987-02-26 10:19:15            
## 3                       <NA> 1987-02-26 10:49:56            
## 4  By Cal Mankowski, Reuters 1987-02-26 10:51:17            
## 5                       <NA> 1987-02-26 11:08:33            
## 6                       <NA> 1987-02-26 11:32:37            
## 7      By Patti Domm, Reuter 1987-02-26 11:43:13            
## 8                       <NA> 1987-02-26 11:59:25            
## 9                       <NA> 1987-02-26 12:01:28            
## 10                      <NA> 1987-02-26 12:08:27            
## # ... with 40 more rows, and 13 more variables: heading <chr>, id <chr>,
## #   language <chr>, origin <chr>, topics <chr>, lewissplit <chr>,
## #   cgisplit <chr>, oldid <chr>, places <list>, people <lgl>, orgs <lgl>,
## #   exchanges <lgl>, text <chr>
```


## Summary

Text analysis requires working with a variety of tools, many of which have inputs and outputs that aren’t in a tidy form. This tutorial shows how to convert between a tidy text data frame and sparse document-term matrices, as well as how to tidy a Corpus object containing document metadata. 


[^tidy]: This tutorial is largely borrowed from Chapter 5 of the wonderful [Text Mining with R](http://tidytextmining.com) book.
