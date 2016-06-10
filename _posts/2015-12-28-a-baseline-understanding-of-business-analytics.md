---
layout: post
title:  A Baseline Understanding of Business Analytics
date: 2015-10-19
author: Bradley Boehmke
published: true
tags: [business-analytics]
categories: [analytics]
---

<style>

<!-- .footnote {line-height:75%; "font-size:8px"} -->

</style>


<blockquote>
<em>"The limits of my language are the limits of my mind.  All I know is what I have words for."</em>
<br>
- Ludwig Wittgenstein
</blockquote>

**O<span style="font-variant: small-caps">ld wine in a new bottle?</span>** Operations research, business analytics, decision analytics, business intelligence, advanced analytics...are these concepts synonymous, symbiotic, mutually exclusive, or should we even care?<!--more--> Analytics has long been a pathway to business value; however, organizations often get lost in the hype of terminology. To heighten the confusion, the skills, tools, and resources used to perform analytics has expanded, further blurring the lines between who and how analytics is performed. This has led to organizations understanding that analytics is important yet not understanding how to implement it, and understanding that the skills and resources to perform analytics are vast yet not understanding how to create an analytics culture.

<br>

## Defining Business Analytics
**O<span style="font-variant: small-caps">ne could say</span>**, if absolutes were appropriate, that making better decisions is an objective of *"every"* organization.  But what exactly does this mean?  Theoretically, better decisions will translate into improved organizational performance; however, it is often difficult to discern the underlying reasons for organizational performance.  To gain insight into past execution and to inform future decision-making, organizations explore and investigate past performance by harnessing data and analytic techniques.

> *"Organizations – large and small, private and public, for-profit and not-for-profit – are using analytics to unlock the value in their data, model complex systems, and make better decisions with less risk."* - The Institute for Operations Research and the Management Sciences (INFORMS)

This scientific process of transforming data into insight with analytics for better decision-making has taken the form of various definitions.  Regardless of the specific definition, they all revolve around the concept of aggressively leveraging data and analytic techniques to create evidence-based decision making.  This concept of data-driven decision making has clearly been shown to improve organizational performance<sup><a href="#fn1" id="ref1">1</a></sup>.

Although analytics have been used in organizations for a variety of reasons for quite some time; ranging from the simple (generating and reporting metrics & scorecard performance) to the more advanced (mathematical & statistical modeling), many decision-makers still underutilize the available information and power of analytics because it is either not simple enough or arrives in an inconvenient form<sup><a href="#fn2" id="ref2">2</a></sup><sup><a href="#fn3" id="ref3">, 3</a></sup>.  This highlights the fact that, historically, the link between an organization's analytic activities and decision-making has been obscure.  With no defined process in place, quantitative approaches have been insufficiently integrated with the decision-making process. 

As a result, Davenport<sup><a href="#fn4" id="ref4">4</a></sup> states that Business Analytics (BA) can be defined as the broad use of data and quantitative analysis for decision-making.  It's the clearly defined process that integrates analytic techniques to make better decisions.  It's the concept of using data and applying sound analytic methods to empower decision-makers in improving organizational performance.  Multiple definitions of BA have been suggested and they all clearly state that BA is a process that methodically integrates the use of analytics and data in the decision-making process; it's the link between analytics and decisions.  The following are just a few definitions of BA that you may find in a search:

- **BA** refers to the skills, technologies, practices for continuous iterative exploration and investigation of past business performance to gain insight and drive business planning.
- **BA** is the practice of iterative, methodical exploration of an organization’s data with emphasis on statistical analysis and is used for data-driven decision making.
- **BA** is the use of analytics, data, and systemic reasoning to make business decisions

<br>

## Establishing a Business Analytics Process
**T<span style="font-variant: small-caps">he goal of a business analytics</span>** process is to turn data into information, information into insight, and then use this insight to make better decisions.  But what exactly does this process entail?

> *"When business analytic capabilities are integrated into business processes, decisions are more repeatable, scalable, traceable and accurate."* - Gartner, Inc

Many view the process of analytics as a black box and are primarily concerned only with the end product.  They view it as a back-office activity being performed by "quants" using overly sophisticated math.  This common view leads to a polarized process in which interaction between analysts, domain experts, and decision-makers are sparse.  This leaves the analysts with little understanding of how best to model the business problem at hand and leaves the domain experts and decision-makers questioning if the model really addresses their problem.  To establish a true business analytics process an organization needs to understand the analytics process and analysts need to understand the business and decision-making process.

To understand better, we can segregate the BA process into two components: the scientific method of applying analytics and the integration of this analytic approach into the decision-making process.  How well these two components are orchestrated will determine the level of success an organization has in establishing a BA process.

> *"It is seen as an end-to-end process beginning with identifying the business problem to evaluating and drawing conclusions about the prescribed solution arrived at through the use of analytics."* - INFORMS

<br>

### The Analytic Method

The analytic process is really just about applying the scientific method from a quantitative analysis perspective to help solve a problem.  Every problem being addressed from an analytic perspective, regardless of size, complexity or sophistication, should follow an organized rhythm that embodies the seven basic steps that follow.  

**Step 1:** Framing the business problem could be the most critical part of the process.  This step requires full involvement of all key stakeholders to outline the business problem or decision being addressed, identify the constraints involved, define the insights that would benefit the decision-maker(s) the most, and identify how analytics and data could play a role (or if the problem is even amenable to an analytics solution).  Most importantly, this step needs to gain a stakeholder agreement on the business problem statement outlining the above key points.

> *"Sound strategy starts with having the right goal."* - Michael Porter

**Step 2:** Now that the problem statement has been defined, this needs to be reformulated into an analytics problem statement.  This process entails defining the key outputs required that will empower the decision-maker, proposing a set of drivers and relationships to the outputs, and outlining the assumptions. It's important that drivers and outputs defined in this step are based on the problem needs and not on current data availability. 

> *"Business analytics starts with the business problem and then looks for the data. We must avoid a structure that shifts our business analytics’ focus from seeking data based upon business needs to offering only solutions made possible by the data available."*  - Randy Bartlett (A Practitioner's Guide to Business Analytics)

This step also needs to define key metrics of success. To truly understand if the analytic method applied resulted in improved performance an organization needs to define first how to measure and assess the results. 

**Step 3:** The third step in the process is when the hands get dirty and the non-analytically charged tend to lose interest.

> *"Data! Data! Data! I can’t make bricks without clay!"* - Sir Arthur Conan Doyle

This step involves identifying and prioritizing data needs based on step 2, acquiring the data, assessing the integrity of the data by cleaning and preprocessing the data, and identifying initial trends and relationships.  This step is fundamental in understanding the data and, although domain experts tend to become less interested as the technical analysis increases, it is paramount that they are involved to help put context around this data.  This step should include documentation of the data extraction and early findings for reproducibility and also to share with domain experts who can provide more context around the findings.  Step 3 can often lead the team to re-define the business and analytics problem statement.

**Step 4:** Now that firm understanding of the data underlying the business and analytic problem is in place, an analytic methodology that both fits the data *<u>and</u>* provides the outputs required by the decision-maker are selected. Understanding, and even describing, all the analytic techniques available is an intimidating task. However, analytic techniques can be categorized into three broad buckets. No one type of analytic category is better than another and, in fact, they are often used as compliments to one another to provide a robust understanding of the problem. 

<img src="https://d1avok0lzls2w.cloudfront.net/img_uploads/analytics_2(1).png" alt="Analytic Categories" style="float:right;" width="50%">

<P CLASS="indented">
<bold>Descriptive analytics</bold> uses data aggregation and data mining techniques to provide insight into the past and answer: “What has happened?” This category primarily uses statistics and analytics<sup><a href="#fn5" id="ref5">5</a></sup> that describe the past and are often generated for reports and dashboards to create benchmarks and provide performance metrics.
</P>

<P CLASS="indented">
<bold>Predictive analytics</bold><sup><a href="#fn6" id="ref6">6</a></sup> use knowledge, usually extracted from historical data, to predict future, or otherwise unknown, events.  The goal is to understand the future and answer: “What could happen?”.
</P>

<P CLASS="indented">
<bold>Prescriptive analytics</bold><sup><a href="#fn7" id="ref7">7</a></sup> not only look into the future to predict likely outcomes but they also attempt to shape the future by optimizing the targeted business objective while balancing constraints.  Prescriptive analytics are used to advise on possible outcomes and answer: “What should we do?”.
</P>

Although domain experts and key stakeholders will likely not understand the technical aspects behind the analytic techniques, it's still important that they remain involved in this step by understanding the basic logic of the possible analytic techniques and the outputs provided so that they can provide input into which techniques provide the decision-maker with the optimal insight to assist in the decision process.

**Step 5:**  Once the analytic techniques are choosen, it's now time to develop the model(s).  This step focuses on developing the model structure; running, calibrating, and validating the model; and integrating the models if more than one is choosen and they feed into one another.  A key component often overlooked in this step is to document the modeling process for reproducibility purposes.

**Step 6:**  After the model has been developed to an adequate level of performance, the next step is to deploy the model to the user.  The deployment process can take three general approaches:


1. Automated: Business rules and IT architecture is in place to allow for automated reporting.  This is often the deployment process in place for descriptive analytics that provide automated reporting of sales, profits, complaints, etc.
2. Cyclical: Models that are often used in a cyclical nature, or not requiring automated and real-time reporting, are often refined for production use.  This usually includes creating a [GUI](https://en.wikipedia.org/wiki/Graphical_user_interface) that allows the user to interact with the model in a simple fashion.  These models are often used for what-if scenarios or in a continous manner by the decision-maker to analyze the identified issue (i.e. dashboards, interactive decision support models).
3. One-off: Many large investment decisions require an analytic model but are only used once.  This can include re-location decisions, new product life cycle sustainment and cost forecasting.  Often, these models are not deployed, rather, its only the results that need to be reported.

Regardless of the deployment approach used, this step also includes delivering a report that provides background on the modeling process along with findings/results that provide the insights required by the decision maker as identified in step one.

**Step 7:** The final step is providing life cycle management of the model.  If the model deployment approach was designed for an automated or cyclical approach then the model should be continuously reviewed for performance degradation, to quickly recognize and act on new opportunities such as new data or process options, and to determine when the model has outlived its original purpose.

Thinking of the analytic process in terms of these seven steps creates a comprehensive framework that enables more strategic thinking about analytics and how an organization can treat them as corporate assets. This framework focuses on the business problem to guide the analytic process and keeps the domain experts and key stakeholders engaged during the entire process.

<br>

## The Decision Making Process
The second component required for the BA process is ensuring the analytic process is integrated into the decision-making process.  To truly put analytics to work in an enterprise, analytics needs to be an integral part of everyday business decisions and processes<sup><a href="#fn3" id="ref3">3</a></sup>.  So although organizations will have a central department that specializes on analytics, more often organizations are starting to integrate analytic capabilities throughout their enterprise to make analytics part of their day-to-day processes in more domain areas.  For example, P&G has a statistics department but many of their statisticians are integrated into other departments to provide analytic support for decision processes (i.e. marketing department to build a tool to analyze increasing claim problems, R&D department to forecast new product profitibility potential, logistics department to create routing models, etc.). 

Although the Analytic process keeps domain experts and key stakeholders heavily involved, to become an analytical enterprise, analytics cannot be relegated to a few analysts in a central organization.  Rather, analytical applications and tools must become pervasive throughout the enterprise.  To achieve this, Gartner's business analytics framework<sup><a href="#fn8" id="ref8">8</a></sup> stresses the use of cross-functional teams throughout the enterprise.  This is a common suggestion<sup><a href="#fn9" id="ref9">9</a></sup> that focuses on building "bilingual" teams with business/domain expertise along with highly trained analytic capabilities.  These cross-functional teams have the expertise to develop the overall strategic plan and priorities for fitting analytics into the decision processes within their relevant business domain areas.  They also manage the programs and analytic process that delivers the insights required, along with proper interpretation, for business decisions. 

It is with this heavy focus of integrated analytics throughout the enterprise that creates an analytically focused organization basing decisions on data-driven evidence.

> *"If you can't measure something, you can't understand it. If you can't understand it, you can't control it. If you can't control it, you can't improve it."* - H. James Harrington

<br>

## Towards an Analytical Enterprise
So, is this concept of Business Analytics really new to enterprises...no.  After all, we've been applying the analytic process to inform operational decisions in the U.S. military since World War II, just under a different name.  What is new is the interest of analytics being integrated into more areas of organizations.  Rather than relying on a central department to be the sole analytic resource for the enterprise, individual domain areas and small business units within organizations see the value of integrating analytic capabilities into their own decision processes.

What is important is that, as an enterprise, we establish a common understanding of what this analytic process is and what it represents.  That, as an enterprise we employ objective data and analyses as the primary guides to decision-making and that this requires a scientific method that is integrated into business processes.  Although we must acknowledge that providing analytic facts does not necessarily lead to purely fact-based decisions void of intuition, gut feeling or hearsay; it's undeniable that creating an analytic culture that embeds the analytic process into its decision processes creates a much greater probability that future decisions will be more informed and, hopefully, better. 

<small><a href="#">Go to top</a></small>

<br><br>

<P CLASS="footnote">
<sup id="fn1">1. See McAfee & Brynjolfsson (2012), Chen, et al. (2012), Brynjolfsson, et al. (2011), and Trkman, et al. (2010) to name a few<a href="#ref1" title="Jump back to footnote 1 in the text.">↩</a></sup>
</P>
<P CLASS="footnote">
<sup id="fn2">2. Bartlet, R., 2013. "A practitioner's guide to business analytics: Using data analysis tools to improve your organization's decision making and strategy." McGraw-Hill.<a href="#ref2" title="Jump back to footnote 2 in the text.">↩</a></sup>
</P>
<P CLASS="footnote">
<sup id="fn3">3. Davenport, T., et al., 2010. "Analytics at Work." Harvard Business Review Press<a href="#ref3" title="Jump back to footnote 3 in the text.">↩</a></sup>
</P>
<P CLASS="footnote">
<sup id="fn4">4. Davenport, T., 2010. "The new world of business analytics." International Institute for Analytics<a href="#ref4" title="Jump back to footnote 4 in the text.">↩</a></sup>
</P>
<P CLASS="footnote">
<sup id="fn5">5. Includes sums, central tendencies, variances, percent changes, historical trends & patterns, correlations, etc.<a href="#ref5" title="Jump back to footnote 5 in the text.">↩</a></sup>
</P>
<P CLASS="footnote">
<sup id="fn6">6. Includes parametric methods such as linear regression, hierarchical regression, activity-based costing, mathematical modeling; simulation methods such as discrete event simulation and agent-based modeling; classification methods such as logistic regression and decision trees; and artificial intelligence methods such as artificial neural networks and bayesian networks.<a href="#ref6" title="Jump back to footnote 6 in the text.">↩</a></sup>
</P>
<P CLASS="footnote">
<sup id="fn7">7. Includes optimization techniques such as linear programming, goal programming, integer/mixed-integer programming, and search algorithms; artificial intelligence optimization techniques such as genetic algorithms and swarm algorithms; and multi-criteria decision models such as analytic hierarchy process, analytic network process, multi-attribute utility and value theories, and value analysis.<a href="#ref7" title="Jump back to footnote 7 in the text.">↩</a></sup>
</P>
<P CLASS="footnote">
<sup id="fn8">8. Chandler, N., et al, 2011. "Garnter's business analytics framework." Gartner, Inc.<a href="#ref8" title="Jump back to footnote 8 in the text.">↩</a></sup>
</P>
<P CLASS="footnote">
<sup id="fn9">9. See Ayres, I. 2007. "Super Crunchers." Bantam; Provost, F. & Fawcett, T., 2013. "Data Science for Business." O'Reilly Media; Albright, S. & Winston, W., 2014. "Business Analytics: Data Analysis & Decision Making." Cengage Learning; Davenport, T. & Harris, J., 2007. "Competing on Analytics: The New Science of Winning." Harvard Business Review Press.<a href="#ref9" title="Jump back to footnote 9 in the text.">↩</a></sup>
</P>
