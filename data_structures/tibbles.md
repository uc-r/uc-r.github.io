---
layout: page
title: Managing Tibbles
permalink: /tibbles
---

Tibbles are data frames, but they tweak some older behaviors to make life a little easier. The name comes from `dplyr`: originally you created these objects with `tbl_df()`, which was most easily pronounced as “tibble diff”.  Tibbles are provide by the `tibbles` package (which also comes automatically in the `tidyverse` package). This tutorial covers the basics of tibbles but you can always learn more by reading through the vignette `vignette("tibble")`.  This tutorial will cover the following:

- [Creating tibbles](#create)
- [Comparing tibbles to data frames](#compare)

### Prerequisite

Load the `tibbles` package with one of the following:

```r
# directly
library(tibbles)

# indirectly - also loads readr, tidyr, dplyr, purrr
library(tidyverse)
```

## Creating Tibbles {#create}

Most other R packages use regular data frames, so you might want to coerce a data frame to a tibble. You can do that with `as_tibble()`:

```r
as_tibble(iris)
#> # A tibble: 150 × 5
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#>          <dbl>       <dbl>        <dbl>       <dbl>  <fctr>
#> 1          5.1         3.5          1.4         0.2  setosa
#> 2          4.9         3.0          1.4         0.2  setosa
#> 3          4.7         3.2          1.3         0.2  setosa
#> 4          4.6         3.1          1.5         0.2  setosa
#> 5          5.0         3.6          1.4         0.2  setosa
#> 6          5.4         3.9          1.7         0.4  setosa
#> # ... with 144 more rows
```

You can create a new tibble from individual vectors with `tibble()`. `tibble()` will automatically recycle inputs of length 1, and allows you to refer to variables that you just created, as shown below.

```r
tibble(
  x = 1:5, 
  y = 1, 
  z = x ^ 2 + y
)
#> # A tibble: 5 × 3
#>       x     y     z
#>   <int> <dbl> <dbl>
#> 1     1     1     2
#> 2     2     1     5
#> 3     3     1    10
#> 4     4     1    17
#> 5     5     1    26
```

If you’re already familiar with `data.frame()`, note that `tibble()` does much less: it never changes the type of the inputs (e.g. it never converts strings to factors!), it never changes the names of variables, and it never creates row names.

It’s possible for a tibble to have column names that are not valid R variable names, aka *non-syntactic* names. For example, they might not start with a letter, or they might contain unusual characters like a space. To refer to these variables, you need to surround them with backticks (<code>`</code>): 

```r
tb <- tibble(
  `:)` = "smile", 
  ` ` = "space",
  `2000` = "number"
)

tb
#> # A tibble: 1 × 3
#>    `:)`   ` ` `2000`
#>   <chr> <chr>  <chr>
#> 1 smile space number
```

You’ll also need the backticks when working with these variables in other packages, like ggplot2, dplyr, and tidyr.

Another way to create a tibble is with `tribble()`, short for *transposed* tibble. `tribble()` is customised for data entry in code: column headings are defined by formulas (i.e. they start with `~`), and entries are separated by commas. This makes it possible to lay out small amounts of data in easy to read form.

```r
tribble(
  ~x, ~y, ~z,
  #--|--|----
  "a", 2, 3.6,
  "b", 1, 8.5
)
#> # A tibble: 2 × 3
#>       x     y     z
#>   <chr> <dbl> <dbl>
#> 1     a     2   3.6
#> 2     b     1   8.5
```

Adding a comment such as with the line starting with `#` makes it really clear where the header is.

## Comparing Tibbles to Data Frames {#compare}

There are two main differences in the usage of a tibble vs. a classic data.frame: printing and subsetting.

### Printing

Tibbles have a refined print method that shows <u>only</u> the first 10 rows along with the number of columns that will fit on your screen. This makes it much easier to work with large data. In addition to its name, each column reports its type, a nice feature borrowed from `str()`:

```r
tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)
#> # A tibble: 1,000 × 5
#>                     a          b     c     d     e
#>                <dttm>     <date> <int> <dbl> <chr>
#> 1 2016-12-02 20:12:04 2016-12-09     1 0.368     h
#> 2 2016-12-03 14:17:13 2016-12-14     2 0.612     n
#> 3 2016-12-03 08:40:52 2016-12-24     3 0.415     l
#> 4 2016-12-02 22:02:10 2016-12-23     4 0.212     x
#> 5 2016-12-02 18:26:26 2016-12-20     5 0.733     a
#> 6 2016-12-03 05:27:23 2016-12-16     6 0.460     v
#> # ... with 994 more rows
```

Tibbles are designed so that you don’t accidentally overwhelm your console when you print large data frames. But sometimes you need more output than the default display. There are a few options that can help.

First, you can explicitly `print()` the data frame and control the number of rows (n) and the width of the display. `width = Inf` will display all columns:

```r
nycflights13::flights %>% 
  print(n = 10, width = Inf)
```

You can also control the default print behaviour by setting options:

- `options(tibble.print_max = n, tibble.print_min = m)`: if more than m rows, print only n rows. Use options(dplyr.print_min = Inf) to always show all rows.
- Use `options(tibble.width = Inf)` to always print all columns, regardless of the width of the screen.

You can see a complete list of options by looking at the package help with `package?tibble`.

A final option is to use RStudio’s built-in data viewer to get a scrollable view of the complete dataset. This is also often useful at the end of a long chain of manipulations.

```r
nycflights13::flights %>% 
  View()
```


### Subsetting

If you want to pull out a single variable, you need the same tools you've seen for subsetting/indexing the other data structures (`$` and `[[`). `[[` can extract by name or position; `$` only extracts by name but is a little less typing.

```r
df <- tibble(
  x = runif(5),
  y = rnorm(5)
)

# Extract by name
df$x
#> [1] 0.434 0.395 0.548 0.762 0.254
df[["x"]]
#> [1] 0.434 0.395 0.548 0.762 0.254

# Extract by position
df[[1]]
#> [1] 0.434 0.395 0.548 0.762 0.254
```
To use these with the [pipe operator](pipe), you’ll need to use the special placeholder `.`:

```r
df %>% .$x
#> [1] 0.434 0.395 0.548 0.762 0.254
df %>% .[["x"]]
#> [1] 0.434 0.395 0.548 0.762 0.254
```
Note that compared to a data.frame, tibbles are more strict: they never do partial matching, and they will generate a warning if the column you are trying to access does not exist.
