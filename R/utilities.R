#' Superscript HTML tag
superscript <- function (..., .noWS = NULL, .renderHook = NULL) {
	htmltools:::validateNoWS(.noWS)
	contents <- rlang::dots_list(...)
	tag("sup", contents, .noWS = .noWS, .renderHook = .renderHook)
}

#' Subscript HTML tag
subscript <- function (..., .noWS = NULL, .renderHook = NULL) {
	htmltools:::validateNoWS(.noWS)
	contents <- rlang::dots_list(...)
	tag("sub", contents, .noWS = .noWS, .renderHook = .renderHook)
}

#' Utility function that not only checks whether a variable is numeric but whether
#' it has more than a certain number of unique values.
is_qualitative <- function(x, category_threshold = 5) {
	!is.numeric(x) | length(unique(x)) <= category_threshold
}
