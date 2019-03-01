library(shiny)

shinyUI(fluidPage( 
  title = " ", 
  
  sidebarLayout( 
    sidebarPanel( 
      uiOutput("izbor_stolpcev"), 
      uiOutput("izbor_drzav") 
      ), 
    mainPanel( 
      tabsetPanel( 
        id = 'dataset', 
        tabPanel(value="tab_skupna",title = "Skupna", DT::dataTableOutput("tabelaSkupna")), 
        tabPanel(value="tab_place",title = "Plače", 
                 plotOutput("grafplace",height = 700), 
                 DT::dataTableOutput("tabelaPlace") 
                 ) 
        ) 
      
      
      ))))

