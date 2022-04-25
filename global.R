# Packages for the shiny poster
library(shiny)
library(tidyverse)
library(shinyWidgets)
library(shinyjs)
library(shinydashboard)
library(gt)
library(gtsummary)
library(shinyfullscreen)

# Add other packages here
library(GGally)

source('R/utilities.R')
source('R/renderRmd.R')

# Set the accuracy for ggplot2 labels
pct_format = scales::percent_format(accuracy = .1)

navbar_title <- div(a(img(src="shiny.png", height=35), # image must be in www/ folder
					  href= "https://github.com/jbryer/ShinyPoster", target='_new'),
					style = "position: relative; top: -5px;")

poster_title <- 'Using Shiny to Create an Academic Poster'

poster_authors <- div(
	style = 'font-size: 16px;',
	'Jason Bryer', 
	superscript(a(icon('envelope'), href='mailto:jason.bryer@cuny.edu', target='_new')), ' ',
	superscript(a(icon('twitter'), href='https://twitter.com/jbryer', target='_new')), ' ',
	superscript(a(icon('github'), href='https://github.com/jbryer', target='_new')), ' ',
	superscript(a(icon('globe'), href='https://bryer.org', target='_new'))
)

background_color <- "ghostwhite"
box_background_color <- 'ghostwhite'

# These tabs will have a white background
tabs_with_white_background <- c('Paper')

# This will force running the app in the default web browser.
if(interactive()) {
   options(shiny.launch.browser = .rs.invokeShinyWindowExternal)
}

##### Load data  ###############################################################

data(mtcars)
mtcars$cyl <- as.factor(mtcars$cyl)

##### Setup data for demographics tab ##########################################
poster_data <- mtcars
primary_variables <- names(poster_data)
secondary_variables <- names(poster_data)

