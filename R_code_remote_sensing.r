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

#day2 (05/11/2021)

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
par(mfrow=c(1,2)) ° the first number is the number of rows; the second number is the number of the columns
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# # plot both images in one multiframe graph with 2 rows, 1 column
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

