## Trees of Cologne
This work is based on data published by the City of Cologne in Germany. The original dataset contains information on 134.189 trees in the city - size, age, geometry, etc. I wanted to see wether it is possible to make some climate adaption politics visible.

The work was done for the MOOC "Introduction to R for Journalists" of the Knight Center held by Andrew Tran.

The code was written in RStudio Version 1.1.456 on a mac. These are the packages I used: ggplot2, tidyverse, sf.

----


## License / Lizenzen

# English
The raw data concerning the trees was published by the City of Cologne: [https://open.nrw/dataset/baumkataster-koeln-k]. It was made available under the following license: Attribution 4.0 International (CC BY 4.0) ([https://creativecommons.org/licenses/by/4.0/legalcode]).

The shape files for the City of Cologne were also published by the City of Cologne under the following titel: Stadtteil ([https://offenedaten-koeln.de/dataset/stadtteile]). They were made available under the following license: Attribution 3.0 Germany (CC BY 3.0 DE) ([https://creativecommons.org/licenses/by/3.0/de/legalcode]).

My work on this data is available under the Attribution 4.0 International (CC BY 4.0) license ([https://creativecommons.org/licenses/by/4.0/legalcode]).

# Deutsch
Urheber der genutzen Rohdaten zum Baumbestand ist die Stadt Köln: [https://open.nrw/dataset/baumkataster-koeln-k]. Die Daten wurden unter folgender Lizenz veröffentlicht: Namensnennung 4.0 International (CC BY 4.0) [https://creativecommons.org/licenses/by/4.0/legalcode.de].

Die Shapefiles von Köln wurden ebenfalls von der Stadt Köln veröffentlicht, unter dem folgenden Titel: Stadtteil ([https://offenedaten-koeln.de/dataset/stadtteile]). Die Daten wurden unter folgender Lizenz veröffentlicht: Namensnennung 3.0 Deutschland (CC BY 3.0 DE) ([https://creativecommons.org/licenses/by/3.0/de/legalcode]).

Meine Bearbeitung der Daten kann unter der Namensnennung 4.0 International (CC BY 4.0) Lizenz genutzt werden ([https://creativecommons.org/licenses/by/4.0/legalcode.de]).

----

## About the folders in this repo
**raw_data:** data as published by the City of Cologne on the 19.04.2017
**output_data:** data as csv after cleaning - but not the cleaned shape files
**scripts:** the code seperated into 4 steps: Packages and data import, cleaning and joining, plotting, mapping; all together in the run_all
**docs:** for now: the rmd as html
**images:** pngs of the plotting and the maps
**rmd:** the whole project commented