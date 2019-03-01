# 3. faza: Vizualizacija podatkov

# Uvozimo zemljevid.
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
  geom_polygon(aes(x = long, y = lat, group = group, fill = Povprecje.let )) + xlab("") + ylab("") + ggtitle("Starost prebivalstva")
slikazemljevid <- slikazemljevid + guides(fill=guide_legend(title="Starost(leta)"))
slikazemljevid


