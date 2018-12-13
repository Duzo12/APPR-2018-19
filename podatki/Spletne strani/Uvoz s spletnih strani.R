library(rvest)
library(gsubfn)
library(readr)
library(dplyr)
library(XML)

link <- "https://en.wikipedia.org/wiki/List_of_countries_by_median_age"
stran <- html_session(link) %>% read_html()
tabelastarosti <- stran %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
  .[[1]] %>% html_table(dec= ",")

link <- "https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(PPP)_per_capita#Distorted_GDP-per-capita_for_tax_havens"
stran <- html_session(link) %>% read_html()
tabelaBDP <- stran %>% html_nodes(xpath = "//table[@class='wikitable sortable']") %>%
  .[[2]] %>% html_table(dec= ",")

link <- "https://www.worldatlas.com/articles/murder-rates-by-country.html"
stran <- html_session(link) %>% read_html()
tabelaUmorov <- stran %>% html_nodes(xpath = "//table") %>%
  .[[1]] %>% html_table(dec= ",")

#Poskus s spletne csv
link <- "https://www.numbeo.com/cost-of-living/country_price_rankings?displayCurrency=USD&itemId=105"
stran <- html_session(link) %>% read_html() %>% as.character()
stran1 <- gsub("^\\([\n(.*)]\\);$", "\\1", stran)

