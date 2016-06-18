---
id: 1836
title: Dealing with Regular Expressions
date: 2016-06-10
author: Brad Boehmke
layout: page
permalink: /regex
---

A regular expression (aka regex) is a sequence of characters that define a search pattern, mainly for use in pattern matching with text strings.  Typically, regex patterns consist of a combination of alphanumeric characters as well as special characters.  The pattern can also be as simple as a single character or it can be more complex and include several characters.  

To understand how to work with regular expressions in R, we need to consider two primary features of regular expressions.  One has to do with the *syntax*, or the way regex patterns are expressed in R.  The other has to do with the *functions* used for regex matching in R.  In this chapter, we will cover both of these aspects.  First, I cover the [syntax](#regex_syntax) that allow you to perform pattern matching functions with meta characters, character and POSIX classes, and quantifiers.  This will provide you with the basic understanding of the syntax required to establish the pattern to find.  Then I cover the  [functions](#regex_functions) you can apply to identify, extract, replace, and split parts of character strings based on the regex pattern specified. 

- Regex Syntax
- Regex Functions

