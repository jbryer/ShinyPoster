# Using Shiny to Create an Academic Poster

**Author: [Jason Bryer](mailto:jason.bryer@cuny.edu)**

## Introduction

In the past several years academic conferences have begun to display poster presentations electronically. This provides an opportunity for authors to include interactivity into their posters. Shiny has become a popular and powerful framework for researchers to create interactive web applications. This poster and paper presents a framework for creating traditional two or three column posters using Shiny. This provides the opportunity for the inclusion of interactive and live components in the poster.

## Getting Started

A template for the Shiny Poster is available on Github here: https://github.com/jbryer/ShinyPoster. The template provides a framework to quickly build a poster in Shiny. The template utilizes the `navbarPage` layout along with certain elements from the `shinydashboard` package. This allows for multiple views of the poster. Additionally, there is a "View Full Screen" button provided in the top right corner (Tip: you can scale the web browser to fit the screen resolution).

### Global Settings

To get started, modify key variables in the `global.R` file, namely:

* `navbar_title` - The content in the upper left hand side of the navbar.
* `poster_title` - The title of the poster.
* `poster_authors` - The poster's author(s).
* `background_color` - The background color of the poster.
* `tabs_with_white_background` - Any tabs that should have a white background instead of `background_color`.

Additionally, any data should be loaded within the `global.R` script and the `poster_data` variable should be set to the `data.frame` from which descriptive statistics are presented.

### Poster Boxes

To get you started, there are six boxes to hold content across two rows where row one had three columns and row two had two columns. To simplify the process of populating content in your poster, the `includeMarkdown` function is used with individual markdown files located in the `docs/` folder.

If you wish to use RMarkdown you can use the `renderRmd` function (included in the `R/` direcotry). This requires two steps: 1. Create an object on the `output` object that is the results of `renderRmd`; 2. Use the `htmlOutput` in the `ui.R` script to include the output of the Rmarkdown file.

### Descriptive Statistics

To leverage the interactive descriptive statistics set the `poster_data` variable in `global.R` to your data frame. There are functions in the `server.R` that will create `ggplot2` figures for variables users select from your data frame. These are located on the "Desciptive Statistics" tab. If you wish to exclude this feature you can delete `tabPanel` from the `ui.R` file.

## Conclusion

I hope this framework is useful for those who are presenting an electronic academic poster. You can see a poster we created for AERA 2022 here: https://r.bryer.org/shiny/AERA2022/

## References

R Core Team (2022). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL https://www.R-project.org/.
  
Winston Chang, Joe Cheng, JJ Allaire, Carson Sievert, Barret Schloerke, Yihui Xie, Jeff Allen, Jonathan McPherson, Alan Dipert and Barbara Borges (2021). shiny: Web Application Framework for R. R package version 1.7.1. https://CRAN.R-project.org/package=shiny

Winston Chang and Barbara Borges Ribeiro (2021). shinydashboard: Create Dashboards with 'Shiny'. R package version 0.7.2. https://CRAN.R-project.org/package=shinydashboard
