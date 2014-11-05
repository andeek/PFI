widget <- function(dataset) {
  shinyApp(
    
    ui = fluidPage(responsive = FALSE,
                   fluidRow(style = "padding-bottom: 20px;",
                            column(4, selectInput("firstcrop", c("Corn" = "Corn", "Hay" = "Hay", "Oats" = "Oats", "Soy Beans" = "SB", "Hay" = "Hay"), label = "First Crop")),
                            column(4, selectInput("secondcrop", c("Corn" = "Corn", "Hay" = "Hay", "Oats" = "Oats", "Soy Beans" = "SB", "Hay" = "Hay"), label = "Second Crop")),
                            column(4, selectInput("expense", choices=levels(dataset$item.x), selected = levels(dataset$item.y)[1], label="Expense Items", multiple=TRUE))
                   ),
                   fluidRow(
                     ggvisOutput('gg_plot')
                   )
    ),
    
    server = function(input, output, session) {
      dat <- reactive({
        dataset %>%
          filter(crop.x == input$secondcrop) %>%
          filter(crop.y == input$firstcrop ) %>%
          filter(item.x %in% input$expense ) %>%
          select(year, value.x, item.x) %>%
          mutate(item.x = factor(item.x)) %>%
          unique()
      })
      
      dat %>%
        ggvis(x=~year, y=~value.x, stroke=~item.x) %>% 
        layer_lines()  %>%
        scale_numeric("x", domain = c(1988, 2012), nice = FALSE) %>%
        set_options(width = 400, height = 400) %>%
        bind_shiny("gg_plot")
      }, 
    options = list(height = 700)
  ) 
}