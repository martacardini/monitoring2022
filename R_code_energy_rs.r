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
# plotRGB(l1992, r="defor1_.1", g="defor1_.2", b="defor1_.3", stretch="Lin")
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")


# defor1_.1 = NIR
# defor1_.2 = red
# defor1_.3 = green

# change colors
plotRGB(l1992, r=3, g=2, b=1, stretch="Lin")
plotRGB(l1992, r="defor1_.2", g="defor1_.1", b="defor1_.3", stretch="Lin")

# importing the data 
l2006 <- brick ("defor2_.jpg") # image from 2006

# plot RGB
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")

#plotting the images from 1992 and 2006 together
# par()
par(mfrow = c(2,1))   # 2 rows 1 column
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")

# to calculate the energy loss we subtract the red layer (low reflectance in the vegetation) to the NIR layer (hight reflectance in healthy vegetation).

# calculate the energy in 1992
dev.off
dvi1992 <- l1992$defor1_.1 - l1992$defor1_.2

# color Ramp Palette
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)

plot(dvi1992, col= cl)

# calculate energy in 2006
dvi2006 <- l2006$defor2_.1 - l2006$defor2_.2
plot(dvi2006, col = cl)

# plot both together
par(mfrow = c(2,1)) 
plot(dvi1992, col= cl)
plot(dvi2006, col = cl)

# the energy lost is shown in yellow because it's a color that catches our eyes

# calculate the loss of energy in the time scale
# differencing two images of energy in two different times

dvidif <- dvi1992 - dvi2006
# plot the result
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(dvidif, col= cld)

# red= high level of difference in which energy has been lost, passed from a high value in 1992 to a low value in 2006

# final plot: original images, dvis, final dvi differences.
par(mfrow = c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col= cl)
plot(dvi2006, col = cl)
plot(dvidif, col= cld)

# export the final result
pdf("energy.pdf", width = 13, height = 9)
par(mfrow = c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col= cl)
plot(dvi2006, col = cl)
plot(dvidif, col= cld)
dev.off()
