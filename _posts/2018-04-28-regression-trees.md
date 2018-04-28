---
author: Brad Boehmke
layout: post
comments: true
title: Regression Trees
---

<img src="/public/images/analytics/regression_trees/iris.png"  style="float:right; margin: 0px 0px 0px 0px; width: 30%; height: 30%;" />
Basic ___regression trees___ partition a data set into smaller groups and then fit a simple model (constant) for each subgroup. Unfortunately, a single tree model tends to be highly unstable and a poor predictor.  However, by  bootstrap aggregating (___bagging___) regression trees, this technique can become quite powerful and effective.  Moreover, this provides the fundamental basis of more complex tree-based models such as _random forests_ and _gradient boosting machines_. This [latest tutorial](http://uc-r.github.io/regression_trees) will get you started with regression trees and bagging.
