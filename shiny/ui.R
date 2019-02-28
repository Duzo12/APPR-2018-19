library(shiny)

shinyUI(fluidPage(
  titlePanel(""),
  
    tags$table(tags$h3("Skupna tabela"),
             DT::dataTableOutput("tabelaSkupna")),
  
    plotOutput("grafBDP"),
  
    plotOutput("grafplace")

  
    )
)
