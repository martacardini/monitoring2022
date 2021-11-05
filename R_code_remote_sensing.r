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






