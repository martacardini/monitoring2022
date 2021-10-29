# R code for ecosystem monitoring by remote sensing
# first we need to download an additional R package

# links for download and package info:
# https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/install.packages
# https://cran.r-project.org/web/packages/raster/index.html

# install.packages("raster")

library(raster)

# https://www.rdocumentation.org/packages/raster/versions/3.4-13/topics/brick

setwd("C:/lab")

# we are going to import satellite data from the lab folder

# brick("p224r63_2011.grd")

# we assign this brick function a name

l2011 <- brick("p224r63_2011.grd")

l2011

plot(l2011)

# B1 is the reflectance in the blue band
# B2 is the reflectance in the green band
# B3 is the reflectance in the red band

# colorRampPalette function: chances color we see
# 100 means the number pf tones we have in our palette
cl <- colorRampPalette(c("black", "grey", "light grey"))(100)
plot(l2011, col=cl)

# plotting the set of bands to see the image in colours
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")

