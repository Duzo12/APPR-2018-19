# 4. faza: Analiza podatkov
source("lib/libraries.r", encoding="UTF-8")
source("uvoz/uvoz.r", encoding="UTF-8")

#Samostojni grafi 
ggplot(data =SkupnaTabela, aes(x=reorder(Drzava, -Vrednost.BDP), y=Vrednost.BDP)) +
  geom_bar(stat = "Identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),text = element_text(size=5)) +
  coord_flip()

ggplot(data=SkupnaTabela, aes(x=Visina.place, y=reorder(Drzava, -Visina.place), fill=factor(ifelse(area="Switzerland", "Highlighted","Normal" )))) + 
  geom_bar(stat = "Identity") + scale_fill_manual(name = "area", values = c("red", "grey50")) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),text = element_text(size=5)) +
  coord_flip() 


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
