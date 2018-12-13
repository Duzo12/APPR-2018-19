# Analiza podatkov s programom R, 2018/19

# Nejc Duščak


Repozitorij z gradivi pri predmetu APPR v študijskem letu 2018/19

* [![Shiny](http://mybinder.org/badge.svg)](http://beta.mybinder.org/v2/gh/Duzo12/APPR-2018-19/master?urlpath=shiny/APPR-2018-19/projekt.Rmd) Shiny
* [![RStudio](http://mybinder.org/badge.svg)](http://beta.mybinder.org/v2/gh/Duzo12/APPR-2018-19/master?urlpath=rstudio) RStudio

## Bruto in neto plače po svetu

Izbral sem si temo bruto in neto plač po svetu. V svoji nalogi bom raziskal kakšne so povprečne bruto in neto plače po svetu. Posikal bom tudi povprečno žensko in moško plačo v neki državi. Glede na število moških in žensk v neki državi bom posikal povezavo z višino povprečne plače. Plače bom prav tako primerjal geografsko in jih povezal z BDP-jem te države. Prav tako se mi zdi zanimiva primerjava plače in kriminala. Na koncu pa bom plače primerjal tudi s starostjo.

## Podatkovni viri

Viri:
  - podatki o povprečni mesečni plači:
      https://www.numbeo.com/cost-of-living/prices_by_country.jsp?displayCurrency=USD&itemId=105
  - podatki o življenjskih stroških:
      https://www.numbeo.com/cost-of-living/
  - podatki o številu kriminala:
      https://www.numbeo.com/crime/rankings_by_country.jsp
      https://www.worldatlas.com/articles/murder-rates-by-country.html
  - podatki o povprečni starosti:
      https://en.wikipedia.org/wiki/List_of_countries_by_median_age
  - podatki o BDP-ju:
      https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(PPP)_per_capita
      
## Zasnova podatkovnega dela

Prvo bom poiskal povprečno plačo za posamezno države, znotraj vsake države pa bom navedel povprečno plačo moških in žensk oziroma procentualno razliko med povprečno žensko in moško plačo. Tako bodo v prvem stolpcu moje tabele naštete vse države, nato bo sledila povprečna plača in kasneje še razlika med plačama obeh spolov. Prav tako bom poiskal podatke o BDP-ju, kriminalu in starosti prebivalstva, ter jih vključil v tabelo. Na koncu bom poiskal stroške življenja v posamezni državi, kjer bom stroške razdelil na več podskupin in jih tako primerjal s povprečno plačo. 

## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`.
Ko ga prevedemo, se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`.
Podatkovni viri so v mapi `podatki/`.
Zemljevidi v obliki SHP, ki jih program pobere,
se shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `rgdal` - za uvoz zemljevidov
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `mosaic` - za pretvorbo zemljevidov v obliko za risanje z `ggplot2`
* `maptools` - za delo z zemljevidi
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)

## Binder

Zgornje [povezave](#analiza-podatkov-s-programom-r-201819)
omogočajo poganjanje projekta na spletu z orodjem [Binder](https://mybinder.org/).
V ta namen je bila pripravljena slika za [Docker](https://www.docker.com/),
ki vsebuje večino paketov, ki jih boste potrebovali za svoj projekt.

Če se izkaže, da katerega od paketov, ki ji potrebujete, ni v sliki,
lahko za sprotno namestitev poskrbite tako,
da jih v datoteki [`install.R`](install.R) namestite z ukazom `install.packages`.
Te datoteke (ali ukaza `install.packages`) **ne vključujte** v svoj program -
gre samo za navodilo za Binder, katere pakete naj namesti pred poganjanjem vašega projekta.

Tako nameščanje paketov se bo izvedlo pred vsakim poganjanjem v Binderju.
Če se izkaže, da je to preveč zamudno,
lahko pripravite [lastno sliko](https://github.com/jaanos/APPR-docker) z želenimi paketi.

Če želite v Binderju delati z git,
v datoteki `gitconfig` nastavite svoje ime in priimek ter e-poštni naslov
(odkomentirajte vzorec in zamenjajte s svojimi podatki) -
ob naslednjem.zagonu bo mogoče delati commite.
Te podatke lahko nastavite tudi z `git config --global` v konzoli
(vendar bodo veljale le v trenutni seji).
