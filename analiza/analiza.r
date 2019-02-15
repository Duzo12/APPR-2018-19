# 4. faza: Analiza podatkov
source("lib/libraries.r", encoding="UTF-8")
source("uvoz/uvoz.r", encoding="UTF-8")

#Samostojni grafi 
SkupnaTabela$Drzava = factor(SkupnaTabela$Drzava,levels=SkupnaTabela %>% arrange(Visina.place) %>% .$Drzava,
                             ordered = TRUE)

pobarvane_drzave = c("Switzerland","Spain", "Japan")
indeksi_barv=which(rev(levels(SkupnaTabela$Drzava))%in%pobarvane_drzave)
barve = c(rep(NA,nrow(SkupnaTabela)))
barve[indeksi_barv] = "red"

ggplot(data =SkupnaTabela, aes(x=reorder(Drzava, -Vrednost.BDP), y=Vrednost.BDP)) +
  geom_bar(stat = "Identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),text = element_text(size=5)) +
  coord_flip() + ylab("BDP") + xlab("Država") + ggtitle("Vrednost BDP-ja v državah po svetu")

ggplot(data=SkupnaTabela) + 
  geom_bar(aes(x=Drzava, y=Visina.place,fill=barve),stat = "Identity", show.legend = F)+
  coord_flip() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),text = element_text(size=7)) +
  xlab("Višina plače") + ylab("Država") + ggtitle("Višina plače v državah po svetu")


#Iskal povezave med grafi

ggplot(SkupnaTabela, aes(x = Visina.place, y = Vrednost.BDP)) +
  geom_point() +
  geom_smooth(method = lm, se= F)

ggplot(SkupnaTabela, aes(x = Visina.place, y = Povprecje.let)) +
  geom_point() +
  geom_smooth(method = loess)

ggplot(SkupnaTabela, aes(x = Visina.place, y = Indeks.izobrazbe)) +
  geom_point() +
  geom_smooth(method =  loess)

ggplot(SkupnaTabela, aes(x = Visina.place, y = Stopnja.kriminala)) +
  geom_point() +
  geom_smooth(method =  loess)

ggplot(SkupnaTabela, aes(x = Visina.place, y = Zivljenjski.stroski)) +
  geom_point() +
  geom_smooth(method =  loess)

ggplot(SkupnaTabela, aes(x = Indeks.izobrazbe , y = Zivljenjski.stroski )) +
  geom_point() +
  geom_smooth(method =  loess)

ggplot(SkupnaTabela, aes(x = Indeks.izobrazbe, y = Povprecje.let )) +
  geom_point() +
  geom_smooth(method = loess)
