---
layout: tutorial
title: Saving & Sourcing Functions
permalink: /sourcing
---


If you want to save a function to be used at other times and within other scripts there are two main ways to do this.  One way is to build a package which is discussed in more details [here](http://r-pkgs.had.co.nz/).  Another option, and the one discussed here, is to save the function in a script.  For example, we can save a script that contains the `PV()` function from the [previous section](http://uc-r.github.io/understanding_functions) and save this script as `PV.R`.

<center>
<img src="/public/images/r_vocab/shot1.png" alt="Save PV Function as a Script">
</center> 
<br>
Now, if we are working in a fresh script you'll see that we have no objects and functions in our working environment:

<center>
<img src="/public/images/r_vocab/shot2.png" alt="Fresh Script">
</center>

<br>

If we want to use the PV function in this new script we can simply read in the function by sourcing the script using `source("PV.R")`.  Now, you'll notice that we have the `PV()` function in our global environment and can use it as normal.  Note that if you are working in a different directory then where the `PV.R` file is located you'll need to include the proper command to access the relevant directory. 

<center>
<img src="/public/images/r_vocab/shot3.png" alt="PV Function Sourced In">
</center>
