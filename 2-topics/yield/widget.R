widget <- function(dataset) {
    shinyApp(
    
        ui = fluidPage(responsive = FALSE,
                fluidRow(style = "padding-bottom: 20px;",
                          column(4, selectInput("Crop", 
                                                c("Corn" = "Corn", 
                                                  "Hay" = "Hay",
                                                  "Soy Beans" = "SB",
                                                  "Oats" = "Oats"),
                                            label = "Crop")),
                          column(4, selectInput("expenses", 
                                            choices=names(dataset)[6:37],
                                            selected = names(dataset)[6],
                                            label = "Expense Items"))
                          ),
                
                  fluidRow(
                    
                        #ggvisOutput("gg_plot")
                        plotOutput("gg_plot", height=600, width=600)
                          
                        )
                                  
        ),
        
        server = function(input, output, session) {
            dat <- reactive({
                idx = which(names(dataset) == input$expenses)
                out <- dataset %>% filter(crop == input$Crop) %>%
                    select(yield, idx)
                names(out) <- c("yield","item")
                out
            })
        
#             dat %>% ggvis(x=~item, y=~yield) %>% layer_points() %>%
#                 set_options(width = 400, height = 400) %>%
#                 bind_shiny("gg_plot")
            output$gg_plot <- renderPlot({
              ggplot(dat(), aes(item, yield)) + geom_point()
            })

        },
      options = list(height = 700)
    )
}