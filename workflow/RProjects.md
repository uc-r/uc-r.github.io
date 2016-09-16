---
layout: page
title: R Projects
permalink: /r_projects
---

> *"Organization is what you do before you do something, so that when you do it, it is not all mixed up."* - A.A. Milne


If you are not careful your data analyses can become an explosion of data files, R scripts, ggplot graphs, and final reports. Each project evolves and mutates in its own way and keeping all the files associated with a project organized together is a wise practice. In fact, it is such a wise practice that RStudio has built-in support to manage your projects. This built-in capability is called...wait for it...*RStudio projects*.  RStudio projects make it straightforward to divide your work into multiple contexts, each with their own working directory, workspace, history, and source documents.


## Creating Projects

RStudio projects are associated with R working directories. You can create an RStudio project:

* In a new directory
* In an existing directory where you already have R code and data
* By cloning a version control (Git or Subversion) repository

by selecting **File**  &raquo; **New Project** and then completing the following set-up tasks:

<center>
<img src="/public/images/workflow/new_project.png" width="100%" height="100%"/>
</center>

## So What's Different?

When a new project is created RStudio:

1. Creates a project file (with an .Rproj extension) within the project directory. This file contains various project options (discussed below) and can also be used as a shortcut for opening the project directly from the filesystem.
2. Creates a hidden directory (named .Rproj.user) where project-specific temporary files (e.g. auto-saved source documents, window-state, etc.) are stored. This directory is also automatically added to .Rbuildignore, .gitignore, etc. if required.
3. Loads the project into RStudio and display its name in the Projects toolbar (which is located on the far right side of the main toolbar)

<center>
<img src="/public/images/workflow/create RProject.gif" width="100%" height="100%"/>
</center>

When a project is opened (**File**  &raquo; **Open Project** or by clicking on the .Rproj file directly for the project):

* A new R session is started
* The .Rprofile file in the project's main directory is sourced by R
* The .RData file in the project's main directory is loaded (if any)
* The history for the project is loaded into the History panel
* The working directory is set to the project's directory.
* Previously edited source documents are restored into editor tabs
* Other RStudio settings are restored to where they were the last time the project was closed

As you write and execute code in the project all updates and outputs created will be saved to the project directory. And when you close out of the project the .RData and .Rhistory files will be saved (if these options are selected in the global options) and the list of open source documents are saved so that they can be restored the next time you open the project.

There are additional project options you can choose from to customize the project at **Tools**  &raquo; **Project Options**. These project options are overrides for existing global options. To inherit the default global behavior for a project you can specify (Default) as the option value.

<center>
<img src="/public/images/workflow/project_options.png"/>
</center>
