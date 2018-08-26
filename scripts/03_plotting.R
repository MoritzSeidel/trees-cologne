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