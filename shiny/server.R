library(shiny)
library(reshape2)
library(data.table)


shinyServer(function(input, output) {
  output$tabelaSkupna <- DT::renderDataTable(DT::datatable(SkupnaTabela))
  
  output$grafBDP <- renderPlot(width = "auto", height = "auto",
                               ggplot(data=SkupnaTabela) + 
                                 geom_bar(aes(x=Drzava, y=Visina.place,fill=barve),stat = "Identity", show.legend = F)+
                                 coord_flip() +
                                 theme(axis.text.x = element_text(angle = 90, hjust = 1),text = element_text(size=7), plot.title = element_text(size = 20)) +
                                 xlab("Država") + ylab("Višina plače") + ggtitle("Višina plače v državah po svetu") 
  )
  
  output$grafplace <- renderPlot(ggplot(data =SkupnaTabela) +
                                   geom_bar(aes(x= reorder(Drzava, Vrednost.BDP), y=Vrednost.BDP,fill=barve),stat = "Identity", show.legend = F)+
                                   coord_flip() +
                                   theme(axis.text.x = element_text(angle = 90, hjust = 1),text = element_text(size=7), plot.title = element_text(size = 20) ) +
                                   xlab("Država") + ylab("Vrednost BDP") + ggtitle("Vrednost BDP v državah po svetu"))
  
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
