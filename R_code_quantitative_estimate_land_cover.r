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
library(gridExtra)
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
