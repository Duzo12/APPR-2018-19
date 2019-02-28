library(shiny)
library(reshape2)
library(data.table)


shinyServer(function(input, output) {
  output$tabelaSkupna <- DT::renderDataTable({DT::datatable(SkupnaTabela)})
  
  output$grafplace <- renderPlot(ggplot(data =SkupnaTabela) +
                                   geom_bar(aes(x= reorder(Drzava, Vrednost.BDP), y=Vrednost.BDP,fill=barve),stat = "Identity", show.legend = F)+
                                   coord_flip() +
                                   theme(axis.text.x = element_text(angle = 90, hjust = 1),text = element_text(size=7), plot.title = element_text(size = 20) ) +
                                   xlab("Država") + ylab("Vrednost BDP") + ggtitle("Vrednost BDP v državah po svetu"))
  
})
