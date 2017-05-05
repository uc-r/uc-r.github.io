---
layout: tutorial
title: An Introduction to `ggplot2`
permalink: /ggplot_intro
---

Being able to create __*visualizations*__ (graphical representations) of data is a key step in being able to communicate information and findings to others. In this module you will learn to use the __*`ggplot2`*__ library to declaratively make beautiful plots or charts of your data. Although R does provide built-in plotting functions, the `ggplot2` library implements the [Grammar of Graphics](https://www.amazon.com/Grammar-Graphics-Statistics-Computing/dp/0387245448/ref=sr_1_fkmr0_1?ie=UTF8&qid=1493924426&sr=8-1-fkmr0&keywords=grammar+of+graphics+ggplot). This makes it particularly effective for describing how visualizations should represent data, and has turned it into the preeminent plotting library in R. Learning this library will allow you to make nearly any kind of (static) data visualization, customized to your exact specifications.

<center>
<img src="http://bradleyboehmke.github.io/public/images/tufte/unnamed-chunk-1-1.png">
</center>

## tl;dr

This tutorial will provide a general introduction to the ggplot syntax.[^adapted]

- [Replication requirements](#rep): What you'll need to reproduce the code in this tutorial
- [Grammar of graphics](#grammar): Grammar of graphics gives us a way to talk about parts of a plot
- [The basics](#basics): Understanding the basics of the `ggplot` grammar
- [Aesthetic mappings](#aes): Mapping variables to visualization characteristics
- [Specifying geometric shapes](#geo): Plotting data with geometric shapes
- [Managing scales](#scales): Understanding the different scales you can control
- [Coordinate systems](#coord): Adjusting cartesian coordinate system
- [Facets](#facets): Creating small multiples
- [Labels & annotations](#labels): Ways to annotate your visualizations
- [Additional resources on `ggplot2`](#add): Resources to learn more about `ggplot2`
- [Other visualization libraries](#other): Popular interactive visualizations
 
## Replication requirements {#rep}

To reproduce the code throughout this tutorial you will need to load the `ggplot2` package. Note that `ggplot2` also comes with a number of built-in data sets. This tutorial will use the provided `mpg` data set as an example, which is a data frame that contains information about fuel economy for different cars.


```r
library(ggplot2)

mpg
## # A tibble: 234 × 11
##    manufacturer      model displ  year   cyl      trans   drv   cty   hwy
##           <chr>      <chr> <dbl> <int> <int>      <chr> <chr> <int> <int>
## 1          audi         a4   1.8  1999     4   auto(l5)     f    18    29
## 2          audi         a4   1.8  1999     4 manual(m5)     f    21    29
## 3          audi         a4   2.0  2008     4 manual(m6)     f    20    31
## 4          audi         a4   2.0  2008     4   auto(av)     f    21    30
## 5          audi         a4   2.8  1999     6   auto(l5)     f    16    26
## 6          audi         a4   2.8  1999     6 manual(m5)     f    18    26
## 7          audi         a4   3.1  2008     6   auto(av)     f    18    27
## 8          audi a4 quattro   1.8  1999     4 manual(m5)     4    18    26
## 9          audi a4 quattro   1.8  1999     4   auto(l5)     4    16    25
## 10         audi a4 quattro   2.0  2008     4 manual(m6)     4    20    28
## # ... with 224 more rows, and 2 more variables: fl <chr>, class <chr>
```


## Grammar of Graphics {#grammar}

Just as the grammar of language helps us construct meaningful sentences out of words, the [__*Grammar of Graphics*__](https://www.amazon.com/Grammar-Graphics-Statistics-Computing/dp/0387245448/ref=sr_1_fkmr0_1?ie=UTF8&qid=1493924426&sr=8-1-fkmr0&keywords=grammar+of+graphics+ggplot) helps us to construct graphical figures out of different visual elements. This grammar gives us a way to talk about parts of a plot: all the circles, lines, arrows, and words that are combined into a diagram for visualizing data. Originally developed by Leland Wilkinson, the Grammar of Graphics was [adapted by Hadley Wickham](https://www.amazon.com/ggplot2-Elegant-Graphics-Data-Analysis/dp/331924275X/ref=dp_ob_image_bk) to describe the components of a plot, including

- the **data** being plotted
- the **geometric objects** (circles, lines, etc.) that appear on the plot
- a set of mappings from variables in the data to the **aesthetics** (appearance) of the geometric objects
- a **statistical transformation** used to calculate the data values used in the plot
- a **position adjustment** for locating each geometric object on the plot
- a **scale** (e.g., range of values) for each aesthetic mapping used
- a **coordinate system** used to organize the geometric objects
- the **facets** or groups of data shown in different plots

Wickham further organizes these components into **layers**, where each layer has a single *geometric object, statistical transformation, and position adjustment*. Following this grammar, you can think of each plot as a set of layers of images, where each image’s appearance is based on some aspect of the data set. 

All together, this grammar enables us to discuss what plots look like using a standard set of vocabulary. And similar to how [`tidyr`](tidyr) and [`dplyr`](dplyr) provide efficient data transformation and manipulation, `ggplot2` provides more efficient ways to create specific visual images.

## The Basics {#basics}

In order to create a plot, you:

1. Call the `ggplot()` function which creates a blank canvas
2. Specify **aesthetic mappings**, which specifies how you want to map variables to visual aspects. In this case we are simply mapping the  *displ* and *hwy* variables to the x- and y-axes.
3. You then add new layers that are geometric objects which will show up on the plot. In this case we add `geom_point` to add a layer with *points* (dot) elements as the geometric shapes to represent the data.


```r
# create canvas
ggplot(mpg)

# variables of interest mapped
ggplot(mpg, aes(x = displ, y = hwy))

# data plotted
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()
```
<img src="/public/images/visual/intro/unnamed-chunk-3-1.png" style="display: block; margin: auto;" />


Note that when you added the `geom` layer you used the addition (`+`) operator.  As you add new layers you will always use `+` to add onto your visualization.

## Aesthetic Mappings {#aes}

The __*aesthetic mappings*__ take properties of the data and use them to influence visual characteristics, such as *position*, *color*, *size*, *shape*, or *transparency*. Each visual characteristic can thus encode an aspect of the data and be used to convey information.

All aesthetics for a plot are specified in the [aes()](http://ggplot2.tidyverse.org/reference/index.html#section-aesthetics) function call (later in this tutorial you will see that each `geom` layer can have its own `aes` specification). For example, we can add a mapping from the class of the cars to a *color* characteristic:


```r
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()
```

<img src="/public/images/visual/intro/unnamed-chunk-4-1.png" style="display: block; margin: auto;" />

Note that using the `aes()` function will cause the visual channel to be based on the data specified in the argument. For example, using `aes(color = "blue")` won’t cause the geometry’s color to be “blue”, but will instead cause the visual channel to be mapped from the vector `c("blue")` — as if we only had a single type of engine that happened to be called “blue”. If you wish to apply an aesthetic property to an entire geometry, you can set that property as an argument to the `geom` method, outside of the `aes()` call:


```r
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue")
```

<img src="/public/images/visual/intro/unnamed-chunk-5-1.png" style="display: block; margin: auto;" />

## Specifying Geometric Shapes {#geo}

Building on these basics, `ggplot2` can be used to build almost any kind of plot you may want. These plots are declared using functions that follow from the Grammar of Graphics.

The most obvious distinction between plots is what **geometric objects** (`geoms`) they include. `ggplot2` supports a number of different types of [`geoms`](http://ggplot2.tidyverse.org/reference/index.html#section-layer-geoms), including:

- `geom_point` for drawing individual points (e.g., a scatter plot)
- `geom_line` for drawing lines (e.g., for a line charts)
- `geom_smooth` for drawing smoothed lines (e.g., for simple trends or approximations)
- `geom_bar` for drawing bars (e.g., for bar charts)
- `geom_histogram` for drawing binned values (e.g. a histogram)
- `geom_polygon` for drawing arbitrary shapes
- `geom_map` for drawing polygons in the shape of a map! (You can access the data to use for these maps by using the [`map_data()`](http://ggplot2.tidyverse.org/reference/map_data.html) function).

Each of these geometries will leverage the aesthetic mappings supplied although the specific visual properties that the data will map to will vary. For example, you can map data to the `shape` of a `geom_point` (e.g., if they should be circles or squares), or you can map data to the `linetype` of a `geom_line` (e.g., if it is solid or dotted), but not vice versa.

Almost all `geoms` require an `x` and `y` mapping at the bare minimum.


```r
# Left column: x and y mapping needed!
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth()

# Right column: no y mapping needed!
ggplot(data = mpg, aes(x = class)) +
  geom_bar()  

ggplot(data = mpg, aes(x = hwy)) +
  geom_histogram() 
```

<img src="/public/images/visual/intro/unnamed-chunk-7-1.png" style="display: block; margin: auto;" />

What makes this really powerful is that you can add __*multiple*__ geometries to a plot, thus allowing you to create complex graphics showing multiple aspects of your data.


```r
# plot with both points and smoothed line
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth()
```

<img src="/public/images/visual/intro/unnamed-chunk-8-1.png" style="display: block; margin: auto;" />

Of course the aesthetics for each `geom` can be different, so you could show multiple lines on the same plot (or with different colors, styles, etc). It’s also possible to give each `geom` a different data argument, so that you can show multiple data sets in the same plot.

For example, we can plot both points and a smoothed line for the same `x` and `y` variable but specify unique colors within each `geom`:


```r
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "blue") +
  geom_smooth(color = "red")
```

<img src="/public/images/visual/intro/unnamed-chunk-9-1.png" style="display: block; margin: auto;" />

So as you can see if we specify an aesthetic within `ggplot` it will be passed on to each `geom` that follows.  Or we can specify certain aes within each `geom`, which allows us to only show certain characteristics for that specificy layer (i.e. `geom_point`).


```r
# color aesthetic passed to each geom layer
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  geom_smooth(se = FALSE)

# color aesthetic specified for only the geom_point layer
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(color = class)) +
  geom_smooth(se = FALSE)
```

<img src="/public/images/visual/intro/unnamed-chunk-11-1.png" style="display: block; margin: auto;" />

### Statistical Transformations

If you look at the below bar chart, you’ll notice that the the y axis was defined for us as the *count* of elements that have the particular type. This count isn’t part of the data set (it’s not a column in mpg), but is instead a __*statistical transformation*__ that the `geom_bar` automatically applies to the data. In particular, it applies the `stat_count` transformation.


```r
ggplot(mpg, aes(x = class)) +
  geom_bar()
```

<img src="/public/images/visual/intro/unnamed-chunk-12-1.png" style="display: block; margin: auto;" />

`ggplot2` supports many different statistical transformations. For example, the “identity” transformation will leave the data “as is”. You can specify which statistical transformation a `geom` uses by passing it as the `stat` argument.  For example, consider our data already had the count as a variable:


```r
class_count <- dplyr::count(mpg, class)
class_count
## # A tibble: 7 × 2
##        class     n
##        <chr> <int>
## 1    2seater     5
## 2    compact    47
## 3    midsize    41
## 4    minivan    11
## 5     pickup    33
## 6 subcompact    35
## 7        suv    62
```

We can use `stat = "identity"` within `geom_bar` to plot our bar height values to this variable.  Also, note that we now include *n* for our y variable:


```r
ggplot(class_count, aes(x = class, y = n)) +
  geom_bar(stat = "identity")
```

<img src="/public/images/visual/intro/unnamed-chunk-14-1.png" style="display: block; margin: auto;" />

We can also call `stat_` functions directly to add additional layers.  For example, here we create a scatter plot of highway miles for each displacement value and then use `stat_summary` to plot the mean highway miles at each displacement value.


```r
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(color = "grey") + 
  stat_summary(fun.y = "mean", geom = "line", size = 1, linetype = "dashed")
```

<img src="/public/images/visual/intro/unnamed-chunk-15-1.png" style="display: block; margin: auto;" />

### Position Adjustments

In addition to a default statistical transformation, each `geom` also has a default __*position adjustment*__ which specifies a set of “rules” as to how different components should be positioned relative to each other. This position is noticeable in a `geom_bar` if you map a different variable to the color visual characteristic:


```r
# bar chart of class, colored by drive (front, rear, 4-wheel)
ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar()
```

<img src="/public/images/visual/intro/unnamed-chunk-16-1.png" style="display: block; margin: auto;" />

The `geom_bar` by default uses a position adjustment of `"stack"`, which makes each rectangle’s height proprotional to its value and stacks them on top of each other. We can use the `position` argument to specify what position adjustment rules to follow: 


```r
# position = "dodge": values next to each other
ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar(position = "dodge")

# position = "fill": percentage chart
ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar(position = "fill")
```

<img src="/public/images/visual/intro/unnamed-chunk-18-1.png" style="display: block; margin: auto;" />

Check the documentation for each particular geom to learn more about its positioning adjustments.


## Managing Scales {#scales}

Whenever you specify an aesthetic mapping, `ggplot` uses a particular __*scale*__ to determine the range of values that the data should map to. Thus when you specify


```r
# color the data by engine type
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point()
```

`ggplot` automatically adds a scale for each mapping to the plot:


```r
# same as above, with explicit scales
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  scale_x_continuous() +
  scale_y_continuous() +
  scale_colour_discrete()
```

Each scale can be represented by a function with the following name: `scale_`, followed by the name of the aesthetic property, followed by an `_` and the name of the scale. A `continuous` scale will handle things like numeric data (where there is a *continuous* set of numbers), whereas a `discrete` scale will handle things like colors (since there is a small list of *distinct* colors).

While the default scales will work fine, it is possible to explicitly add different scales to replace the defaults. For example, you can use a scale to change the direction of an axis:


```r
# milage relationship, ordered in reverse
ggplot(mpg, aes(x = cty, y = hwy)) +
  geom_point() +
  scale_x_reverse() +
  scale_y_reverse()
```

<img src="/public/images/visual/intro/unnamed-chunk-21-1.png" style="display: block; margin: auto;" />

Similarly, you can use `scale_x_log10()` and `scale_x_sqrt()` to transform your scale. You can also use `scales` to format your axes:


```r
ggplot(mpg, aes(x = class, fill = drv)) + 
  geom_bar(position = "fill") +
  scale_y_continuous(breaks = seq(0, 1, by = .2), labels = scales::percent)
```

<img src="/public/images/visual/intro/unnamed-chunk-22-1.png" style="display: block; margin: auto;" />


A common parameter to change is which set of colors to use in a plot. While you can use the default coloring, a more common option is to leverage the pre-defined palettes from [colorbrewer.org](http://colorbrewer2.org/). These color sets have been carefully designed to look good and to be viewable to people with certain forms of color blindness. We can leverage color brewer palletes by specifying the `scale_color_brewer()` function, passing the pallete as an argument.


```r
# default color brewer
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  scale_color_brewer()

# specifying color palette
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  scale_color_brewer(palette = "Set3")
```

<img src="/public/images/visual/intro/unnamed-chunk-24-1.png" style="display: block; margin: auto;" />

Note that you can get the palette name from the [colorbrewer website](http://colorbrewer2.org/) by looking at the scheme query parameter in the URL. Or see the diagram [here](https://bl.ocks.org/mbostock/5577023) and hover the mouse over each palette for the name.

You can also specify *continuous* color values by using a [gradient](http://ggplot2.tidyverse.org/reference/scale_gradient.html) scale, or [manually](http://ggplot2.tidyverse.org/reference/scale_manual.html) specify the colors you want to use as a named vector.

## Coordinate Systems {#coord}

The next term from the Grammar of Graphics that can be specified is the __*coordinate system*__. As with scales, coordinate systems are specified with functions that all start with `coord_` and are added as a layer. There are a number of different possible coordinate systems to use, including:

- `coord_cartesian` the default [cartesian coordinate system](https://en.wikipedia.org/wiki/Cartesian_coordinate_system), where you specify x and y values (e.g. allows you to zoom in or out).
- `coord_flip` a cartesian system with the x and y flipped
- `coord_fixed` a cartesian system with a “fixed” aspect ratio (e.g., 1.78 for a “widescreen” plot)
- `coord_polar` a plot using [polar coordinates](https://en.wikipedia.org/wiki/Polar_coordinate_system)
- `coord_quickmap` a coordinate system that approximates a good aspect ratio for maps. See documentation for more details.


```r
# zoom in with coord_cartesian
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  coord_cartesian(xlim = c(0, 5))

# flip x and y axis with coord_flip
ggplot(mpg, aes(x = class)) +
  geom_bar() +
  coord_flip()
```

<img src="/public/images/visual/intro/unnamed-chunk-26-1.png" style="display: block; margin: auto;" />


## Facets {#facets}

__*Facets*__ are ways of grouping a data plot into multiple different pieces (subplots). This allows you to view a separate plot for each value in a categorical variable. You can construct a plot with multiple facets by using the `facet_wrap()` function. This will produce a “row” of subplots, one for each categorical variable (the number of rows can be specified with an additional argument):


```r
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(~ class)
```

<img src="/public/images/visual/intro/unnamed-chunk-27-1.png" style="display: block; margin: auto;" />

You can also `facet_grid` to facet your data by more than one categorical variable. Note that we use a tilde (`~`) in our `facet` functions.  With `facet_grid` the variable to the left of the tilde will be represented in the rows and the variable to the right will be represented across the columns. 


```r
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_grid(year ~ cyl)
```

<img src="/public/images/visual/intro/unnamed-chunk-28-1.png" style="display: block; margin: auto;" />

## Labels & Annotations {#labels}

Textual labels and annotations (on the plot, axes, geometry, and legend) are an important part of making a plot understandable and communicating information. Although not an explicit part of the Grammar of Graphics (the would be considered a form of geometry), `ggplot` makes it easy to add such annotations.

You can add titles and axis labels to a chart using the `labs()` function (not `labels`, which is a different R function!):


```r
ggplot(mpg, aes(x = displ, y = hwy, color = class)) +
  geom_point() +
  labs(title = "Fuel Efficiency by Engine Power",
       subtitle = "Fuel economy data from 1999 and 2008 for 38 popular models of cars",
       x = "Engine power (litres displacement)",
       y = "Fuel Efficiency (miles per gallon)",
       color = "Car Type")
```

<img src="/public/images/visual/intro/unnamed-chunk-29-1.png" style="display: block; margin: auto;" />

It is also possible to add labels into the plot itself (e.g., to label each point or line) by adding a new `geom_text` or `geom_label` to the plot; effectively, you’re plotting an extra set of data which happen to be the variable names:


```r
library(dplyr)

# a data table of each car that has best efficiency of its type
best_in_class <- mpg %>%
  group_by(class) %>%
  filter(row_number(desc(hwy)) == 1)

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) +
  geom_label(data = best_in_class, aes(label = model), alpha = 0.5)
```

<img src="/public/images/visual/intro/unnamed-chunk-30-1.png" style="display: block; margin: auto;" />

However, note that two labels overlap one-another in the top left part of the plot.  We can use the `geom_text_repel` function from the  [`ggrepel`](https://github.com/slowkow/ggrepel) package to help position labels.


```r
library(ggrepel)

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class)) +
  geom_text_repel(data = best_in_class, aes(label = model))
```

<img src="/public/images/visual/intro/unnamed-chunk-31-1.png" style="display: block; margin: auto;" />

## Additional Resources on `ggplot2` {#add}

This gets you started with `ggplot2`; however, this a lot more to learn.  Future [tutorials](ggplot) illustrate how to convert many common forms of visualization (i.e. histograms, bar charts, line charts) and turn them into advanced, publication worthy graphics.  Furthermore, the following resources provide additional avenues to learn more:

- [gglot2 Documentation](http://ggplot2.tidyverse.org/) (particularly the [function reference](http://ggplot2.tidyverse.org/reference/index.html))
- [ggplot2 Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2016/11/ggplot2-cheatsheet-2.1.pdf) (see also [here](http://zevross.com/blog/2014/08/04/beautiful-plotting-in-r-a-ggplot2-cheatsheet-3/))
- [Data Visualization portion of R for Data Science Book](http://r4ds.had.co.nz/data-visualisation.html)
- [A Layered Grammar of Graphics (Wickham)](http://vita.had.co.nz/papers/layered-grammar.pdf)

## Other Visualization Libraries {#other}

`ggplot2` is easily the most popular library for producing data visualizations in R. That said, ggplot2 is used to produce __static__ visualizations: unchanging “pictures” of plots. Static plots are great for for __explanatory visualizations__: visualizations that are used to communicate some information—or more commonly, an argument about that information. All of the above visualizations have been ways for us to explain and demonstrate an argument about the data (e.g., the relationship between car engines and fuel efficiency).

Data visualizations can also be highly effective for __exploratory analysis__, in which the visualization is used as a way to ask and answer questions about the data (rather than to convey an answer or argument). While it is perfectly feasible to do such exploration on a static visualization, many explorations can be better served with __interactive visualizations__ in which the user can select and change the view and presentation of that data in order to understand it.

While `ggplot2` does not directly support interactive visualizations, there are a number of additional R libraries that provide this functionality, including:

- [`ggvis`](http://ggvis.rstudio.com/) is a library that uses the Grammar of Graphics (similar to ggplot), but for interactive visualizations. 
- [`plotly`](https://plot.ly/r/) is a open-source library for developing interactive visualizations. It provides a number of “standard” interactions (pop-up labels, drag to pan, select to zoom, etc) automatically. Moreover, it is possible to take a `ggplot2` plot and [wrap](https://plot.ly/ggplot2/) it in Plotly in order to make it interactive. Plotly has many examples to learn from, though a less effective set of documentation.
- [`htmlwidgets`](http://www.htmlwidgets.org/) provides a way to utilize a number of JavaScript interactive visualization libraries. JavaScript is the programming language used to create interactive websites (HTML files), and so is highly specialized for creating interactive experiences.




[^adapted]: Examples in this module adapted from [*R for Data Science*](http://r4ds.had.co.nz/)
