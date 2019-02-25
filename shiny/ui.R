library(shiny)

shinyUI(fluidPage(
  titlePanel("Analiza neto plač po svetu"),
  
    tags$table(tags$h3("Skupna tabela"),
             DT::dataTableOutput("tabelaSkupna")),
  
    plotOutput("grafBDP"),
  
    plotOutput("grafplace")

    #,  tabPanel("Število naselij",
               #sidebarPanel(
                  #uiOutput("pokrajine")
                #),
               #mainPanel(plotOutput("naselja")))
    )
)
