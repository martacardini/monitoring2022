# R code for uploading and visualizing Copernicus data in R 
install.packages("ncdf4")
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
