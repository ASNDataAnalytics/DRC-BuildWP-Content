#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source("src.R")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    includeCSS("styles.css"),
    
    tags$script(
        src="https://cdnjs.cloudflare.com/ajax/libs/iframe-resizer/3.5.16/iframeResizer.contentWindow.min.js", 
        type="text/javascript"),

    # Application title
    headerPanel("Merrit-Hawkins Revenue Data"),

    # 
    sidebarLayout(
        sidebarPanel(
            wellPanel(
            h4("Medical Specialty:"),    
            shiny::selectizeInput(
                inputId = "specialty",
                label = "",
                choices = sort(mh$Specialty))
            ),
            wellPanel(
                h4("Table: Complete Revenue Dataset"),
                DT::dataTableOutput("Table1")
                )
            ),

        # 
        mainPanel(
            fluidRow(
                column(width = 10, offset = 1,
                       plotOutput("roi_plot", height = 400)
        )
    )
)
)
))
