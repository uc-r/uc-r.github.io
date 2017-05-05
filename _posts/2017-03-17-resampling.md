---
author: Brad Boehmke
layout: post
comments: true
title: New Tutorial on Resampling Methods
---


<img src="/public/images/analytics/resampling/bootstrap.png"  style="float:right; margin: 2px 0px 0px 10px; width: 40%; height: 40%;" />

See the new tutorial on [resampling methods](http://uc-r.github.io/resampling_methods), which are an indispensable tool in modern statistics. They involve repeatedly drawing samples from a training set and refitting a model of interest on each sample in order to obtain additional information about the fitted model. For example, in order to estimate the variability of a linear regression fit, we can repeatedly draw different samples from the training data, fit a linear regression to each new sample, and then examine the extent to which the resulting fits differ. Such an approach may allow us to obtain information that would not be available from fitting the model only once using the original training sample.
