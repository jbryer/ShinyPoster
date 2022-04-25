shinyUI(navbarPage(
	id = 'shiny_poster',
	header = '',
	position = 'static-top',
	windowTitle = poster_title,
	title = navbar_title, 
	tabPanel(
        'Overview',
        fluidRow( # Title and Authors
        	style = 'position: relative; top: -15px;',
        	column(
        		width = 12,
        		div(style = 'font-size: 26px; padding-bottom: 10px;',
        			align = 'center',
        			poster_title
        		),
        		div(align = 'center',
        			style = 'padding-bottom: 5px',
        			poster_authors
        		)
        	)
        ),
        fluidRow( # Row 1 (three column layout)
        	column( # Column 1
        		width = 4,
        		style='padding:0px;',
	        	box(title = 'Abstract',
	        		width = 12,
	        		includeMarkdown('docs/abstract.md')
	        	),
        		box(title = 'Research Questions',
        			width = 12,
        			includeMarkdown('docs/research_questions.md')
        		)
        	),
        	column( # Column 2
        		width = 4,
        		style='padding:0px;',
        		box(title = 'Method',
        			width = 12,
        			includeMarkdown('docs/method.md')
        		)
        	),
        	column( # Column 3
        		width = 4,
        		style='padding:0px;',
        		box(title = 'Results',
        			width = 12,
        			htmlOutput('results')
        		)
        	)
        ),
        fluidRow( # Row 2 (two column layout)
        	column( # Column 1
        		width = 6,
        		style='padding:0px;',
        		box(title = 'Pairs Plot',
        			width = 12,
        			plotOutput('figure1', height = '400px')
        		)
        	),
        	column( # Column 2
        		width = 6,
        		style='padding:0px;',
        		box(title = 'Regression Output',
        			width = 12,
        			# plotOutput('figure2', height = '400px'))
        			verbatimTextOutput('lm_summary')
        		)
        	)
        ),
        ##### Added Web Dependencies #############################################
        # Note that these need to be present within a tabPanel so to not create
        # an empty tab that is clickable and therefore blank.
        useShinydashboard(),
        shinyjs::inlineCSS(".navbar .navbar-default .navbar-static-top {margin-bottom: 0px}"),
        fullscreen_all(click_id = "page_full"),
        ##### Set Background Color
        tags$head(
        	tags$script("Shiny.addCustomMessageHandler('background-color', function(color) {
        document.body.style.backgroundColor = color; });
		")
        ),
        ##### Full Screen Button
        tags$script(
        	HTML("var header = $('.navbar > .container-fluid');
                              header.append('<div style=\"float:right; padding-top: 8px\"><button id=\"page_full\" type=\"button\" class=\"btn btn-outline-primary action-button\" onclick=\"page_full()\">View Full Screen</button></div>')")
        )
        ##### End Web Dependencies #############################################
	),
	##### Demographics Tab #####################################################
    tabPanel(
        'Descriptive Stats',
        fluidRow(
        	column(
        		width = 6,
        		style='padding:10px;',
        		includeMarkdown('docs/descriptive_stats_info.md')
        	),
        	column(
        		width = 3,
        		style='padding:10px;',
        		uiOutput('demographics_primary_input')
        	),
        	column(
        		width = 3,
        		style='padding:10px;',
        		uiOutput('demographics_secondary_input')
        	)
        ),
        fluidRow(
        	column(
        		width = 12,
        		style='padding:0px;',
        		box(width = 12,
        			plotOutput("demographic_plot", height = '600px')
        		)
        	)
        	# TODO: Add demographic table
        	# column(
        	# 	width = 6,
        	# 	style='padding:0px;'
        	# 	# box(width = 12)
        	# )
        )
    ),
    ##### Paper / About Tab ####################################################
    tabPanel(
        'Paper',
        includeMarkdown('docs/paper.md')
    ),
))
