shinyServer(function(input, output, session) {
	##### Figures ##############################################################
	output$figure1 <- renderPlot({
		ggpairs(poster_data[,c('mpg', 'wt', 'cyl')])
	})
	
	##### Rmarkdown boxes ######################################################
	output$results <- renderRmd('docs/results.Rmd', mathjax = TRUE)
	
	##### Table output #########################################################
	output$lm_summary <- renderPrint({
		lm(mpg ~ wt + cyl, data = mtcars) %>% summary()
	})
	
	
    ##### Output for the demographics tab ######################################
    output$demographics_primary_input <- renderUI({
    	selectInput(
    		'primary_variable',
    		'Demographic Variable',
    		choices = primary_variables
    	)
    })
    
    output$demographics_secondary_input <- renderUI({
    	selectInput(
    		'secondary_variable',
    		'Secondary Variable',
    		choices = c('None', secondary_variables)
    	)
    })
    
    output$demographic_plot <- renderPlot({
    	req(input$primary_variable)
    	req(input$secondary_variable)
    	p <- NULL
    	var1 <- input$primary_variable
    	var2 <- input$secondary_variable
    	if(var2 == 'None') {
	    	if(!is_qualitative(poster_data[,var1])) {
	    		p <- ggplot(poster_data, aes_string(x = var1)) +
	    			geom_density()
	    	} else {
	    		p <- ggplot(poster_data, aes_string(x = var1)) +
	    			geom_bar(alpha = 0.3) +
	    			geom_text(
	    				aes(
	    					label = sprintf(
	    						'%d\n(%s)',
	    						..count..,
	    						pct_format(..count.. / sum(..count..))
	    					)
	    				),
	    				stat = 'count',
	    				hjust = 1,
	    				colour = 'black',
	    				size = 5) +
	    			coord_flip()
	    	}
    	} else {
    		if(is_qualitative(poster_data[,var1]) & 
    		   is_qualitative(poster_data[,var2])) { 
    			# Two qualitative variables: bar plot
    			p <- ggplot(poster_data, aes_string(x = var1, fill = var2)) +
    				geom_bar(position = 'dodge') +
    				geom_text(
    					aes(label = sprintf('%d', ..count..)),
    					stat = 'count',
    					hjust = 1,
    					colour = 'black',
    					position = position_dodge(width = .9),
    					size = 5) +
    				coord_flip()
    		} else if(!is_qualitative(poster_data[,var1]) &
    				  !is_qualitative(poster_data[,var2])) {
    			# Two quantitative variables: scatter plot
    			p <- ggplot(poster_data, aes_string(x = var1, y = var2)) +
    				geom_point()
    		} else {
    			# Make sure var1 is quantitative, var2 is qualitative
    			if(is_qualitative(poster_data[,var1])) {
    				var2 <- input$primary_variable
    				var1 <- input$secondary_variable
    			}
    			# One qualitative, one qualitative: Box plot
    			p <- ggplot(poster_data, aes_string(x = var2, y = var1)) + 
    				geom_boxplot()
    		}
    	}
    	return(p)
    })
    
    output$demographic_table <- render_gt({
    	# TODO:
    })
    
    ##### Change background color for certain tabs #############################
    observeEvent(input$shiny_poster, {
    	if(input$shiny_poster %in% tabs_with_white_background){
    		session$sendCustomMessage("background-color", "white")
    	} else {
    		session$sendCustomMessage("background-color", background_color)
    	}
    })
    
})
