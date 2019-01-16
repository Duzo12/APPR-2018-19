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

source('lib/uvozi.zemljevid.r')
zemljevid <- uvozi.zemljevid("https://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/110m_cultural.zip",
                             "ne_110m_admin_0_countries", encoding="UTF-8") %>% fortify
