#This requires a dataframe with a column that has the species name and another column that has the "status" (i.e. native vs non-native). 
#You could probably even use the same species list from the ERG data set I have listed below and just add in the few missing species. 
#The column names and species names must be spelled the same though. 

## load species list
spp.list <- read.csv("Data/ERG.specieslist.csv")

## convert data to long format
status <- gather(community, species, abundance, 13:53)
names(spp.list)[1] <- "species" ## rename species column for merge

## combine native-non-native status with data set
status <- merge(status, spp.list, by="species")

## summarize per plot native and non-natives, convert back to wide format
mean.status <- status %>% group_by(Year, Site, Microsite, Rep, status) %>% summarize(abundance=sum(abundance))
mean.status <- spread(mean.status, status, abundance)