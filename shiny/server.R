library(shiny)
library(reshape2)
library(data.table)

shinyServer(function(input, output) {
  output$tabela <- DT::renderDataTable(DT::datatable(SkupnaTabela)) 

  
  #output$pokrajine <- renderUI(
    #selectInput("pokrajina", label="Izberi pokrajino",
                #choices=c("Vse", levels(obcine$pokrajina)))
 # )
  #output$naselja <- renderPlot({
   # main <- "Pogostost števila naselij"
   # if (!is.null(input$pokrajina) && input$pokrajina %in% levels(obcine$pokrajina)) {
     # t <- obcine %>% filter(pokrajina == input$pokrajina)
  #    main <- paste(main, "v regiji", input$pokrajina)
   # } else {
   #   t <- obcine
   # }
   # ggplot(t, aes(x=naselja)) + geom_histogram() +
  #    ggtitle(main) + xlab("Število naselij") + ylab("Število občin")
  #})
})
