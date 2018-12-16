require(dplyr)
require(tidyr)
require(readr)
library(rvest)
library(gsubfn)
library(readr)
library(dplyr)
library(XML)

linkStarosti <- "https://en.wikipedia.org/wiki/List_of_countries_by_median_age"
stranStarosti <- html_session(linkStarosti) %>% read_html()
tabelaStarosti <- stranStarosti %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
  .[[1]] %>% html_table(dec= ",")
tabelaStarosti <- tabelaStarosti[ , -2]
names(tabelaStarosti) <- c("Država", "Povprečje let", "Povprečje moških let", "Povprečje ženskih let")

linkBDP <- "https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(PPP)_per_capita#Distorted_GDP-per-capita_for_tax_havens"
stranBDP <- html_session(linkBDP) %>% read_html()
tabelaBDP <- stranBDP %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
  .[[2]] %>% html_table(dec= ",")
tabelaBDP <- tabelaBDP[ , -1]
names(tabelaBDP) <- c("Država", "Vrednost BDP v $")


linkPlace <- "https://www.numbeo.com/cost-of-living/country_price_rankings?displayCurrency=USD&itemId=105"
stran <- html_session(linkPlace) %>% read_html() %>% as.character()
stran1 <- gsub("^.*\\(\\[(.*) \\]\\).*$", "\\1", stran)
stran1 <- strsplit(stran1, split="   ")[[1]]
drzave <- gsub("^.*'(.*)'.*$", "\\1",stran1)
cifre=gsub("^.*, (.*)\\].*$", "\\1",stran1)
tabelaPlace = data.frame(DrŽava=drzave, vrednost=as.numeric(cifre))[seq(3,length(cifre)-2,2),]
names(tabelaPlace) <- c("Država", "Višina plače v $")


linkCrimeindex <- "https://www.numbeo.com/crime/rankings_by_country.jsp?title=2017"
stran <- html_session(linkCrimeindex) %>% read_html() %>% as.character()
stran1 <- gsub("^.*\\(\\[(.*) \\]\\).*$", "\\1", stran)
stran1 <- strsplit(stran1, split= "   ")[[1]]
drzave <- gsub("^.*'(.*)'.*$", "\\1", stran1)
cifre=gsub("^.*, (.*)\\].*$", "\\1",stran1)
tabelaCrimeindex = data.frame(Država=drzave, Stopnja.kriminala=as.numeric(cifre))[seq(3,length(cifre)-2,2),]
names(tabelaCrimeindex) <- c("Država", "Stopnja kriminala")


linkCostliving <- "https://www.numbeo.com/cost-of-living/rankings_by_country.jsp?title=2017"
stran <- html_session(linkCostliving) %>% read_html() %>% as.character()
stran1 <- gsub("^.*\\(\\[(.*) \\]\\).*$", "\\1", stran)
stran1 <- strsplit(stran1, split="   ")[[1]]
drzave <- gsub("^.*'(.*)'.*$", "\\1",stran1)
cifre=gsub("^.*, (.*)\\].*$", "\\1",stran1)
tabelaCostliving = data.frame(Drzave=drzave,vrednost=as.numeric(cifre))[seq(3,length(cifre)-2,2),]
names(tabelaCostliving) <- c("Država", "Indeks stroška življenja")

#Tabela, ki združuje vse tabele
zdruzenaPlaceBDP <- tabelaPlace %>% inner_join(tabelaBDP, "Država"="Država")
zdruzenaPlaceBDPCrimeindex <- zdruzenaPlaceBDP %>% inner_join(tabelaCrimeindex, "Država"="Država")