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