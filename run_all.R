# Loading packages
# If you don't have all the packages, uncomment lines below and run code:

#install.packages("ggplot2")
library(ggplot2)
#install.packages("tidyverse")
library(tidyverse)
#install.packages("sf")
library(sf)

# Importing the data
# This gives you a csv file with the data concerning the trees

url <- "https://offenedaten-koeln.de/sites/default/files/Bestand_Einzelbaeume_Koeln_0.csv"
datatrees <- read_csv2(url)

# If the data is not accessible you can still find it under raw_data in the repo and import it by running this:

#datatrees <- read_csv2("raw_data/Bestand_Einzelbaeume.csv")

# Next: The same data - but this time as shape file:

shape_trees <- "raw_data/shapes_trees_cologne/Bestand_Einzelbaeume.shp"
trees <- st_read(shape_trees)

# Finaly: Shape files for the City of Cologne

shape_cologne <- "raw_data/shapes_quarters_cologne/Stadtteil.shp"
cologne <- st_read(shape_cologne)

# Cleaning for plotting
# Getting rid of unnecesseray variables 

datatrees_narrow <- datatrees %>% 
  select(AlterSchätzung, DeutscherN) %>%
  filter(!is.na(DeutscherN)) %>%
  filter(DeutscherN!="unbekannt") %>%
  filter(DeutscherN!="Verschiedene") %>% 
  filter(AlterSchätzung!=0)

# Creating new variable we need (Heimisch means domestic)

datatrees_domestic <- datatrees_narrow %>% 
  mutate(Heimisch=case_when(
    DeutscherN=="Ahorn" ~ "Heimisch",
    DeutscherN=="Amberbaum" ~ "Andere",
    DeutscherN=="Amerikanische Linde" ~ "Andere",
    DeutscherN=="Amerikanische Rot-Eiche" ~ "Andere",
    DeutscherN=="Amerikanische Stadt-Linde" ~ "Andere",
    DeutscherN=="Amerikanischer Tulpenbaum" ~ "Andere",
    DeutscherN=="Apfel" ~ "Heimisch",
    DeutscherN=="Atlas-Zeder" ~ "Andere",
    DeutscherN=="Baumhasel" ~ "Andere",
    DeutscherN=="Berg-Ulme" ~ "Heimisch",
    DeutscherN=="Bergahorn" ~ "Heimisch",
    DeutscherN=="Birke" ~ "Heimisch",
    DeutscherN=="Birne" ~ "Heimisch",
    DeutscherN=="Blasenbaum" ~ "Andere",
    DeutscherN=="Blauglockenbaum" ~ "Andere",
    DeutscherN=="Blumen-Esch" ~ "Andere",
    DeutscherN=="Blut-Ahorn, Spitzahorn" ~ "Heimisch",
    DeutscherN=="Blut-Pflaume" ~ "Heimisch",
    DeutscherN=="Chinesische Ulme" ~ "Andere",
    DeutscherN=="Coloradotanne" ~ "Andere",
    DeutscherN=="Crataegus, Dorn" ~ "Heimisch",
    DeutscherN=="Dreidorniger Lederhülsenbaum, Gleditschie" ~ "Andere",
    DeutscherN=="Eberesche, Mehlbeere, Vogelbeerbaum" ~ "Heimisch",
    DeutscherN=="Echter Korkbaum, Amur-Korkbaum" ~ "Andere",
    DeutscherN=="Echter Rotdorn" ~ "Heimisch",
    DeutscherN=="Eibe" ~ "Heimisch",
    DeutscherN=="Eiche" ~ "Heimisch",
    DeutscherN=="Einblättrige Esche" ~ "Andere",
    DeutscherN=="Eisenbaum" ~ "Andere",
    DeutscherN=="Eisenholzbaum" ~ "Andere",
    DeutscherN=="Erle" ~ "Heimisch",
    DeutscherN=="Esche" ~ "Heimisch",
    DeutscherN=="Eschen-Ahorn" ~ "Andere",
    DeutscherN=="Etagen Hartriegel" ~ "Andere",
    DeutscherN=="Fächer-Ahorn" ~ "Andere",
    DeutscherN=="Farn- oder geschlitzblättrige Birke" ~ "Andere",
    DeutscherN=="Feldahorn" ~ "Heimisch",
    DeutscherN=="Felsenbirne" ~ "Heimisch",
    DeutscherN=="Feuerahorn" ~ "Andere",
    DeutscherN=="Fichte" ~ "Heimisch",
    DeutscherN=="Flügelnuß" ~ "Heimisch",
    DeutscherN=="Gelbe Gleditschie" ~ "Andere",
    DeutscherN=="Gemeine Esche" ~ "Heimisch",
    DeutscherN=="Gemeiner Goldregen" ~ "Andere",
    DeutscherN=="Gemeiner Judasbaum, Herzbaum" ~ "Andere",
    DeutscherN=="Gewöhnliche Eberesche" ~ "Heimisch",
    DeutscherN=="Gewöhnliche Kiefer" ~ "Heimisch",
    DeutscherN=="Ginkgo" ~ "Andere",
    DeutscherN=="Ginkgobaum, Fächerblattbaum" ~ "Andere",
    DeutscherN=="Gleditsie, Lederhülsenbaum" ~ "Andere",
    DeutscherN=="Goldrobinie" ~ "Andere",
    DeutscherN=="Götterbaum" ~ "Andere",
    DeutscherN=="Großblättrige Sommerlinde" ~ "Heimisch",
    DeutscherN=="Grüne Hängebuche" ~ "Heimisch",
    DeutscherN=="Hainbuche, Weißbuche" ~ "Heimisch",
    DeutscherN=="Hasel" ~ "Heimisch",
    DeutscherN=="Holzbirne, Gemeine Birne" ~ "Heimisch",
    DeutscherN=="Hopfenbuche" ~ "Andere",
    DeutscherN=="Italienische Erle" ~ "Andere",
    DeutscherN=="Japanische Nelken-Kirsche" ~ "Andere",
    DeutscherN=="Japanischer Schnurbaum" ~ "Andere",
    DeutscherN=="Judasblattbaum, Lebkuchenbaum" ~ "Andere",
    DeutscherN=="Kaiserlinde" ~ "Heimisch",
    DeutscherN=="Kanadische Hemlocktanne" ~ "Andere",
    DeutscherN=="Kanadische Holz-Pappel" ~ "Andere",
    DeutscherN=="Kastanie" ~ "Heimisch",
    DeutscherN=="Kegel-Robinie" ~ "Andere",
    DeutscherN=="Kiefer" ~ "Heimisch",
    DeutscherN=="Kirsche" ~ "Heimisch",
    DeutscherN=="Kolchischer Ahorn" ~ "Andere",
    DeutscherN=="Krimlinde" ~ "Heimisch",
    DeutscherN=="Kugel-Trompetenbaum" ~ "Andere",
    DeutscherN=="Kugelahorn" ~ "Heimisch",
    DeutscherN=="Kugelrobinie" ~ "Andere",
    DeutscherN=="Kupfer-Felsenbirne" ~ "Andere",
    DeutscherN=="Küstenmammutbaum" ~ "Andere",
    DeutscherN=="Lebensbaum" ~ "Andere",
    DeutscherN=="Lederblättriger Weißdorn" ~ "Andere",
    DeutscherN=="Libanon-Zeder" ~ "Andere",
    DeutscherN=="Linde" ~ "Heimisch",
    DeutscherN=="Lorbeermispel, Glanzmispel" ~ "Andere",
    DeutscherN=="Magnolie" ~ "Andere",
    DeutscherN=="Mammutbaum" ~ "Andere",
    DeutscherN=="Marone, Eßkastanie" ~ "Andere",
    DeutscherN=="Mehlbeere" ~ "Heimisch",
    DeutscherN=="Österreichische Schwarzkiefer" ~ "Andere",
    DeutscherN=="Papierbirke" ~ "Andere",
    DeutscherN=="Pappel" ~ "Heimisch",
    DeutscherN=="Pfaffenhütchen (Spindelbaum" ~ "Heimisch",
    DeutscherN=="Platane" ~ "Heimisch",
    DeutscherN=="Purpur-Kastanie, Blut-Kastanie" ~ "Heimisch",
    DeutscherN=="Pyramiden-Eiche, Säulen-Eiche" ~ "Heimisch",
    DeutscherN=="Pyramiden-Hainbuche" ~ "Heimisch",
    DeutscherN=="Roßkastanie" ~ "Heimisch",
    DeutscherN=="Rot-Buche" ~ "Heimisch",
    DeutscherN=="Rotahorn" ~ "Andere",
    DeutscherN=="Roter Holunder" ~ "Heimisch",
    DeutscherN=="Rundblättrige Rotbuche" ~ "Heimisch",
    DeutscherN=="Sal-Weide" ~ "Heimisch",
    DeutscherN=="Sandbirke" ~ "Heimisch",
    DeutscherN=="Sanddorn" ~ "Heimisch",
    DeutscherN=="Säulen-Tulpenbaum" ~ "Andere",
    DeutscherN=="Säulen-Ulme" ~ "Heimisch",
    DeutscherN=="Säulenpappel, Pyramidenpappel" ~ "Heimisch",
    DeutscherN=="Säulenrobinie" ~ "Andere",
    DeutscherN=="Scheinakazie" ~ "Andere",
    DeutscherN=="Scheinzypresse" ~ "Andere",
    DeutscherN=="Schmalkroniger Rotahorn" ~ "Andere",
    DeutscherN=="Schnurbaum" ~ "Andere",
    DeutscherN=="Schwarz-Erle, Rot-Erle" ~ "Heimisch",
    DeutscherN=="Schwarzer Holunder" ~ "Heimisch",
    DeutscherN=="Schwarzkiefer" ~ "Andere",
    DeutscherN=="Schwarznuß" ~ "Andere",
    DeutscherN=="Schwarzpappel" ~ "Heimisch",
    DeutscherN=="Schwedische Mehlbeere" ~ "Andere",
    DeutscherN=="Silber-Ahorn" ~ "Andere",
    DeutscherN=="Silber-Weide" ~ "Heimisch",
    DeutscherN=="Silberlinde" ~ "Andere",
    DeutscherN=="Silberpappel" ~ "Heimisch",
    DeutscherN=="Sommer-Eiche, Stieleiche" ~ "Heimisch",
    DeutscherN=="Späte Traubenkirsche" ~ "Andere",
    DeutscherN=="Späth's Erle" ~ "Heimisch",
    DeutscherN=="Spitzahorn" ~ "Heimisch",
    DeutscherN=="Spitzahorn Cleveland" ~ "Andere",
    DeutscherN=="Stechpalme" ~ "Heimisch",
    DeutscherN=="Straßen-Akazie" ~ "Andere",
    DeutscherN=="Sumpf-Eiche" ~ "Andere",
    DeutscherN=="Tanne" ~ "Heimisch",
    DeutscherN=="Trauben-Kirsche" ~ "Heimisch",
    DeutscherN=="Trompetenbaum" ~ "Andere",
    DeutscherN=="Tulpenbaum" ~ "Andere",
    DeutscherN=="Ulme, Rüster" ~ "Heimisch",
    DeutscherN=="Ungarische Eiche" ~ "Andere",
    DeutscherN=="Ungarische Silberlinde" ~ "Andere",
    DeutscherN=="Urweltmammutbaum, Chinesisches Rotholz" ~ "Andere",
    DeutscherN=="Wacholder" ~ "Heimisch",
    DeutscherN=="Wal-, Nußbaum" ~ "Heimisch",
    DeutscherN=="Walnuß" ~ "Heimisch",
    DeutscherN=="Weide" ~ "Heimisch",
    DeutscherN=="Weißdorn" ~ "Heimisch",
    DeutscherN=="Winter-Eiche, Trauben-Eiche" ~ "Heimisch",
    DeutscherN=="Winterlinde" ~ "Heimisch",
    DeutscherN=="Winterlinde Cordaley" ~ "Heimisch",
    DeutscherN=="Winterlinde Dila" ~ "Heimisch",
    DeutscherN=="Zeder" ~ "Andere",
    DeutscherN=="Zelkove" ~ "Andere",
    DeutscherN=="Zier-Birne" ~ "Heimisch",
    DeutscherN=="Zierapfel" ~ "Heimisch",
    DeutscherN=="Zierkirsche 'Spire'" ~ "Heimisch"
  )) %>% 
  filter(!is.na(Heimisch))

# Save this

write_csv(datatrees_domestic, "output_data/datatrees_domestic.csv")

#Cleaning for mapping
#Getting rid of unnecessary variables

trees_small <- trees %>%
  select(AlterSchae, DeutscherN, geometry) %>%
  filter(!is.na(DeutscherN)) %>%
  filter(DeutscherN!="unbekannt") %>%
  filter(DeutscherN!="Verschiedene") %>% 
  filter(AlterSchae!=0)

#Creating new variable we need (Heimisch means domestic)

trees_domestic <- trees_small %>% 
  mutate(Heimisch=case_when(
    DeutscherN=="Ahorn" ~ "Heimisch",
    DeutscherN=="Amberbaum" ~ "Andere",
    DeutscherN=="Amerikanische Linde" ~ "Andere",
    DeutscherN=="Amerikanische Rot-Eiche" ~ "Andere",
    DeutscherN=="Amerikanische Stadt-Linde" ~ "Andere",
    DeutscherN=="Amerikanischer Tulpenbaum" ~ "Andere",
    DeutscherN=="Apfel" ~ "Heimisch",
    DeutscherN=="Atlas-Zeder" ~ "Andere",
    DeutscherN=="Baumhasel" ~ "Andere",
    DeutscherN=="Berg-Ulme" ~ "Heimisch",
    DeutscherN=="Bergahorn" ~ "Heimisch",
    DeutscherN=="Birke" ~ "Heimisch",
    DeutscherN=="Birne" ~ "Heimisch",
    DeutscherN=="Blasenbaum" ~ "Andere",
    DeutscherN=="Blauglockenbaum" ~ "Andere",
    DeutscherN=="Blumen-Esch" ~ "Andere",
    DeutscherN=="Blut-Ahorn, Spitzahorn" ~ "Heimisch",
    DeutscherN=="Blut-Pflaume" ~ "Heimisch",
    DeutscherN=="Chinesische Ulme" ~ "Andere",
    DeutscherN=="Coloradotanne" ~ "Andere",
    DeutscherN=="Crataegus, Dorn" ~ "Heimisch",
    DeutscherN=="Dreidorniger Lederhülsenbaum, Gleditschie" ~ "Andere",
    DeutscherN=="Eberesche, Mehlbeere, Vogelbeerbaum" ~ "Heimisch",
    DeutscherN=="Echter Korkbaum, Amur-Korkbaum" ~ "Andere",
    DeutscherN=="Echter Rotdorn" ~ "Heimisch",
    DeutscherN=="Eibe" ~ "Heimisch",
    DeutscherN=="Eiche" ~ "Heimisch",
    DeutscherN=="Einblättrige Esche" ~ "Andere",
    DeutscherN=="Eisenbaum" ~ "Andere",
    DeutscherN=="Eisenholzbaum" ~ "Andere",
    DeutscherN=="Erle" ~ "Heimisch",
    DeutscherN=="Esche" ~ "Heimisch",
    DeutscherN=="Eschen-Ahorn" ~ "Andere",
    DeutscherN=="Etagen Hartriegel" ~ "Andere",
    DeutscherN=="Fächer-Ahorn" ~ "Andere",
    DeutscherN=="Farn- oder geschlitzblättrige Birke" ~ "Andere",
    DeutscherN=="Feldahorn" ~ "Heimisch",
    DeutscherN=="Felsenbirne" ~ "Heimisch",
    DeutscherN=="Feuerahorn" ~ "Andere",
    DeutscherN=="Fichte" ~ "Heimisch",
    DeutscherN=="Flügelnuß" ~ "Heimisch",
    DeutscherN=="Gelbe Gleditschie" ~ "Andere",
    DeutscherN=="Gemeine Esche" ~ "Heimisch",
    DeutscherN=="Gemeiner Goldregen" ~ "Andere",
    DeutscherN=="Gemeiner Judasbaum, Herzbaum" ~ "Andere",
    DeutscherN=="Gewöhnliche Eberesche" ~ "Heimisch",
    DeutscherN=="Gewöhnliche Kiefer" ~ "Heimisch",
    DeutscherN=="Ginkgo" ~ "Andere",
    DeutscherN=="Ginkgobaum, Fächerblattbaum" ~ "Andere",
    DeutscherN=="Gleditsie, Lederhülsenbaum" ~ "Andere",
    DeutscherN=="Goldrobinie" ~ "Andere",
    DeutscherN=="Götterbaum" ~ "Andere",
    DeutscherN=="Großblättrige Sommerlinde" ~ "Heimisch",
    DeutscherN=="Grüne Hängebuche" ~ "Heimisch",
    DeutscherN=="Hainbuche, Weißbuche" ~ "Heimisch",
    DeutscherN=="Hasel" ~ "Heimisch",
    DeutscherN=="Holzbirne, Gemeine Birne" ~ "Heimisch",
    DeutscherN=="Hopfenbuche" ~ "Andere",
    DeutscherN=="Italienische Erle" ~ "Andere",
    DeutscherN=="Japanische Nelken-Kirsche" ~ "Andere",
    DeutscherN=="Japanischer Schnurbaum" ~ "Andere",
    DeutscherN=="Judasblattbaum, Lebkuchenbaum" ~ "Andere",
    DeutscherN=="Kaiserlinde" ~ "Heimisch",
    DeutscherN=="Kanadische Hemlocktanne" ~ "Andere",
    DeutscherN=="Kanadische Holz-Pappel" ~ "Andere",
    DeutscherN=="Kastanie" ~ "Heimisch",
    DeutscherN=="Kegel-Robinie" ~ "Andere",
    DeutscherN=="Kiefer" ~ "Heimisch",
    DeutscherN=="Kirsche" ~ "Heimisch",
    DeutscherN=="Kolchischer Ahorn" ~ "Andere",
    DeutscherN=="Krimlinde" ~ "Heimisch",
    DeutscherN=="Kugel-Trompetenbaum" ~ "Andere",
    DeutscherN=="Kugelahorn" ~ "Heimisch",
    DeutscherN=="Kugelrobinie" ~ "Andere",
    DeutscherN=="Kupfer-Felsenbirne" ~ "Andere",
    DeutscherN=="Küstenmammutbaum" ~ "Andere",
    DeutscherN=="Lebensbaum" ~ "Andere",
    DeutscherN=="Lederblättriger Weißdorn" ~ "Andere",
    DeutscherN=="Libanon-Zeder" ~ "Andere",
    DeutscherN=="Linde" ~ "Heimisch",
    DeutscherN=="Lorbeermispel, Glanzmispel" ~ "Andere",
    DeutscherN=="Magnolie" ~ "Andere",
    DeutscherN=="Mammutbaum" ~ "Andere",
    DeutscherN=="Marone, Eßkastanie" ~ "Andere",
    DeutscherN=="Mehlbeere" ~ "Heimisch",
    DeutscherN=="Österreichische Schwarzkiefer" ~ "Andere",
    DeutscherN=="Papierbirke" ~ "Andere",
    DeutscherN=="Pappel" ~ "Heimisch",
    DeutscherN=="Pfaffenhütchen (Spindelbaum" ~ "Heimisch",
    DeutscherN=="Platane" ~ "Heimisch",
    DeutscherN=="Purpur-Kastanie, Blut-Kastanie" ~ "Heimisch",
    DeutscherN=="Pyramiden-Eiche, Säulen-Eiche" ~ "Heimisch",
    DeutscherN=="Pyramiden-Hainbuche" ~ "Heimisch",
    DeutscherN=="Roßkastanie" ~ "Heimisch",
    DeutscherN=="Rot-Buche" ~ "Heimisch",
    DeutscherN=="Rotahorn" ~ "Andere",
    DeutscherN=="Roter Holunder" ~ "Heimisch",
    DeutscherN=="Rundblättrige Rotbuche" ~ "Heimisch",
    DeutscherN=="Sal-Weide" ~ "Heimisch",
    DeutscherN=="Sandbirke" ~ "Heimisch",
    DeutscherN=="Sanddorn" ~ "Heimisch",
    DeutscherN=="Säulen-Tulpenbaum" ~ "Andere",
    DeutscherN=="Säulen-Ulme" ~ "Heimisch",
    DeutscherN=="Säulenpappel, Pyramidenpappel" ~ "Heimisch",
    DeutscherN=="Säulenrobinie" ~ "Andere",
    DeutscherN=="Scheinakazie" ~ "Andere",
    DeutscherN=="Scheinzypresse" ~ "Andere",
    DeutscherN=="Schmalkroniger Rotahorn" ~ "Andere",
    DeutscherN=="Schnurbaum" ~ "Andere",
    DeutscherN=="Schwarz-Erle, Rot-Erle" ~ "Heimisch",
    DeutscherN=="Schwarzer Holunder" ~ "Heimisch",
    DeutscherN=="Schwarzkiefer" ~ "Andere",
    DeutscherN=="Schwarznuß" ~ "Andere",
    DeutscherN=="Schwarzpappel" ~ "Heimisch",
    DeutscherN=="Schwedische Mehlbeere" ~ "Andere",
    DeutscherN=="Silber-Ahorn" ~ "Andere",
    DeutscherN=="Silber-Weide" ~ "Heimisch",
    DeutscherN=="Silberlinde" ~ "Andere",
    DeutscherN=="Silberpappel" ~ "Heimisch",
    DeutscherN=="Sommer-Eiche, Stieleiche" ~ "Heimisch",
    DeutscherN=="Späte Traubenkirsche" ~ "Andere",
    DeutscherN=="Späth's Erle" ~ "Heimisch",
    DeutscherN=="Spitzahorn" ~ "Heimisch",
    DeutscherN=="Spitzahorn Cleveland" ~ "Andere",
    DeutscherN=="Stechpalme" ~ "Heimisch",
    DeutscherN=="Straßen-Akazie" ~ "Andere",
    DeutscherN=="Sumpf-Eiche" ~ "Andere",
    DeutscherN=="Tanne" ~ "Heimisch",
    DeutscherN=="Trauben-Kirsche" ~ "Heimisch",
    DeutscherN=="Trompetenbaum" ~ "Andere",
    DeutscherN=="Tulpenbaum" ~ "Andere",
    DeutscherN=="Ulme, Rüster" ~ "Heimisch",
    DeutscherN=="Ungarische Eiche" ~ "Andere",
    DeutscherN=="Ungarische Silberlinde" ~ "Andere",
    DeutscherN=="Urweltmammutbaum, Chinesisches Rotholz" ~ "Andere",
    DeutscherN=="Wacholder" ~ "Heimisch",
    DeutscherN=="Wal-, Nußbaum" ~ "Heimisch",
    DeutscherN=="Walnuß" ~ "Heimisch",
    DeutscherN=="Weide" ~ "Heimisch",
    DeutscherN=="Weißdorn" ~ "Heimisch",
    DeutscherN=="Winter-Eiche, Trauben-Eiche" ~ "Heimisch",
    DeutscherN=="Winterlinde" ~ "Heimisch",
    DeutscherN=="Winterlinde Cordaley" ~ "Heimisch",
    DeutscherN=="Winterlinde Dila" ~ "Heimisch",
    DeutscherN=="Zeder" ~ "Andere",
    DeutscherN=="Zelkove" ~ "Andere",
    DeutscherN=="Zier-Birne" ~ "Heimisch",
    DeutscherN=="Zierapfel" ~ "Heimisch",
    DeutscherN=="Zierkirsche 'Spire'" ~ "Heimisch"
  )) %>% 
  filter(!is.na(Heimisch))

# Joining

trees_joined <- trees_domestic %>%
  st_transform(crs=st_crs(cologne))
cologne_trees <- st_join(cologne, trees_joined, left=T)

#Grouping for plotting

datatrees_grouped <- datatrees_domestic %>% 
  group_by(AlterSchätzung, Heimisch) %>% 
  mutate(Anzahl=n())

# Plotting

datatrees_grouped %>% 
  ggplot(aes(x=AlterSchätzung, fill=Heimisch)) +
  geom_bar() +
  coord_flip() +
  labs(x="Alter",
       y="Menge",
       title="Heimische und nicht heimische Bäume in Köln",
       subtitle="nach geschätztem Alter",
       caption= "Quelle: Stadt Köln",
       fill="Herkunft")

# Saving what we just plotted

ggsave("Heimische_und_nicht_heimische_Baeume_in_Koeln.png")

# Mapping

# Grouping for Map 1: average age of trees per city quarter
# Warning: If you want to copy this: This takes a long time to compute!

cologne_trees_quarter <- cologne_trees %>% 
  group_by(STT_NAME) %>% 
  summarize(Durchschnitt_Alter=sum(AlterSchae)/n())

# Mapping

ggplot(cologne_trees_quarter) +
  geom_sf(aes(fill=Durchschnitt_Alter)) + 
  labs(title = "Wo die alten Bäume stehen",
       subtitle = "Durchschnittliches Alter der Bäume in Kölns Stadtvierteln April 2017",
       caption = "Quelle: Stadt Köln", 
       fill = "Durchschnittliches Alter") +
  scale_fill_distiller(trans="reverse", palette="Greens") +
  theme_void() +
  theme(panel.grid.major=element_line(colour="transparent")) +
  coord_sf()

#Save this

ggsave("images/map1_average_age_per_quarter.png")

# Grouping for Map 2: average age of trees per city quarter faceted by the different species
# Warning: If you want to copy this: This takes a long time to compute!

cologne_trees_quarter_species <- cologne_trees %>%
  group_by(STT_NAME, DeutscherN) %>%
  summarize(Durchschnitt_Alter=sum(AlterSchae)/n())

# Mapping
# Warning: If you want to copy this: This takes a long time to compute!

ggplot(cologne_trees_quarter_species) +
  geom_sf(aes(fill=Durchschnitt_Alter), color=NA) + 
  facet_wrap(~DeutscherN, ncol=4) +
  labs(title = "Wo die alten Bäume stehen - sortiert nach Baumart",
       subtitle = "Durchschnittliches Alter der Bäume in Kölns Stadtvierteln April 2017",
       caption = "Quelle: Stadt Köln", 
       fill = "Durchschnittliches Alter") +
  scale_fill_distiller(trans="reverse", palette="Greens") +
  theme_void() +
  theme(panel.grid.major=element_line(colour="transparent")) +
  coord_sf()

#Saving

ggsave("images/map2_average_age_per_quarter_and_species.png", width=100, height=100, units="cm")

# Grouping for Map 3: average age of trees per city quarter and faceted by domestic or not
# Warning: If you want to copy this: This takes a long time to compute!

cologne_trees_quarter_domestic <- cologne_trees%>%
  group_by(STT_NAME, Heimisch) %>%
  summarize(Durchschnitt_Alter=sum(AlterSchae)/n())

# Mapping

cologne_trees_quarter_domestic %>% 
  filter(!is.na(Heimisch)) %>%
  ggplot() +
  geom_sf(aes(fill=Durchschnitt_Alter)) +
  facet_wrap(~Heimisch) +
  labs(title = "Heimische und nicht heimische Bäume in Köln",
       subtitle = "Durchschnittliches Alter in den Stadtteilen April 2017",
       caption = "Quelle: Stadt Köln", 
       fill = "Durchschnittliches Alter") +
  scale_fill_distiller(trans="reverse", palette="Greens") +
  theme_void() +
  theme(panel.grid.major=element_line(colour="transparent")) +
  coord_sf()

# Saving

ggsave("images/map3_average_age_per_quarter_and_domestic_or_not.png")

# Grouping for Map 4: same idea as for map 3 - but only for trees ten years old or younger:

cologne_trees_quarter_domestic_10 <- cologne_trees%>%
  filter(AlterSchae<=10) %>% 
  group_by(STT_NAME, Heimisch) %>%
  summarize(Durchschnitt_Alter=sum(AlterSchae)/n())

# Mapping

cologne_trees_quarter_domestic_10 %>% 
  filter(!is.na(Heimisch)) %>%
  ggplot() +
  geom_sf(aes(fill=Durchschnitt_Alter)) +
  facet_wrap(~Heimisch) +
  labs(title = "Heimische und nicht heimische Bäume unter 10 Jahren in Köln",
       subtitle = "Durchschnittliches Alter in den Stadtteilen April 2017",
       caption = "Quelle: Stadt Köln", 
       fill = "Durchschnittliches Alter") +
  scale_fill_distiller(trans="reverse", palette="Greens") +
  theme_void() +
  theme(panel.grid.major=element_line(colour="transparent")) +
  coord_sf()

# Saving

ggsave("images/map4_average_age_per_quarter_and_domestic_or_not_under_10.png")