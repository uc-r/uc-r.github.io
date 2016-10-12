---
layout: tutorial
title: Review the Codebook
permalink: /codebook
---

A codebook is a technical description of the data that was collected for a particular purpose. It describes how the data are arranged in the computer file or files, what the various numbers and letters mean, and any special instructions on how to use the data properly. Like any other kind of "book," some codebooks are better than others. The best codebooks have:

1. Description of the study: who did it, why they did it, how they did it.
2. Sampling information: what was the population studied, how was the sample drawn, what was the response rate.
3. Structure of the data within the file: hierarchical, multiple cards, etc.
4. Details about the data such as:
    - Variable name: The name or number assigned to each variable in the data collection.
    - Variable label: A brief description to identify the variable for the user.
    - Question text: Where applicable, the exact wording from survey questions. ["In general, would you say your health is . . ."]
    - Values: The actual coded values in the data for this variable. [i.e. 1, 2, 3, 4, 5]
    - Value labels: The textual descriptions of the codes. [i.e. Excellent, Very Good, Good, Fair, Poor]
    - Summary statistics: Number of observations, record length, number of records per observation, etc.
    - Missing data: Where applicable, the values and labels used to code missing data.
    
R comes with many built-in data sets. To see the 100+ data sets that come with R just type `data()` in your console and you'll see a list that looks like:

<center>
<img src="https://uc-r.github.io/public/images/dataWrangling/built-in-data.png" alt="Built-in Data" style="width: 75%; height: 75%">
</center> 

For any of these built-in data sets you will find the "codebook," the technical description of the data by typing `?` and then the name of the data set. This will bring up the "codebook" in your Help console. For instance, `?mtcars` will provide you with the technical information regarding the `mtcars` built-in data set. 

Getting the codebook for data that you are importing is a little more difficult. If you are using organizational data at your employer, this will likely require you to request the codebook from your database engineers. This seemingly simple task will surprise you by illustrating how few people truly understand the technical details underlying organizational data. If you are using online data, which is the emphasis in this course, you may need to do some searching to identify the data. Sometimes codebooks are obviously and explicitly linked on the website, other times you have to do some digging to find the codebook. Some examples of codebooks follow:

- NOAA Hourly Precipitation: [[Data](https://catalog.data.gov/dataset/u-s-hourly-precipitation-data/resource/95bd76b0-3140-42d9-a8a1-fbd0e65c8e71?inner_span=True)] [[Codebook](https://catalog.data.gov/dataset/u-s-hourly-precipitation-data/resource/4e173be5-d962-467f-9240-02e233ccb454?inner_span=True)] 
- Consumer Expenditure Survey: [[Data](https://www.icpsr.umich.edu/icpsrweb/ICPSR/series/20#vars)] [[Codebook](https://www.icpsr.umich.edu/icpsrweb/ICPSR/ssvd/series/20/variables)]
- College Scorecard:  [[Data](https://catalog.data.gov/dataset/college-scorecard/resource/d43bae25-209a-4b17-affb-6ef8ff8f84ed)] [[Codebook](https://collegescorecard.ed.gov/data/documentation/)]
- Consumer Complaints: [[Data](https://catalog.data.gov/dataset/consumer-complaint-database/resource/2f297213-7198-4be1-af1e-2d2623e7f6e9)] [[Codebook](https://cfpb.github.io/api/ccdb//)]

The important thing to remember is that you need to identify the documentation that explicitly tells you about the data you are working with. If not then in your analysis you need to state what the implied meaning of the data is; however, you should also state that ambiguity may exist if a codebook can not be identified.  With your final project, I expect you to explain the meaning of the source data you analyze and provide a link to the codebook.
