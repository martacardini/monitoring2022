# R code for estimating energy in ecosystems

# install.packages("raster")
# install.packages("rgdal")
 library(raster)
 library(rgdal)
 
 # setting the working directory
 setwd("C:/lab") # windows
 
 # importing the data
l1992 <- brick("defor1_.jpg") # image from 1992
l1992

# Bands: defor1_.1, defor1_.2, defor1_.3 
# plotRGB
plotRGB(l1992, r="defor1_.1", g="defor1_.2", b="defor1_.3", stretch="Lin")
# plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")


# defor1_.1 = NIR
# defor1_.2 = 
# defor1_.3 = 

# change colors
plotRGB(l1992, r=3, g=2, b=1, stretch="Lin")
plotRGB(l1992, r="defor1_.2", g="defor1_.1", b="defor1_.3", stretch="Lin")
