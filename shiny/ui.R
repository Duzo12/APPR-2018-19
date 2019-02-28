library(shiny)

shinyUI(fluidPage(
  title = " ",
  
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "SkupnaTabela"',
        checkboxGroupInput("show_vars", "Kateri stolpec naj prikaže:",
                           names(SkupnaTabela), selected = names(SkupnaTabela))
      )#,
      #conditionalPanel(
        #'input.dataset === "TabelaPlace"',
        #checkboxGroupInput("show_vars", "Za katero državo naj prikaže stolpec plače:",
                           #names(TabelaPlace), selected = names(TabelaPlace)))
      
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel(" ", DT::dataTableOutput("SkupnaTabela"))#,
        #abPanel(plotOutput("grafplace"))))
  )
  
)
  
  
    )))

