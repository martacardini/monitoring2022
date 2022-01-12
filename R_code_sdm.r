# R code for species distribution modelling, namely the distribution of individuals 

library(sdm)
library(raster) #predictors
library(rgdal) #species
# we will use the default data included in the package
 
# species data:
# system.files() function: showing all of the files in a certain package.
system.file("external/species.shp", package="sdm")
file <- system.file("external/species.shp", package="sdm")

shapefile(file) #exactly as the raster function for raster files, but for shape (.shp) files #Raster used to import raster data into R; shape to import points into R.
species <- shapefile(file) # assign this function to the object species
species #data frame, each row of the data frame is a point. 200 points in this data set. the only variable is the occurrence(1=presence, 0=absence)
species$Occurrence # to see all 200 occurrences
species[3,]$Occurrence # to see a given occurrence (in this case 3)

#how many occurrences are there?
species[species$Occurrence == 1,] # as a result we have a spatial point data frame with 94 points which are the occurrences
species[species$Occurrence == 0,] # the absences 200-94 = 106

# build a new dataset with only the presences by assigning it to an object
presences <- species[species$Occurrence == 1,]
absences <- species[species$Occurrence == 0,]

# plot
# the whole dataset
plot(species, pch =19)
plot(presences, pch =19, col = "blue")
plot(absences, pch = 19, col = "red")

# plot together presences and absences, using the function points() # https://www.rdocumentation.org/packages/graphics/versions/3.6.2/topics/points
plot(presences, pch =19, col = "green")
points(absences, pch = 19, col = "red")

# predictors

path <- system.file("external/", package="sdm")
lst <- list.files(path, pattern = "asc", full.names=T)

# make a stack 
preds <-stack(lst)

#plot
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

plot(preds$elevation, col =cl)
points (presences, pch= 19, col = 'green', cex = 0.5)

plot(preds$temperature, col =cl)
points (presences, pch= 19, col = 'green', cex = 0.5)

plot(preds$vegetation, col =cl)
points (presences, pch= 19, col = 'green', cex = 0.5)


plot(preds$precipitation, col =cl)
points (presences, pch= 19, col = 'green', cex = 0.5)

# make a model of the distribution


############à DAY 2 
#importing the source script

setwd('C:/lab')

# function source() https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/source
source("R_code_source_sdm.r.txt")

preds
# these are the predictors: precipitation, temperature, elevation, vegetation

datasdm <- sdmData(train=species, predictors = preds)
#class: sdmdata. 1 species (larix) column: occurrence. features:4(predictors). type of data: presence-absence

# sdm function https://www.rdocumentation.org/packages/sdm/versions/1.0-89/topics/sdm 
#make a model to calculate presence of a species 
# y= bx + a a being intercept, b the slope, y=occurrence, x = temperature (a and b calculated by sdm); other x are elevation 
m1 <- sdm(formula = Occurrence ~ temperature + elevation + vegetation + precipitation, data = datasdm, method = 'glm')

###### day 3 ###########
