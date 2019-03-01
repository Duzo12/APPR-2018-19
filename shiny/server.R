library(shiny)
library(reshape2)
library(data.table)

SkupnaTabela$Drzava <- factor(SkupnaTabela$Drzava,levels=SkupnaTabela %>% arrange(Visina.place) %>% .$Drzava, 
                              ordered = TRUE) 
shinyServer(function(input, output) { 
  
  output$izbor_stolpcev = renderUI({ 
    conditionalPanel( 
      'input.dataset === "tab_skupna"', 
      checkboxGroupInput("show_vars", "Kateri stolpec naj prikaže:",
                         names(SkupnaTabela), selected = names(SkupnaTabela)) 
      ) 
    }) 
  output$izbor_drzav = renderUI({ 
    conditionalPanel( 
      'input.dataset === "tab_place"', 
      checkboxGroupInput("izbrane_drzave", "Izberi drzave:", 
                         TabelaPlace$Drzava, selected = c("Slovenia","Serbia")) 
      ) 
    }) 
  
  
  output$tabelaSkupna <- DT::renderDataTable({DT::datatable(SkupnaTabela %>% select(input$show_vars))}) 
  output$tabelaPlace <- DT::renderDataTable({DT::datatable(TabelaPlace %>% filter(Drzava %in% input$izbrane_drzave))}) 
  
  
  output$grafplace <- renderPlot({ 
    
    indeksi_barv=which(rev(levels(SkupnaTabela$Drzava))%in%input$izbrane_drzave) 
    nove_barve=replace(rep(NA,nrow(SkupnaTabela)),indeksi_barv,"red") 
    
    
    ggplot(data =SkupnaTabela) + 
      geom_bar(aes(x= reorder(Drzava, Vrednost.BDP), y=Vrednost.BDP,fill=nove_barve),stat = "Identity", show.legend = F)+ 
      coord_flip() + 
      theme(axis.text.x = element_text(angle = 90, hjust = 1),text = element_text(size=9), plot.title = element_text(size = 20) ) + 
      xlab("Država") + ylab("Vrednost BDP") + ggtitle("Vrednost BDP v državah po svetu") 
    }) 
  })


