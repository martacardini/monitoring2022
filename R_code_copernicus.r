# R code for uploading and visualizing Copernicus data in R 
# install.packages("ncdf4")
library(ncdf4)
library(viridis)
library(RStoolbox)
library(ggplot2)
setwd("C:/lab/copernicus")

# import the copernicus data into R
snow20211214 <- raster("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
plot(snow20211214)

cl <- colorRampPalette(c('dark blue','blue ','light blue'))(100)
plot(snow20211214, col = cl)

# use the viridis package to change colors
# install.packages("viridis")
# library(viridis)

# do a ggplot + use geom_raster https://www.rdocumentation.org/packages/ggplot2/versions/0.9.0/topics/geom_raster
# the value for fill is in the "names" part of the file
# ggplot function
ggplot() + geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) 

# ggplot with viridis
ggplot() + geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) + scale_fill_viridis() # to use viridis palette
ggplot() + geom_raster(snow20211214, mapping = aes(x=x, y=y, fill=Snow.Cover.Extent)) + scale_fill_viridis(option = "cividis") + ggtitle ("cividis palette")# to use the other palettes

################################################

#import all data at the same time
library(ncdf4)
library(viridis)
library(RStoolbox)
library(ggplot2)
library(raster)
library(patchwork)
setwd("C:/lab/copernicus")

#list the files
snow2021 <- list.files(pattern = "nc")

#apply the function
snow_raster <- lapply(snow2021, raster)       # not use the brick function because we only have one layer
snow_raster
# make a stack
snowstack <- stack(snow_raster)
snowstack

# unstack the needed files
ssummer <- snowstack$Snow.Cover.Extent.1
swinter <- snowstack$Snow.Cover.Extent.2

# make a ggplot
p1 <- ggplot( data = ssummer) + geom_raster (data = ssummer, mapping = aes(x=x, y=y, fill = Snow.Cover.Extent.1)) + scale_fill_viridis() + ggtitle ("summer snow cover")
p2 <- ggplot( data = swinter) + geom_raster (data = swinter, mapping = aes(x=x, y=y, fill = Snow.Cover.Extent.2)) + scale_fill_viridis() + ggtitle ("winter snow cover")
p1/p2

# crop the image using the crop function      https://www.rdocumentation.org/packages/raster/versions/3.5-2/topics/crop
# longitude from 0 to 20
# latitude from 30 to 50
ext <- c(0, 20, 30, 50)
# stack_cropped <- crop (snowstack, ext)
summer_cropped <- crop(ssummer, ext)
winter_cropped <- crop(swinter, ext)

#make the ggplot
p1_it <- ggplot() + geom_raster(data= summer_cropped, mapping = aes(x=x, y=y, fill= Snow.Cover.Extent.1)) + scale_fill_viridis() + ggtitle("Summer snow in Italy")
p2_it <- ggplot() + geom_raster(data= winter_cropped, mapping = aes(x=x, y=y, fill= Snow.Cover.Extent.2)) + scale_fill_viridis() + ggtitle("Winter snow in Italy")
p1_it/p2_it

# zoom on the alps
extalps <- c(5, 14, 44, 48)
summer_alps_cropped <- crop(summer_cropped, extalps)
winter_alps_cropped <- crop(winter_cropped, extalps)
estate <- ggplot() + geom_raster(data= summer_alps_cropped, mapping = aes(x=x, y=y, fill= Snow.Cover.Extent.1)) + scale_fill_viridis() + ggtitle("Summer")
inverno <- ggplot() + geom_raster(data= winter_alps_cropped, mapping = aes(x=x, y=y, fill= Snow.Cover.Extent.2)) + scale_fill_viridis() + ggtitle("Winter")
estate/inverno

