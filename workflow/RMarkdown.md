---
layout: page
title: R Markdown
permalink: /r_markdown
---

> *Fully reproducible approach to turn your analyses into high quality documents, reports, presentations and dashboards.*

R Markdown provides an easy way to produce a rich, fully-documented reproducible analysis. It allows the user to share a single file that contains all of the prose, code, and metadata needed to reproduce the analysis from beginning to end. R Markdown allows for "chunks" of R code to be included along with Markdown text to produce a nicely formatted HTML, PDF, or Word file without having to know any HTML or LaTeX code or have to fuss with difficult formatting issues.  One R Markdown file can generate a variety of different formats and all of this is done in a single text file with a few bits of formatting.

<center>
<img src="/public/images/workflow/rmarkdown-image1.png" width="60%" height="60%"/>
</center>

So how does it work?  Creating documents with R Markdown starts with an .Rmd file that contains a combination of text and R code chunks. The .Rmd file is fed to `knitr`, which executes all of the R code chunks and creates a new markdown (.md) document with the output. Pandoc then processes the .md file to create a finished report in the form of a web page, PDF, Word document, slide show, etc.  

<center>
<img src="/public/images/workflow/RMarkdownFlow.png" width="90%" height="90%"/>
</center>

Sounds confusing you say, don't fret.  Much of what takes place happens behind the scenes.  You primarily need to worry only about the syntax required in the .Rmd file. You then press a button and out comes your report.

<center>
<img src="/public/images/workflow/RMarkdownFlow2.png" width="100%" height="100%"/>
</center>


## Creating an R Markdown File
To create an R Markdown file you can select **File**  &raquo; **New File** &raquo; **R Markdown** or you can select the shortcut for creating a new document in the top left-hand corner of the RStudio window. You will be given an option to create an HTML, PDF, or Word document; however, R Markdown let's you change seamlessly between these options after you've created your document so I tend to just select the default HTML option.  

<center>
<img src="/public/images/workflow/rmarkdown_create.gif" width="100%" height="100%"/>
</center>

There are additional options such as creating Presentations (HTML or PDF), Shiny documents, or other template documents but for now we will focus on the initial HTML, PDF, or Word document options.


## Components of an R Markdown File
There are three general components of an R Markdown file that you will eventually become accustomed to.  This includes the [YAML](#yaml), the [general markdown (or text) component](#text), and [code chunks](#chunks).

### YAML Header {#yaml}
The first few lines you see in the R Markdown report are known as the [YAML](http://www.yaml.org). 

```
---
title: "R Markdown Demo"
author: "Brad Boehmke"
date: "2016-08-15"
output: html_document
---
```

These lines will generate a generic heading at the top of the final report. There are several YAML options to enhance your reports such as the following:

You can include hyperlinks around the title or author name:

```
---
title: "R Markdown Demo"
author: "[Brad Boehmke](http://bradleyboehmke.github.io)"
date: "2016-08-15"
output: html_document
---
```


If you don't want the date to be hard-coded you can include R code so that anytime you re-run the report the current date will print off at the top.  You can also exclude the date (or author and title information) by including `NULL` or simply by deleting that line:

```
---
title: "R Markdown Demo"
author: "[Brad Boehmke](http://bradleyboehmke.github.io)"
date: "`r Sys.Date()`"
output: html_document
---
```

By default, your report will not include a table of contents (TOC).  However, you can easily generate one by including the `toc: true` argument.  There are several TOC options such as the level of headers to include in the TOC, whether to have a fixed or floating TOC, to have a collapsable TOC, etc.  You can find many of the TOC options [here](http://rmarkdown.rstudio.com/html_document_format.html#table_of_contents).

```
---
title: "R Markdown Demo"
author: "[Brad Boehmke](http://bradleyboehmke.github.io)"
date: "`r Sys.Date()`"
output: 
  html_document:
    toc: true
    toc_float: true
---
```

When knitr processes an R Markdown input file it creates a markdown (md) file which is subsequently tranformed into HTML by pandoc. If you want to keep a copy of the markdown file after rendering you can do so using the `keep_md: true` option.  This will likely not be a concern at first but when (if) you start doing a lot of online writing you will find that keeping the .md file is extremely beneficial.

```
---
title: "R Markdown Demo"
author: "[Brad Boehmke](http://bradleyboehmke.github.io)"
date: "`r Sys.Date()`"
output: 
  html_document:
    keep_md: true
---
```

There are many YAML options which you can read more about at:

- HTML reports: [http://rmarkdown.rstudio.com/html_document_format.html](http://rmarkdown.rstudio.com/html_document_format.html)
- PDF (LaTex) reports: [http://rmarkdown.rstudio.com/pdf_document_format.html](http://rmarkdown.rstudio.com/pdf_document_format.html)
- Word reports: [http://rmarkdown.rstudio.com/word_document_format.html](http://rmarkdown.rstudio.com/word_document_format.html)


### Text Formatting {#text}
The beauty of R Markdown is the ability to easily combine prose (text) and code.  For the text component, much of your writing is similar to when you type a Word document; however, to perform many of the basic text formatting you use basic markdown code such as:

<center>
<img src="/public/images/workflow/markdown_text.png" width="85%" height="85%"/>
</center>

There are many additional formatting options which can be viewed [here](http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html) and [here](http://daringfireball.net/projects/markdown/basics); however, this should get you well on your way.

### Code Chunks {#chunk}
R code chunks can be used as a means to render R output into documents or to simply display code for illustration. Code chunks start with the following line: <code>```{r chunk_name}</code> and end with <code>```</code>. You can quickly insert chunks into your R Markdown file with the keyboard shortcut **Cmd + Option + I** (Windows **Ctrl + Alt + I**).

Here is a simple R code chunk that will result in both the code and it’s output being included:


<pre><code>
```{r}
head(iris)
```
</code></pre>

<center>
<img src="/public/images/workflow/code_chunks.png" width="100%" height="100%"/>
</center>

Chunk output can be customized with many [knitr options](http://yihui.name/knitr/options/) which are arguments set in the `{}` of a chunk header. Examples include:

1\. `echo=FALSE` hides the code but displays results:

<pre><code> 
```{r echo=FALSE}
x <- rnorm(100)
y <- 2 * x + rnorm(100)

cor(x, y)
```
</code></pre>

2\. `results='hide'` hides the results but shows the code

<pre><code>
```{r results='hide'}
x <- rnorm(100)
y <- 2 * x + rnorm(100)

cor(x, y)
```
</code></pre>

3\. `eval=FALSE` displays the code but does not evaluate it

<pre><code> 
```{r eval=FALSE}
x <- rnorm(100)
y <- 2 * x + rnorm(100)

cor(x, y)
```
</code></pre>

4\. `include=FALSE` evaluates the code but does not display code *or* output

<pre><code> 
```{r include=FALSE}
x <- rnorm(100)
y <- 2 * x + rnorm(100)

cor(x, y)
```
</code></pre>

5\. `warning=FALSE` and `message=FALSE` are useful for suppressing any messages produced when loading packages

<pre><code> 
```{r, warning=FALSE, message=FALSE}
library(dplyr)
```
</code></pre>

6\. `collapse=TRUE` will collapse your output to be contained within the code chunk

<pre><code> 
```{r, collapse=TRUE}
head(iris)
```
</code></pre>


7\. `fig...` options are available to align and size figure outputs

<pre><code> 
```{r, fig.align='center', fig.height=3, fig.width=4}
library(ggplot2)

ggplot(iris, aes(Sepal.Length, Sepal.Width, color = Species)) +
        geom_point()
```
</code></pre>

<center>
<img src="/public/images/workflow/code_chunk_examples.png" width="100%" height="100%"/>
</center>

#### Inline code chunks
A key motivation for reproducible research is to link any results reported directly to the data and functions used to create them. Consequently, you should never manual insert numbers such as "The average miles per gallon is 20.1."  Rather, code results can be inserted directly into the text of a .Rmd file by enclosing the code with <code>`r `</code> such as:  "The average miles per gallon is <code>`r mean(mtcars$mpg)`</code>."  

Now if the underlying data changes you do not need to remember all the inline values you manually entered. You may not like the fact that the output is reporting all the decimals. You could include the `round` function in the inline code: <code>`r round(mean(mtcars$mpg), 1)` </code>.

<center>
<img src="/public/images/workflow/inline_code_chunks.png" width="100%" height="100%"/>
</center>

#### Dealing with Tables

By default, the table outputs produced in R Markdown will look like the output you would see in your console. However, if you prefer that data be displayed with additional formatting you can use the knitr::kable function. For example:

<pre><code>
```{r, results='asis'}
knitr::kable(iris)
```
</code></pre>

To include captions:

<pre><code>
```{r}
knitr::kable(head(iris), caption = 'Example caption for the iris data frame')
```
</code></pre>

The simplest approach to print nice looking tables is to use the [`printr`](http://yihui.name/printr/) package which can be downloaded from this GitHub [repo](https://github.com/yihui/printr).

<pre><code>
```{r}
library(printr)

head(iris)
```
</code></pre>

<center>
<img src="/public/images/workflow/rmarkdown_tables.png" width="100%" height="100%"/>
</center>

There are several packages that can be used to make very nice packages:

- [`printr`](http://yihui.name/printr/)
- [`xtable`](https://cran.r-project.org/web/packages/xtable/vignettes/xtableGallery.pdf)
- [`stargazer`](https://cran.r-project.org/web/packages/stargazer/vignettes/stargazer.pdf)
- [`tables`](https://cran.r-project.org/web/packages/tables/vignettes/tables.pdf)
- [`pander`](http://rapporter.github.io/pander/)


## Knitting the R Markdown File
When you are all done writing your .Rmd document you have two options to render the output.  The first is to call the following function in your console: `render("document_name.Rmd", output_format = "html_document")`. Alternatively you can click the drop down arrow next to the `knit` button on the RStudio toolbar, select the document format (HTML, PDF, Word) and your report will be developed.

<center>
<img src="/public/images/workflow/rmarkdown_generate.gif" width="100%" height="100%"/>
</center>

The following output formats are available to use with R Markdown.

### Documents

- [html_notebook](http://rmarkdown.rstudio.com/r_notebooks.html) - Interactive R Notebooks
- [html_document](http://rmarkdown.rstudio.com/html_document_format.html) - HTML document w/ Bootstrap CSS
- [pdf_document](http://rmarkdown.rstudio.com/pdf_document_format.html) - PDF document (via LaTeX template)
- [word_document](http://rmarkdown.rstudio.com/word_document_format.html) - Microsoft Word document (docx)
- [odt_document](http://rmarkdown.rstudio.com/odt_document_format.html) - OpenDocument Text document
- [rtf_document](http://rmarkdown.rstudio.com/rtf_document_format.html) - Rich Text Format document
- [md_document](http://rmarkdown.rstudio.com/markdown_document_format.html) - Markdown document (various flavors)

### Presentations (slides)

- [ioslides_presentation](http://rmarkdown.rstudio.com/ioslides_presentation_format.html) - HTML presentation with ioslides
- [revealjs::revealjs_presentation](http://rmarkdown.rstudio.com/revealjs_presentation_format.html) - HTML presentation with reveal.js
- [slidy_presentation](http://rmarkdown.rstudio.com/slidy_presentation_format.html) - HTML presentation with W3C Slidy
- [beamer_presentation](http://rmarkdown.rstudio.com/beamer_presentation_format.html) - PDF presentation with LaTeX Beamer

### More

- [flexdashboard::flex_dashboard](http://rmarkdown.rstudio.com/flexdashboard/) - Interactive dashboards
- [tufte::tufte_handout](http://rmarkdown.rstudio.com/tufte_handout_format.html) - PDF handouts in the style of Edward Tufte
- [tufte::tufte_html](http://rmarkdown.rstudio.com/tufte_handout_format.html) - HTML handouts in the style of Edward Tufte
- [tufte::tufte_book](http://rmarkdown.rstudio.com/tufte_handout_format.html) - PDF books in the style of Edward Tufte
- [html_vignette](http://rmarkdown.rstudio.com/package_vignette_format.html) - R package vignette (HTML)
- [github_document](http://rmarkdown.rstudio.com/github_document_format.html) - GitHub Flavored Markdown document
- [bookdown](https://bookdown.org/) - Write HTML, PDF, ePub, and Kindle books with R Markdown

## Additional Resources
R Markdown is an incredible tool for reproducible research and there are a lot of resource available.  Here are just a few of the available resources to learn more about R Markdown.

- [Rstudio tutorials](http://rmarkdown.rstudio.com/)
- [R Markdown course by DataCamp](https://www.datacamp.com/community/blog/r-markdown-tutorial-reproducible-reporting-in-r#gs.4iluNvI)
- [Karl Browman's tutorial](http://kbroman.org/knitr_knutshell/pages/Rmarkdown.html)
- [Daring Fireball](http://daringfireball.net/projects/markdown/)
- [Reproducible Research course on Coursera](https://www.coursera.org/learn/reproducible-research/)
- [Chester Ismay's book](https://ismayc.github.io/rbasics-book/)

Also, you can find the R Markdown cheatsheet [here](https://www.rstudio.com/wp-content/uploads/2016/03/rmarkdown-cheatsheet-2.0.pdf) or within the RStudio console at Help menu &raquo; Cheatsheets.

<center>
<img src="/public/images/workflow/rmarkdown_cheatsheet.png" width="100%" height="100%"/>
</center>
