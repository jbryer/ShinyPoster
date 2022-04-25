A template for the Shiny Poster is available on Github here: https://github.com/jbryer/ShinyPoster. The template provides a framework to quickly build a poster in Shiny.The template utilizes the `navbarPage` layout along with certain elements from the `shinydashboard` package.

To get started, modifying key variables in the `global.R` file, namely:

* `navbar_title` - The content in the upper left hand side of the navbar.
* `poster_title` - The title of the poster.
* `poster_authors` - The poster's author(s).
* `background_color` - The background color of the poster.
* `tabs_with_white_background` - Any tabs that should have a white background instead of `background_color`.

Additionally, any data should be loaded within the `global.R` script and the `poster_data` variable should be set to the `data.frame` from which descriptive statistics are presented.


