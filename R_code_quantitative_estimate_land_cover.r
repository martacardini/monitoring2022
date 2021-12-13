# R_code_quantitative_estimate_land_cover.r
# mato grosso

library(raster)
library(RStoolbox) 
library(ggplot2)

setwd("C:/lab")
 
# import the images with all the layers at the same time # brick but to import all the images at the same time #lapply
# first list all the files with a common pattern
# second make a stack

# 03/12/2021

# forests grow up till a certain equilibrium, but man cut it down first

library(raster)
library(ggplot2)
# library(gridExtra)
library (RStoolbox) # tools for remote sensing data analysis

# brick to import every layer of every image (brick import all layer of an image together)
# to import a lot of images -> lapply function

# 1. list the files available
rlist <- list.files(pattern = "defor") # images with 3 layers: NIR, red, green
rlist

# 2. apply a function to a list
list_rast <- lapply(rlist, brick)
list_rast

# plotting a single image with all 3 different layers (first one)
plot(list_rast[[1]])

# plotting in RGB space with NIR=1, red=2, green=3
plotRGB(list_rast[[1]], r=1, g=2, b=3, stretch = "Lin")
# easier to read with short and meaningful name
l1992 <- list_rast[[1]]
plotRGB(l1992, r=1, g=2, b=3, stretch = "Lin")
# plotting second image
l2006 <- list_rast[[2]]
plotRGB(l2006, r=1, g=2, b=3, stretch = "Lin")

# estimate amount of forest destroied
# unsupervied classification, we tell to the softeare the numeber of classes we want in the end  
# https://www.rdocumentation.org/packages/RStoolbox/versions/0.2.6/topics/unsuperClass
# take the pixels and look if there are meaningful groups
l1992c <- unsuperClass(l1992, nClasses=2)
l1992c # only 2 values -> one forest and one agricultural land
# plotting the map
# agricuktural land + water = value 2
# forest = value 1
# continuous legend but valus bw 1 and 2 not expressed
plot(l1992c$map)

# persentage of forest/agricultural area (number of pixels)
# frequences of our map (values with small differences bc iterative process)
freq(l1992c$map)
# agricuktural land + water = 36313 (class 2)
# forest = 304979 (class 1)
total <- 341292 # tot amount of pixels -> run l1992c -> look at tird value of dimension (ncell)
# compute percentage of different land uses
propagri <- 36313/total
propforest <- 304979/total
propagri    # 0.1063986 -> 11%
propforest  # 0.8936014 -> 89%

# building a dataframe with type of cover and proportion of pixels
cover <- c("Forest", "Agriculture")
prop1992 <- c(0.8936014, 0.1063986)
proportion1992 <- data.frame(cover, prop1992) # proportion of pixels in 1992
proportion1992 # quantitative data

# plotting data with ggplot2
# ggplot function -> first argument = dataset, other arguments = aesthetic, color stored in cover
# geom_bar function explainig type of graph
# stat - statistics used, identity bc we're using data as they are (no median or mean)
ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")


####################
### 06/12/2021######
####################


library(raster)
library(RStoolbox) 
library(ggplot2)

setwd("C:/lab")

# make a list with the files with a common pattern
rlist <- list.files(pattern = "defor")

# apply a function to all the files in the list
list_rast <- lapply(rlist, brick)

# use simple names to identify the objects in the list
l1992 <- list_rast[[1]]
l2006 <- list_rast[[2]]

# plotRGB
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

# unsupervised classification
l1992c <- unsuperClass(l1992, nClasses=2) # unsuperClass(x, nClasses)

# we pass from a map with a spectrum of values to one with only two classes
plot(l1992c$map)

# 1 = agriculture and water
# 2 = forest

# how to calculate the frequency of the data
freq(l1992c$map)

#      value  count   ## numbers of pixels for each class
# [1,]     1  33698   ## agriculture
# [2,]     2 307594   ## forest

# total number of pixels = 341292

# calculate the proportion between the classes and the total

total <- 341292 
propagri <- 33698/total
propforest <- 307594/total

# building a dataframe with type of cover and proportion of pixels
cover <- c("Forest", "Agriculture")
prop1992 <- c(propforest, propagri)

# build the data frame based on the variables and the proportions
proportion1992 <- data.frame(cover, prop1992)
ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")

# repeat the same for the second image

# plotRGB
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# unsupervised classification
l2006c <- unsuperClass(l2006, nClasses=2) # unsuperClass(x, nClasses)

# 1 = agriculture and water # white
# 2 = forest                # green

plot(l2006c$map)

freq(l2006c$map)
#      value  count
# [1,]     1 164177    # agriculture and water
# [2,]     2 178549    # forest

total2006 <- 342726 
propagri2006 <- 164177/total2006
propforest2006 <- 164177/total2006

prop2006 <- c(propagri2006, propforest2006)
proportion <- data.frame(cover, prop1992, prop2006)
proportion2006 <- data.frame(cover, prop2006)

#ggplot
# 1992
ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")

# 2006
ggplot(proportion2006, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")

# to put the 2 histograms one besides the others we use the package
library(gridExtra)
# we use the function grid.arrange ## https://cran.r-project.org/web/packages/gridExtra/vignettes/arrangeGrob.html

# 1. assign a name to each ggplot
# p1 <- ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")
# p2 <- ggplot(proportion2006, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")

# 2. use grid.arrange
# grid.arrange (p1, p2, nrow = 1)

# ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)
# ggplot(proportion, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)



#################day 3 ############## 
#####13/12/2021########
p1 <- ggplot(proportion, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)
p2 <- ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)

grid.arrange (p1, p2, nrow = 1) # to put the two graphs besides
grid.arrange (p1, p2, nrow = 2) # to put one graph on top of the other

# or use the patchwork package
p1+p2 # to put the two graphs besides
p1/p2 # to put one graph on top of the other

# patchwork is working even with raster data, but only from ggplot2
# instead of using plotRGB we are going to use ggRGB
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

ggRGB(l1992, r=1, g=2, b=3)
# different types of stretch 
gp1 <- ggRGB(l1992, r=1, g=2, b=3, stretch= "lin")
gp2 <-ggRGB(l1992, r=1, g=2, b=3, stretch= "hist") # we can see the lines of the scanner that took the picture (not a photo!)
gp3 <- ggRGB(l1992, r=1, g=2, b=3, stretch= "sqrt") # should compact the data, sqrt of the original data -> compact the data
gp4 <- ggRGB(l1992, r=1, g=2, b=3, stretch= "log")

(gp1|gp2|gp3|gp4)
gp1 + gp2+ gp3 + gp4

# multitemporal patchwork
gp1 <- ggRGB(l1992, r=1, g=2, b=3)
gp5 <- ggRGB(l2006, r=1, g=2, b=3)
gp1+gp5
gp1/gp5
