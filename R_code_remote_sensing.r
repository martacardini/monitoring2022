# R code for ecosystem monitoring by remote sensing
# first we need to download an additional R package

# links for download and package info:
# https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/install.packages
# https://cran.r-project.org/web/packages/raster/index.html

# install.packages("raster")

library(raster)

# use the brick function
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
# B4 is the reflectance in the near infrared (NIR) band

# colorRampPalette function: chances color we see
# https://www.rdocumentation.org/packages/dichromat/versions/1.1/topics/colorRampPalette

# 100 means the number pf tones we have in our palette
cl <- colorRampPalette(c("black", "grey", "light grey"))(100)
plot(l2011, col=cl)

# plotting the set of bands to see the image in colours
# https://www.rdocumentation.org/packages/raster/versions/3.5-2/topics/plotRGB

plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")

# -----------day2 (05/11/2021)

# we're gonna use the B4- NIR
# plot the green band B2
# the green band is called B2_sre, it is inside l2011

plot(l2011$B2_sre)

#let's change the color scheme with colorRampPalette function

colorRampPalette
cl <- colorRampPalette(c("black", "grey", "light grey"))(100)

# we can change the colors
clg <- colorRampPalette(c("dark green", "green", "light green"))(100)
plot(l2011$B2_sre, col=clg)

# do the same for the blue band B1_sre
clb <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(l2011$B1_sre, col=clb)

# how to plot the two bands together (one beside the other)
# we use the par function
# https://www.rdocumentation.org/packages/graphics/versions/3.6.2/topics/par
par(mfrow=c(1,2)) #1 row, 2 columns 
par(mfrow=c(2,2))

# plot both images in one multiframe graph with 1 row and 2 columns
par(mfrow=c(1,2)) # the first number is the number of rows; the second number is the number of the columns
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# plot both images in one multiframe graph with 2 rows, 1 column
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# ----------day 3
library(raster)
setwd("C:/lab")

l2011 <- brick("p224r63_2011.grd")

plot(l2011$B2_sre)
clb <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(l2011$B1_sre, col = clb)

clg <- colorRampPalette(c("dark green", "green", "light green"))(100)

# multiframe: blue band and green band besides
par(mfrow =c(1,2))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col= clg)

# invert the number of rows and columns
par(mfrow = c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# plot the first 4 bands with 2 rows and 2 columns

clr <- colorRampPalette(c("dark red", "red", "pink"))(100)
clnir <- colorRampPalette(c("red", "orange", "yellow"))(100)

par(mfrow= c(2,2))
plot(l2011$B1_sre, col= clb)
plot(l2011$B2_sre, col= clg)
plot(l2011$B3_sre, col= clr)
plot(l2011$B4_sre, col= clnir)

dev.off() #close the window in use 

# RGB

plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")  #natural colors (human view)

#plants have a NIR hight reflectance, we can remove a band (blue band) and compose the bands 

plotRGB(l2011, r=4, g=3, b=2, stretch="Lin") #false colors

# put NIR instead of the green
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")

# put NIR instead of the blue
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")

#multiframe
par(mfrow= c(2,2))
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")

# ------ day4 (last day 12/11/2021)

library(raster)
setwd("C:/lab")
l2011 <- brick("p224r63_2011.grd")
plotRGB(l2011, r=4, g=3, b=2, stretch= "Lin")

#stretch: to visualize data. 
#linear stretch # stretch="Lin"
#histogram stretch: like an integral # stretch="Hist" #enhances a lot the differences from one place to the other 

# importing past data
l1988 <- brick("p224r63_1988.grd")

#multiframe
par(mfrow= c(2,1))
plotRGB(l2011, r=4, g=3, b=2, stretch= "Lin")
plotRGB(l1988, r=4, g=3, b=2, stretch= "Lin")

#in 1988 the forest was there, and they started to build some streets and agriculture terrains.
#now the situation is dramatic.

#put NIR in the blue channel # if we do so, the agricultural areas become yellow (enlighten)
par(mfrow= c(2,1))
plotRGB(l2011, r=2, g=3, b=4, stretch= "Lin")
plotRGB(l1988, r=2, g=3, b=4, stretch= "Lin")
