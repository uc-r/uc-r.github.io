---
author: Brad Boehmke
layout: post
comments: true
title: Exponential Smoothing Models
---


<img src="/public/images/analytics/time_series/es10-1.png"  style="float:right; margin: 2px 0px 0px 10px; width: 40%; height: 40%;" />
Exponential forecasting models are smoothing methods that have been around since the 1950s and are extremely effective.  Where [niave forecasting](http://uc-r.github.io/ts_benchmarking#naive) places 100% weight on the most recent observation and [moving averages](http://uc-r.github.io/ts_moving_averages) place equal weight on *k* values, exponential smoothing allows for weighted averages where greater weight can be placed on recent observations and lesser weight on older observations. Exponential smoothing methods are intuitive, computationally efficient, and generally applicable to a wide range of time series. Consequently, exponentially smoothers are great forecasting tools to have and [this tutorial](http://uc-r.github.io/ts_exp_smoothing) will walk you through the basics.
