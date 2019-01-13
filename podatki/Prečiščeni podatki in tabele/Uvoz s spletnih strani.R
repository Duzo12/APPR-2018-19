require(dplyr)
require(tidyr)
require(readr)
library(rvest)
library(gsubfn)
library(readr)
library(dplyr)
library(XML)
library(openxlsx)

#"U:/_Osebno/Projekt APPR/APPR-2018-19/Projekt APPR/podatki/Izobrazba.xlsx"
tabelaIzobrazba <- read.xlsx("C:/Users/nejc/Desktop/FMF/Program R/ProjektAPPR/Novi projekt/ProjektAPPR/podatki/Izobrazba.xlsx")
obdrzistolpec <- c("Country", "2017")
tabelaIzobrazba <- tabelaIzobrazba[ , obdrzistolpec]
names(tabelaIzobrazba) <- c("Drzava", "Indeks.izobrazbe")
tabelaIzobrazba$Indeks.izobrazbe <- as.numeric(as.character(tabelaIzobrazba$Indeks.izobrazbe))
tabelaIzobrazba$Indeks.izobrazbe <- tabelaIzobrazba$Indeks.izobrazbe * 100
tabelaIzobrazba$Drzava <- gsub("^[[:space:]]*", "", tabelaIzobrazba$Drzava)


linkStarosti <- "https://en.wikipedia.org/wiki/List_of_countries_by_median_age"
stranStarosti <- html_session(linkStarosti) %>% read_html()
tabelaStarosti <- stranStarosti %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
  .[[1]] %>% html_table(dec= ",")
obrdzi <- c("Country/Territory", "Total(Year)")
tabelaStarosti <- tabelaStarosti[ , obrdzi]
names(tabelaStarosti) <- c("Drzava", "Povprecje.let")


linkBDP <- "https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(PPP)_per_capita#Distorted_GDP-per-capita_for_tax_havens"
stranBDP <- html_session(linkBDP) %>% read_html()
tabelaBDP <- stranBDP %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
  .[[2]] %>% html_table(dec= ",")
tabelaBDP <- tabelaBDP[ , -1]
names(tabelaBDP) <- c("Drzava", "Vrednost.BDP")


linkPlace <- "https://www.numbeo.com/cost-of-living/country_price_rankings?displayCurrency=USD&itemId=105"
stran <- html_session(linkPlace) %>% read_html() %>% as.character()
stran1 <- gsub("^.*\\(\\[(.*) \\]\\).*$", "\\1", stran)
stran1 <- strsplit(stran1, split="   ")[[1]]
drzave <- gsub("^.*'(.*)'.*$", "\\1",stran1)
cifre=gsub("^.*, (.*)\\].*$", "\\1",stran1)
tabelaPlace = data.frame(DrŽava=drzave, vrednost=as.numeric(cifre))[seq(3,length(cifre)-2,2),]
names(tabelaPlace) <- c("Drzava", "Visina.place")
tabelaPlace$Drzava = as.character(tabelaPlace$Drzava)


linkCrimeindex <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2017"
stran <- html_session(linkCrimeindex) %>% read_html() %>% as.character()
stran1 <- gsub("^.*\\(\\[(.*) \\]\\).*$", "\\1", stran)
stran1 <- strsplit(stran1, split= "   ")[[1]]
drzave <- gsub("^.*'(.*)'.*$", "\\1", stran1)
cifre=gsub("^.*, (.*)\\].*$", "\\1",stran1)
tabelaCrimeindex = data.frame(Država=drzave, Stopnja.kriminala=as.numeric(cifre))[seq(3,length(cifre)-2,2),]
names(tabelaCrimeindex) <- c("Drzava", "Stopnja.kriminala")
tabelaCrimeindex$Drzava <- as.character(tabelaCrimeindex$Drzava)


linkCostliving <- "https://www.numbeo.com/cost-of-living/rankings_by_country.jsp?title=2017"
stran <- html_session(linkCostliving) %>% read_html() %>% as.character()
stran1 <- gsub("^.*\\(\\[(.*) \\]\\).*$", "\\1", stran)
stran1 <- strsplit(stran1, split="   ")[[1]]
drzave <- gsub("^.*'(.*)'.*$", "\\1",stran1)
cifre=gsub("^.*, (.*)\\].*$", "\\1",stran1)
tabelaCostliving = data.frame(Drzave=drzave,vrednost=as.numeric(cifre))[seq(3,length(cifre)-2,2),]
names(tabelaCostliving) <- c("Drzava", "Zivljenjski.stroski")
tabelaCostliving$Drzava <- as.character(as.factor(tabelaCostliving$Drzava))

#Tabela, ki združuje vse tabele
Skupnatabela <- tabelaPlace %>% inner_join(tabelaBDP, "Drzava"="Drzava") %>%
                inner_join(tabelaStarosti, "Drzava"="Drzava") %>%
                inner_join(tabelaIzobrazba, "Drzava" = "Drzava") %>%
                inner_join(tabelaCrimeindex, "Drzava"="Drzava") %>%
                inner_join(tabelaCostliving, "Drzava"="Drzava")
  
