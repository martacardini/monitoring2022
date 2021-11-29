# R code for chemical cycling study
# time series of NO2 change in Europe during covid 

#########################
### day 1 ## 26/11/21 ###
#########################

setwd("C:/lab/en")
library(raster)

# we used the brick function to import layers in one file only
# now we use the raster function to create a RasterLayer object, we now have single layers in many files

# what is the range of the data? 
# 0 to 255      # 8bit file     #radiometric resolution in remote sensing
# Shannon, 
# 1 bit -> 2^1 = 2 informations
# 2 bits -> 2^2 = 4 infos
# 8 bits -> 2^8 = 256 infos
# in the range the last is 255 because the first one is named 0

# import the first file
en01 <- raster("EN_0001.png")

#plot the NO2 values 
cl <- colorRampPalette(c('red','orange','yellow'))(100)
# can change the colors but yellow must be the maximum      # colorblind friendly
plot(en01, col = cl)

# Exercice: import the end of March NO2 and plot it
en13 <- raster("EN_0013.png")
plot (en13, col = cl)

# Exercice: build a multiframe 2 rows and 1 column with en01 and en13
par(mfrow=c(2,1))
plot( en01, col = cl)
plot( en13, col = cl)

# import all data
en01 <- raster("EN_0001.png")
en02 <- raster("EN_0002.png")
en03 <- raster("EN_0003.png")
en04 <- raster("EN_0004.png")
en05 <- raster("EN_0005.png")
en06 <- raster("EN_0006.png")
en07 <- raster("EN_0007.png")
en08 <- raster("EN_0008.png")
en09 <- raster("EN_0009.png")
en10 <- raster("EN_0010.png")
en11 <- raster("EN_0011.png")
en12 <- raster("EN_0012.png")
en13 <- raster("EN_0013.png")

# plot all data
# two ways to do that
# build a multiframe or build a stack
# multiframe 4x4

par(mfrow = c(4,4))
plot(en01, col = cl)
plot(en02, col = cl)
plot(en03, col = cl)
plot(en04, col = cl)
plot(en05, col = cl)
plot(en06, col = cl)
plot(en07, col = cl)
plot(en08, col = cl)
plot(en09, col = cl)
plot(en10, col = cl)
plot(en11, col = cl)
plot(en12, col = cl)
plot(en13, col = cl)

# to avoid doing that, use stack
EN <- stack(en01, en02, en03, en04, en05, en06,en07,en08, en09, en10, en11, en12, en13)
plot (EN, col = cl)

# plot only the first image using the name inside the stack
plot (EN$EN_0001, col = cl)

#rgb
plotRGB(EN, r=1, g=7, b=13, stretch ="lin")

# red = high values of NO2 in the first image
# green = high values of NO2 in the seventh image
# blue = high values of NO2 in the last image
# where we see yellow = constant values of NO2 during the three periods of time

#########################
### day 2 ## 29/11/21 ###
#########################

# import all data at the same time from the en folder
# we use lapply() function to apply a function to a list       # https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/lapply
# first step: build a list        # list.files()      # https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/list.files

library(raster)
setwd("C:/lab/en")

# pattern is the common part of all the files we want in the list. In that case it's the EN in the names
r_list <- list.files(pattern = "EN")
list_rast <- lapply(r_list, raster)
EN_stack <- stack (list_rast)

# we can plot all the images all together
cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot (EN_stack, col=cl)

# ex: plot only first image of the stack
plot (EN_stack$EN_0001, col=cl)

# processing the data
# differences between the final image and the first image
ENdif <- EN_stack$EN_0001 - EN_stack$EN_0013
cldif <- colorRampPalette(c('blue', 'white','red'))(100)
plot (ENdif, col = cldif)
# the red parts are the ones with the highest variability between the two images

# how to use someone's script without copy-pasting it
# automated processing source function      # https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/source
source("R_code_automatic_script.txt")

# pairs
pairs(EN)

