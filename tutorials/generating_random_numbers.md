---
layout: page
title: NULL
---


[R Vocab Topics](index) &#187; [Numbers](numbers) &#187; Generating sequence of random numbers


* <a href="#uniform">Uniform numbers</a> 
* <a href="#normal">Normal distribution</a>
* <a href="#binomial">Binomial distribution</a>
* <a href="#poisson">Poisson distribution</a>
* <a href="#exponential">Exponential distribution</a>
* <a href="#gamma">Gamma distribution</a>

<br>

<a name="uniform"></a>

# Uniform numbers 

{% highlight r %}
runif(n)                          # generate n random numbers between the default values of 0 and 1
runif(n, min = 0, max = 25)       # generate n random numbers between 0 and 25
sample(0:25, n, replace = TRUE)   # generate n random numbers between 0 and 25 (with replacement)
sample(0:25, n, replace = FALSE)  # generate n random numbers between 0 and 25 (without replacement)
{% endhighlight %}

<br>

<a name="normal"></a> 

# Normal Distribution Numbers 

{% highlight r %}
rnorm(n, mean = 0, sd = 1)    # generate n random numbers from a normal distribution with given mean & st. dev.
pnorm(q, mean = 0, sd = 1)    # generate CDF probabilities for value(s) in vector q 
qnorm(p, mean = 0, sd = 1)    # generate quantile for probabilities in vector p
dnorm(x, mean = 0, sd = 1)    # generate density function probabilites for value(s) in vector x
{% endhighlight %}

<br>

<a name="binomial"></a> 

# Binomial Distribution Numbers 
This is conventionally interpreted as the number of ‘successes’ in `size = x` trials and `prob = p` probability of success:

{% highlight r %}
rbinom(n, size = 100, prob = 0.5)  # generate a vector of length n displaying the number of successes from a trial size = 100 with a probabilty of success = 0.5
pbinom(q, size = 100, prob = 0.5)  # generate CDF probabilities for value(s) in vector q 
qbinom(p, size = 100, prob = 0.5)  # generate quantile for probabilities in vector p
dbinom(x, size = 100, prob = 0.5)  # generate density function probabilites for value(s) in vector x
{% endhighlight %}

<br>

<a name="poisson"></a>

# Poisson Distribution Numbers 
A discrete probability distribution that expresses the probability of a given number of events occuring in a fixed interval of time and/or space if these events occur with a known average rate and independently of the time since the last event.

{% highlight r %}
rpois(n, lambda = 4)  # generate a vector of length n displaying the random number of events occuring when lambda (mean rate) equals 4.
ppois(q, lambda = 4)  # generate CDF probabilities for value(s) in vector q when lambda (mean rate) equals 4.
qpois(p, lambda = 4)  # generate quantile for probabilities in vector p when lambda (mean rate) equals 4.
dpois(x, lambda = 4)  # generate density function probabilites for value(s) in vector x when lambda (mean rate) equals 4.
{% endhighlight %}

<br>

<a name="exponential"></a> 

# Exponential Distribution Numbers 
A probability distribution that describes the time between events in a Poisson process.

{% highlight r %}
rexp(n, rate = 1)   # generate a vector of length n with rate = 1
pexp(q, rate = 1)   # generate CDF probabilities for value(s) in vector q when rate = 4.
qexp(p, rate = 1)   # generate quantile for probabilities in vector p when rate = 4.
dexp(x, rate = 1)   # generate density function probabilites for value(s) in vector x when rate = 4.
{% endhighlight %}

<br>

<a name="gamma"></a> 

# Gamma Distribution Numbers 
A probability distribution that is related to the beta distribution and arises naturally in processes for which the waiting times between Poisson distributed events are relevant.

{% highlight r %}
rgamma(n, shape = 1)   # generate a vector of length n with shape parameter = 1
pgamma(q, shape = 1)   # generate CDF probabilities for value(s) in vector q when shape parameter = 1.
qgamma(p, shape = 1)   # generate quantile for probabilities in vector p when shape parameter = 1.
dgamma(x, shape = 1)   # generate density function probabilites for value(s) in vector x when shape parameter = 1.
{% endhighlight %}

<br>

<small><a href="#">Go to top</a></small>
