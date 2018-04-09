---
author: Brad Boehmke
layout: post
comments: true
title: Feedforward Deep Learning Models
---

<img src="/public/images/analytics/deep_learning/deep_nn.png"  style="float:right; margin: 2px 0px 0px 10px; width: 55%; height: 55%;" />

Machine learning algorithms typically search for the optimal representation of data using some feedback signal (aka objective/loss function).  However, most machine learning algorithms only have the ability to use one or two layers of data transformation to learn the output representation. As data sets continue to grow in the dimensions of the feature space, finding the optimal output representation with a *shallow* model is not always possible.  Deep learning provides a multi-layer approach to learn data representations, typically performed with a *multi-layer neural network*.  Like other machine learning algorithms, deep neural networks (DNN) perform learning by mapping features to targets through a process of simple data transformations and feedback signals; however, DNNs place an emphasis on learning successive layers of meaningful representations.  Although an intimidating subject, the overarching concept is rather simple and has proven highly successful in predicting a wide range of problems (i.e. image classification, speech recognition, autonomous driving).  This [tutorial](http://uc-r.github.io/feedforward_DNN) will teach you the fundamentals of building a *feedfoward* deep learning model.
