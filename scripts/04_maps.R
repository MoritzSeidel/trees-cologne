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