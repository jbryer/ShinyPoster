#' Render an RMarkdown file to be included in a Shiny app.
#' 
#' This will render an R markdown file to be included in a Shiny app. 
#'
#' @param path Rmarkdown file to render.
#' @param input the input object from Shiny (optional). If provided it will be
#'        passed to the Rmarkdown file through the environment.
#' @paramm quiet suppress the progress bar and messages?
#' @param envir the environment in which the Rmarkdown code will be evaluated.
#' @param quiet An option to suppress printing during rendering from knitr, 
#'        pandoc command line and others. 
#' @param ... other parameters passed to [knitr::knit2html()]
#' @export
#' @importFrom shiny HTML renderText
#' @importFrom knitr knit2html
renderRmd <- function(path,
					  input,
					  quiet = TRUE,
					  envir = new.env(),
					  mathjax = FALSE,
					  ...) {
	html <- ''
	if(!file.exists(path)) {
		return(shiny::HTML(paste0(path, ' not found.')))
	}
	try({
		contents <- paste(readLines(path, warn = FALSE), collapse = '\n')
		if(!missing(input)) {
			assign('input', input, envir = envir)
		}
		html <- knitr::knit2html(text = contents,
								 fragment.only = TRUE,
								 envir = envir,
								 quiet = quiet,
								 ...)
		Encoding(html) <- 'UTF-8'
		
		# Remove <!–html_preserve–> and <!–/html_preserve–> from output
		# These are put there with actionLink from Shiny
		html <- sub('&lt;!&ndash;html_preserve&ndash;&gt;', '', html)
		html <- sub('&lt;!&ndash;/html_preserve&ndash;&gt;', '', html)
		
		if(mathjax) {
			html <- paste0('<script src="tex-mml-chtml.js" id="MathJax-script" async></script>\n', html)
		}
	}, silent = FALSE)
	return(shiny::renderText( {
		return(shiny::HTML(html))
	}))
}
