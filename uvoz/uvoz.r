# 2. faza: Uvoz podatkov

source("lib/libraries.r", encoding="UTF-8")

#Funkcija, ki uvozi exel tabelo
uvoz.izobrazba <- function(tabelaIzobrazba){
  tabelaIzobrazba <- read_xlsx("podatki/Izobrazba.xlsx")
  obdrzistolpec <- c("Country", "2017")
  tabelaIzobrazba <- tabelaIzobrazba[ , obdrzistolpec]
  names(tabelaIzobrazba) <- c("Drzava", "Indeks.izobrazbe")
  tabelaIzobrazba$Indeks.izobrazbe <- as.numeric(as.character(tabelaIzobrazba$Indeks.izobrazbe))
  tabelaIzobrazba$Indeks.izobrazbe <- tabelaIzobrazba$Indeks.izobrazbe * 100
  tabelaIzobrazba$Drzava <- gsub("^[[:space:]]*", "", tabelaIzobrazba$Drzava)
  return(tabelaIzobrazba)
}

# Funkcija, ki uvozi plače s strani numbeo
uvoz.place <- function(tabelaPlace){
  linkPlace <- "https://www.numbeo.com/cost-of-living/country_price_rankings?displayCurrency=USD&itemId=105"
  stran <- html_session(linkPlace) %>% read_html() %>% as.character()
  stran1 <- gsub("^.*\\(\\[(.*) \\]\\).*$", "\\1", stran)
  stran1 <- strsplit(stran1, split="   ")[[1]]
  drzave <- gsub("^.*'(.*)'.*$", "\\1",stran1)
  cifre=gsub("^.*, (.*)\\].*$", "\\1",stran1)
  tabelaPlace = data.frame(Drzava=drzave, vrednost=as.numeric(cifre))[seq(3,length(cifre)-2,2),]
  names(tabelaPlace) <- c("Drzava", "Visina.place")
  tabelaPlace$Drzava = as.character(tabelaPlace$Drzava)
  return(tabelaPlace)
}

# Funkcija, ki uvozi BDP iz wikipedije
uvoz.BDP <- function(tabelaBDP){
  linkBDP <- "https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(PPP)_per_capita#Distorted_GDP-per-capita_for_tax_havens"
  stranBDP <- html_session(linkBDP) %>% read_html()
  tabelaBDP <- stranBDP %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[2]] %>% html_table(dec= ",")
  tabelaBDP <- tabelaBDP[ , -1]
  names(tabelaBDP) <- c("Drzava", "Vrednost.BDP")
  return(tabelaBDP)
}

# Funkcija, ki uvozi povprečno starost iz wikipedije
uvoz.starost <- function(tabelaStarosti){
  linkStarosti <- "https://en.wikipedia.org/wiki/List_of_countries_by_median_age"
  stranStarosti <- html_session(linkStarosti) %>% read_html()
  tabelaStarosti <- stranStarosti %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[1]] %>% html_table(dec=".")
  obrdzi <- c("Country/Territory", "Total(Year)")
  tabelaStarosti <- tabelaStarosti[ , obrdzi]
  names(tabelaStarosti) <- c("Drzava", "Povprecje.let")
  return(tabelaStarosti)
}

# Funkcija, ki uvozi stopnjo kriminala iz strani numbeo
uvoz.kriminal <- function(tabelaCrimeindex){
  linkCrimeindex <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2017"
  stran <- html_session(linkCrimeindex) %>% read_html() %>% as.character()
  stran1 <- gsub("^.*\\(\\[(.*) \\]\\).*$", "\\1", stran)
  stran1 <- strsplit(stran1, split= "   ")[[1]]
  drzave <- gsub("^.*'(.*)'.*$", "\\1", stran1)
  cifre=gsub("^.*, (.*)\\].*$", "\\1",stran1)
  tabelaCrimeindex = data.frame(Drzava=drzave, Stopnja.kriminala=as.numeric(cifre))[seq(3,length(cifre)-2,2),]
  names(tabelaCrimeindex) <- c("Drzava", "Stopnja.kriminala")
  tabelaCrimeindex$Drzava <- as.character(tabelaCrimeindex$Drzava)
  return(tabelaCrimeindex)
}

# Funkcija, ki uvozi indeks življenjskih stroškov iz strani numbeo
uvoz.zivljenjski.stroski <- function(tabelaCostliving){
  linkCostliving <- "https://www.numbeo.com/cost-of-living/rankings_by_country.jsp?title=2017"
  stran <- html_session(linkCostliving) %>% read_html() %>% as.character()
  stran1 <- gsub("^.*\\(\\[(.*) \\]\\).*$", "\\1", stran)
  stran1 <- strsplit(stran1, split="   ")[[1]]
  drzave <- gsub("^.*'(.*)'.*$", "\\1",stran1)
  cifre=gsub("^.*, (.*)\\].*$", "\\1",stran1)
  tabelaCostliving = data.frame(Drzave=drzave,vrednost=as.numeric(cifre))[seq(3,length(cifre)-2,2),]
  names(tabelaCostliving) <- c("Drzava", "Zivljenjski.stroski")
  tabelaCostliving$Drzava <- as.character(as.factor(tabelaCostliving$Drzava))
  return(tabelaCostliving)
}


uvoz.placeBDP <- function(zdruzenaPlaceBDP){
  zdruzenaPlaceBDP <- uvoz.place()  %>% inner_join(uvoz.BDP(), "Drzava"="Drzava")
  return(zdruzenaPlaceBDP)
}

uvoz.placeBDPkriminal <- function(zdruzenaPlaceBDPCrimeindex){
  zdruzenaPlaceBDPCrimeindex <- uvoz.placeBDP() %>% inner_join(uvoz.kriminal(), "Drzava"="Drzava")
  return(zdruzenaPlaceBDPCrimeindex)
}

uvoz.skupna <- function(Skupnatabela){
  Skupnatabela <- uvoz.place() %>% inner_join(uvoz.BDP(), "Drzava"="Drzava") %>%
    inner_join(uvoz.starost(), "Drzava"="Drzava") %>%
    inner_join(uvoz.izobrazba(), "Drzava" = "Drzava") %>%
    inner_join(uvoz.kriminal(), "Drzava"="Drzava") %>%
    inner_join(uvoz.zivljenjski.stroski(), "Drzava"="Drzava")
  return(Skupnatabela)
}

Tabela1 <- uvoz.placeBDPkriminal()
starost <- uvoz.starost()
izobrazba <- uvoz.izobrazba()
SkupnaTabela <- uvoz.skupna()



