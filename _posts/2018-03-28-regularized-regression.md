---
author: Brad Boehmke
layout: post
comments: true
title: Regularized Regression
---

<img src="/public/images/analytics/regularized_regression/regularization_logo.png"  style="float:right; margin: 0px 0px 0px 0px; width: 50%; height: 50%;" />
Linear regression is a simple and fundamental approach for supervised learning.  Moreover, when the assumptions required by ordinary least squares (OLS) regression are met, the coefficients produced by OLS are unbiased and, of all unbiased linear techniques, have the lowest variance.  However, in today's world, data sets being analyzed typically have a large amount of features.  As the number of features grow, our OLS assumptions typically break down and our models often overfit (aka have high variance) to the training sample, causing our out of sample error to increase.  ***Regularization*** methods provide a means to control our regression coefficients, which can reduce the variance and decrease out of sample error.  This latest [tutorial](http://uc-r.github.io/regularized_regression) explains why you should know this technique and how to implement it in R. 
