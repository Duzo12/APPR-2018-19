library(shiny)

shinyUI(fluidPage(
  titlePanel("Analiza neto plač po svetu"),
  
    tags$h1("Osnovni podatki o premetu"),
  
    tags$h4("1. Kaj bom pri projektu analiziral?"),
  
    tags$h6("Pri predmetu Analiza podatkov s programom R sem si izbral temo,
            v kateri bom analiziral višino povprečne neto plače po svetu. 
            V svoji nalogi bom višino neto plače primerjal z več spremenljivkami, ter
            tako skušal poiskati povezave med njimi. Tako bom plače primerjal 
            z BDP-jem posamezne države. Poiskal bom tudi povprečno starost prebivalstva 
            v posmezni državi in jo primerjal z višino neto plače. Prav tako pa bom 
            iskal tudi povezave z izobrazbo, kriminalom in živjenjskimi stroški."),
  
    tags$h4("2. Podatkovni viri"),
  
    tags$h6("Spletni Viri:", 
            fluidRow(tags$a(href = "https://www.numbeo.com/cost-of-living/prices_by_country.jsp?displayCurrency=USD&itemId=105", "Podatki o neto mesečni plači")),
            fluidRow(tags$a(href = "https://www.numbeo.com/cost-of-living/", "Življenjski stroški")),
            fluidRow(tags$a(href = "https://www.numbeo.com/crime/rankings_by_country.jsp", "Podatki o stopnji kriminala")),
            fluidRow(tags$a(href = "https://en.wikipedia.org/wiki/List_of_countries_by_median_age", "Povprečna starost prebivalstva")),
            fluidRow(tags$a(href = "https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(PPP)_per_capita", "Višina BDP-ja")),
            fluidRow(tags$a(href = "http://hdr.undp.org/en/data", "Podatki o indeksu izobrazbe"))
            ),
  
    tags$h4("3. Zasnova podatkovnega dela"),
  
    tags$h6(("Iz zgoraj naštetih spletnih strani, bom pobral tabele in jih nato združil v 
              eno tabelo. Začel bom s tabelo mesečnih plač kateri bom nato pridružil še tabele BDP-ja, 
              starosti, indeksi izobrazbe, kriminala in indeks življensjskih stroškov. 
              Tako bom dobil enotno tabelo, ki jo bom kasneje uporabljal za anačizo in iskanje 
              povezav med podatki.")),
    
    tags$h4("4. Hipoteze"),
      fluidRow(tags$h6("Hipoteza 1: Višja kot bo plača, višji bo BDP.")),
      fluidRow(tags$h6("Hipoteza 2 : Večja kot bo plača, manjša bo stopnja kriminala.")),
      fluidRow(tags$h6("Hipoteza 3: Najvišjo plače bodo dosegle države, katerih povprečna starost prebivalstvo znaša od 30-40 let.")),
      fluidRow(tags$h6("Hipoteza 4: Višja kot je izobrazba, višji so življensjki stroški.")),
  
    tags$h6("Kasneje bom v nalogi analiziral hipoteze in jih s pomočjo grafov potrdil ali ovrgel."),
      
    
    tags$h4("5. Obdelava, uvoz in čiščenje podatkov"),
    tags$h6("Spodaj je prikazana tabela, ki je sestavljena iz vseh tabel,
            ki sem jih pri projektu uporabil. Vidimo lahko da so v prvem 
            stolpcu naštete vse države, nato pa so v nasljednjih stolpcih 
            posamezne spremenljivke za posamezno državo."),
  
    tags$table(tags$h3("Skupna tabela"),
             DT::dataTableOutput("tabelaSkupna")),
    
    tags$h4("6. Analiza in vizualizacija podatkov"),
    
    tags$h6("V tem razdelku bom prikazal posamezne grafe, ki sem jih
            uporabljal pri analizi podatkov. Na koncu razdelka pa 
            bom s pomočjo grafov prikazoval vrednotil hipoteze."),
  
    tags$h6("Spodnja dva grafa prikazujeta višino plače in BDP
            posameznih držav. Obarval sem nekatere države, ki izstopajo
            od povprečja oziroma imajo ekstremne vrednosti."),
   
    plotOutput("grafBDP"),
  
    plotOutput("grafplace"),
  
    tags$h6("Z obeh grafov lahko vidimi, da se obarvane države nahajajo
            skoraj na enakih mestih, zato lahko sklepamo, da je višina plače 
            sorazmerno povezana z višino BDP. Podobne povezave sem prav tako iskal 
            v hipotezah, ki jih bom sedal poskušal ovrednotiti.")
  
    
  
  

  
    #,  tabPanel("Število naselij",
               #sidebarPanel(
                  #uiOutput("pokrajine")
                #),
               #mainPanel(plotOutput("naselja")))
    )
)
