library(rvest)
library(gsubfn)
library(readr)
library(dplyr)

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
tabelaUmorov <- stran %>% html_nodes(xpath = "//h2[@class='tableToggle-h2']") %>%
  .[[1]] %>% html_table(dec= ",")