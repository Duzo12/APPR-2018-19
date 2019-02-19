library(shiny)

shinyUI(fluidPage(
  titlePanel("Analiza neto plač po svetu"),
    tabPanel("Tabela starosti",
               DT::dataTableOutput("tabela")),
  
    tabPanel("Osnovni podatki o programu",
      sidebarLayout(
        mainPanel(
          h1("Uvod"),
          h5("jahrfahrio"))
      )

    )
  

  
    #,  tabPanel("Število naselij",
               #sidebarPanel(
                  #uiOutput("pokrajine")
                #),
               #mainPanel(plotOutput("naselja")))
    )
)
