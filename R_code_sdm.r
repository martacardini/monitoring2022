# R code for species distribution modelling, namely the distribution of individuals 

library(sdm)
library(raster) #predictors
library(rgdal) #species
# we will use the default data included in the package
 
# system.files() function: showing all of the fules in a certain package.
system.file("external/species.shp", package="sdm")
file <- system.file("external/species.shp", package="sdm")

shapefile(file) #exactly as the raster function for raster files, but for shape (.shp) files
species <- shapefile(file)
plot(species, pch =19, col =red)
