# 3. faza: Vizualizacija podatkov

# Uvozimo zemljevid.
library(rgdal)
library(rgeos)
library(mosaic)
library(maptools)






#zemljevid <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip", "OB",
                             #pot.zemljevida="OB", encoding="Windows-1250")
#levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
  #{ gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
#zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels=levels(obcine$obcina))
#zemljevid <- fortify(zemljevid)

source("lib/libraries.r", encoding="UTF-8")
source("uvoz/uvoz.r", encoding="UTF-8")
source('lib/uvozi.zemljevid.r')
zemljevid <- uvozi.zemljevid("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/110m_cultural.zip",
                             "ne_110m_admin_0_countries", encoding="UTF-8") %>% fortify

TabelaStarost$Drzava <- gsub("United States", "United States of America", TabelaStarost$Drzava)
TabelaStarost$Drzava <- gsub("Tanzania", "United Republic of Tanzania", TabelaStarost$Drzava)
TabelaStarost$Drzava <- gsub("Czech Republic", "Czechia", TabelaStarost$Drzava)
TabelaStarost$Drzava <- gsub("Serbia", "Republic of Serbia", TabelaStarost$Drzava)

lvls <- levels(zemljevid$ADMIN)
unikat <- unique(TabelaStarost$Drzava)
unikat[!(unikat%in%lvls)]



zemljevid$ADMIN <- as.character(zemljevid$ADMIN)

zdruzitev <- left_join(zemljevid, TabelaStarost, by=c("ADMIN"="Drzava"))

slikazemljevid <- ggplot(zdruzitev) + 
  geom_polygon(aes(x = long, y = lat, group = group, fill = Povprecje.let ))
slikazemljevid


