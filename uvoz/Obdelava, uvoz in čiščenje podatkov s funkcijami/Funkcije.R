#Funkcija, ki uvozi exel tabelo
uvoz.izobrazba <- function(tabelaIzobrazba){
  tabelaIzobrazba <- read.xlsx("C:/Users/nejc/Desktop/FMF/Program R/ProjektAPPR/Novi projekt/ProjektAPPR/podatki/Izobrazba.xlsx")
  obdrzistolpec <- c("Country", "2017")
  tabelaIzobrazba <- tabelaIzobrazba[ , obdrzistolpec]
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
  tabelaPlace = data.frame(DrŽava=drzave, vrednost=as.numeric(cifre))[seq(3,length(cifre)-2,2),]
  names(tabelaPlace) <- c("Država", "Višina plače v $")
  return(tabelaPlace)
}

# Funkcija, ki uvozi BDP iz wikipedije
uvoz.BDP <- function(tabelaBDP){
  linkBDP <- "https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(PPP)_per_capita#Distorted_GDP-per-capita_for_tax_havens"
  stranBDP <- html_session(linkBDP) %>% read_html()
  tabelaBDP <- stranBDP %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[2]] %>% html_table(dec= ",")
  tabelaBDP <- tabelaBDP[ , -1]
  names(tabelaBDP) <- c("Država", "Vrednost BDP v $")
  return(tabelaBDP)
}

# Funkcija, ki uvozi povprečno starost iz wikipedije
uvoz.starost <- function(tabelaStarosti){
  linkStarosti <- "https://en.wikipedia.org/wiki/List_of_countries_by_median_age"
  stranStarosti <- html_session(linkStarosti) %>% read_html()
  tabelaStarosti <- stranStarosti %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
    .[[1]] %>% html_table(dec= ",")
  tabelaStarosti <- tabelaStarosti[ , -2]
  names(tabelaStarosti) <- c("Država", "Povprečje let", "Povprečje moških let", "Povprečje ženskih let")
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
  tabelaCrimeindex = data.frame(Država=drzave, Stopnja.kriminala=as.numeric(cifre))[seq(3,length(cifre)-2,2),]
  names(tabelaCrimeindex) <- c("Država", "Stopnja kriminala")
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
  names(tabelaCostliving) <- c("Država", "Življenjski stroški")
  return(tabelaCostliving)
}



izobrazba <- uvoz.izobrazba()
place <- uvoz.place()
BDP <- uvoz.BDP()
kriminal <- uvoz.kriminal()
starost <- uvoz.starost()
stroski <- uvoz.zivljenjski.stroski()

