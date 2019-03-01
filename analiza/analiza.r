# 4. faza: Analiza podatkov

#Samostojni grafi 
SkupnaTabela$Drzava <- factor(SkupnaTabela$Drzava,levels=SkupnaTabela %>% arrange(Visina.place) %>% .$Drzava,
                             ordered = TRUE)

pobarvane_drzave = c("Switzerland","Slovenia", "Egypt")
indeksi_barv=which(rev(levels(SkupnaTabela$Drzava))%in%pobarvane_drzave)
barve = c(rep(NA,nrow(SkupnaTabela)))
barve[indeksi_barv] = "red"

ggplot(data =SkupnaTabela) +
  geom_bar(aes(x= reorder(Drzava, Vrednost.BDP), y=Vrednost.BDP,fill=barve),stat = "Identity", show.legend = F)+
  coord_flip() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),text = element_text(size=7)) +
  xlab("Država") + ylab("Vrednost BDP") + ggtitle("Vrednost BDP za države po svetu")

ggplot(data=SkupnaTabela) + 
  geom_bar(aes(x=Drzava, y=Visina.place,fill=barve),stat = "Identity", show.legend = F)+
  coord_flip() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),text = element_text(size=7)) +
  xlab("Država") + ylab("Višina plače") + ggtitle("Višina plače v državah po svetu")

#Iskal povezave med grafi

ggplot(SkupnaTabela, aes(x = Visina.place, y = Vrednost.BDP)) +
  geom_point() +
  geom_smooth(method = loess)

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

ggplot(SkupnaTabela, aes(x = Povprecje.let, y = Indeks.izobrazbe )) +
  geom_point() +
  geom_smooth(method = loess)
