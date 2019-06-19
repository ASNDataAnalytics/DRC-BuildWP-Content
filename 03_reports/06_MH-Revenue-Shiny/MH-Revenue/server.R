#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source("src.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$roi_plot <- renderPlot({
    
    mh %>% 
      filter(Specialty == input$specialty) %>% 
      ggplot(
        aes(x = Specialty, 
            y = ROI
        )
      ) +
      geom_bar(
        stat = "identity",
        fill = "#4267b1", 
        width = .5
      ) + 
      theme_minimal(
        base_size = 12,
        base_family = "Roboto"
      ) +
            geom_text(
                aes(
                    label = scales::percent(ROI),
                    x = Specialty, 
                    y = ROI
                ),
                vjust = -0.5,
                family = "Roboto",
                size = 5
            ) +
            expand_limits(
                y = c(0,10)
            ) +
            scale_y_continuous(
                labels = scales::percent
            ) +
            geom_hline(
                data = mh,
                aes(
                    yintercept = mean(ROI)
                ),
                color = "#cc3466",
                lwd = 1
            ) +
            labs(
                x = "",
                y = "% ROI",
                title = paste("ROI: ", input$specialty)
                ) +
        theme(
          plot.background = element_rect(
            fill = "#fffff3",
            color = "#fffff3"
          ), 
          panel.background = element_rect(
            fill = "#fffff3",
            color = "#fffff3"
          ),
          plot.title = element_text(
            family = "Roboto Medium",
            size = 14
          ),
          axis.text.x = element_blank()
        ) +
        annotate(
          geom = "text",
          label = "Mean ROI",
          x = .5, 
          y = 6,
          size = 4,
          color = "#cc3466",
          family = "Roboto Black"
        )
        
        
        })
    
    output$Table1 <- DT::renderDataTable({
      df %>% 
        mutate(Revenue = if_else(
          is.na(Revenue), 
          NA_character_, 
          scales::dollar(Revenue)
          )
          )
      
    })

})
