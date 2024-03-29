# R code for my Monitoring Ecosystem Changes and Functioning exam - AY 2021-2022


# in July 2021 Sadinia (Montiferru, north of Oristano) was devastated by wildfires.
# in this project I want to assess how the vegetation cover in the affected area was influenced by that.
# I used data downloaded from the Copernicus Global Land Service          # https://land.copernicus.eu/global/

# Install the packages needed for the analysis

# install.packages("raster")
# install.packages("ncdf4") 
# install.packages("viridis") 
# install.packages("RStoolbox")
# install.packages("ggplot2")
# install.packages("grid.Extra")
# install.packages("patchwork")


# Load the downloaded packages into R

library(raster) # work with raster file (single layer data)
library(ncdf4) # import the copernicus file (in nc)
library(viridis) # plot the color palette
library(RStoolbox) # useful for remote sensing image processing (make classification)
library(ggplot2) # create graphics - ggplot function
library(grid.Extra) # for multiframe ggplot
library(patchwork) # multiframe graphics

# Setting the working directory

setwd("C:/lab/exam")

######## FIRST STEP: Analysis of the FCOVER #############

# FCOVER: Fraction of vegetation cover --> the fraction of ground covered by green vegetation/ the spatial extent of the vegetation.
# Using Copernicus data: FCOVER 300m V1 - Sentinel-3/OLCI, PROBA-V

# Assessing how it changed from 2020 (before the fires) to 2021 (after the fires)

# the data I downloaded:
# c_gls_FCOVER300-RT2_202010200000_GLOBE_OLCI_V1.1.1     # FCOVER from 11/08/2020 to 20/08/2020
# c_gls_FCOVER300-RT0_202108200000_GLOBE_OLCI_V1.1.2     # FCOVER from 11/08/2021 to 20/08/2021 

# import the FCOVER data for august 2020 from the "exam" folder
sum2020 <- raster ("c_gls_FCOVER300-RT2_202010200000_GLOBE_OLCI_V1.1.1.nc")  # create a RasterLayer

# visualize the imported image
plot(sum2020)  # the FCOVER at global scale in 2020
dev.off()

# crop the extension of Sardinia using the crop() function
# longitude from 7 to 11
# latitude from 38 to 42
extSAR <- c(7, 11, 38, 42)
fcover_sar20 <- crop(sum2020, extSAR)
plot(fcover_sar20)

# the fires were concentrated in the Montiferru/Oristanese region on the West coast
# crop the area interested by the 2021 wildfires
extor <- c(8.2, 9.2, 39.7, 40.6)   # vector containing the coordinates of the area
oristano20 <- crop(sum2020, extor)
plot(oristano20)

# do the same for FCOVER of august 2021
sum2021 <- raster ("c_gls_FCOVER300-RT0_202108200000_GLOBE_OLCI_V1.1.2.nc")

# crop the extension of Sardinia
extSAR <- c(7, 11, 38, 42)
fcover_sar21 <- crop(sum2021, extSAR)
plot(fcover_sar21)

# crop the wildfires hotspot extension 
extor <- c(8.2, 9.2, 39.7, 40.6)
oristano21 <- crop(fcover_sar21, extor)
plot(oristano21)

# plot the 2 maps together
par(mfrow = c(2,1))   # 2 rows, 1 column
plot(oristano20, main = ("FCOVER in august 2020"))
plot(oristano21, main = ("FCOVER in august 2021"))
dev.off()

# export it in PNG format in the output folder
png(file="outputs/FCOVER_Oristano_20-21_plot.png", units="cm", width=20, height=30, res=600)
par(mfrow = c(2,1))
plot(oristano20, main = ("FCOVER in august 2020"))
plot(oristano21, main = ("FCOVER in august 2021"))
dev.off()

# make a ggplot and use the package Viridis to change the colors
# Viridis palettes are colorblind friendly

# ggplot 2020 data, assign it to the object p1
p1 <- ggplot(data = oristano20) + 
geom_raster (data = oristano20, mapping = aes(x=x, y=y, fill = Fraction.of.green.Vegetation.Cover.333m )) + 
scale_fill_viridis() + ggtitle ("FCOVER summer 2020 ")

# ggplot 2021 data, assign it to the object p2
p2 <- ggplot(data = oristano21) + 
geom_raster (data = oristano21, mapping = aes(x=x, y=y, fill = Fraction.of.green.Vegetation.Cover.333m )) + 
scale_fill_viridis() + ggtitle ("FCOVER summer 2021")

# plot the 2 maps together into 2 rows and 1 column using Patchwork
p1/p2

# export this image in PNG format in the output folder
png(file="outputs/FCOVER_Oristano_20-21.png", units="cm", width=25, height=30, res=600)
p1 / p2
dev.off()


# calculate the difference between 2020 and 2021
fcover_diff <- oristano20 - oristano21

# create a custom color palette using the function colorRampPalette
cldiff <- colorRampPalette(c("green", "yellow", "red"))(100)

# plot
plot(fcover_diff, col = cldiff)

# in red we observe the maximum differece, the areas where we had the greatest loss in vegetation cover.

# export in PNG format
png(file="outputs/FCOVER_difference_2020-2021.png", units="cm", width=25, height=30, res=600)
plot(fcover_diff, col = cldiff)
dev.off()


# let's see if the situation changed in summer 2022
# using data from the beginning of august     # c_gls_FCOVER300-RT1_202208100000_GLOBE_OLCI_V1.1.2.nc    #data from 01/08/2022 to 10/08/2022

# import all the FCOVER files together
# pattern -> a common part in the names of the files. Only files containing the characters will be imported
fcover_list <- list.files(pattern = "FCOVER300") 

# apply raster function to all the files in the list 
fcover_raster <- lapply(fcover_list, raster) 

# make a stack with the raster
# A RasterStack is a collection of RasterLayer objects with the same spatial extent and resolution
fcover_stack <- stack(fcover_raster)

# crop the extension of Oristanese region
fcover_or <- crop(fcover_stack, extor)
fcover_or 
# rename the layers 
names(fcover_or) <- c("AUG_2021", "AUG_2022", "AUG_2020")

# plot the stack with custom palette
cl <- colorRampPalette (c("brown", "yellow", "#009900"))(100)
plot(fcover_or, col = cl, main = c("AUG 2021", "AUG 2022", "AUG 2020"))

# export this image in PNG format in the output folder
png(file="outputs/FCOVER_Oristano_20-21-22.png", units="cm", width=25, height=30, res=600)
plot(fcover_or, col = cl, main = c("AUG 2021", "AUG 2022", "AUG 2020"))
dev.off()

# plotting the frequency distribution of FCOVER values in 2020 and 2021 using histograms
par(mfrow=c(1,2))
hist(fcover_or$AUG_2020,            # using $ operator to extract the layer AUG_2020
  xlab = "FCOVER values in 2020", 
  ylab = "frequency", 
  xlim = c(0, 1), ylim = c(0, 20000))
hist(fcover_or$AUG_2021, 
  xlab = "FCOVER values in 2021", 
  ylab = "frequency", 
  xlim = c(0, 1), ylim = c(0, 20000))
dev.off()

# export as PNG
png(file="outputs/FCOVER_frequencies_2020-2021.png", units="cm", width=40, height=40, res=600)
par(mfrow=c(1,2))
hist(fcover_or$AUG_2020, xlab = "FCOVER values in 2020", ylab = "frequency", xlim = c(0, 1), ylim = c(0, 20000))
hist(fcover_or$AUG_2021, xlab = "FCOVER values in 2021", ylab = "frequency", xlim = c(0, 1), ylim = c(0, 20000))
dev.off()

# make a scatterplot 
plot(fcover_or$AUG_2020, fcover_or$AUG_2021, 
    pch =20, col = "blue", 
    xlab = "FCOVER in 2020", ylab = "FCOVER in 2021")
dev.off()

#export as PNG
png(file="outputs/FCOVER_scatterplot_2020-2021.png", units="cm", width=40, height=40, res=600)
plot(fcover_or$AUG_2020, fcover_or$AUG_2021, pch =20, col = "blue", xlab = "FCOVER in 2020", ylab = "FCOVER in 2021")
dev.off()

# we can have the frequency and regression lines all together automatically with the function pairs()
pairs(fcover_or)


##### quantitative analysis of the loss in vegetation cover ####
# unsupervised classification 
# using the function unsuperClass from RStoolbox package --> for Raster data

aug20 <- unsuperClass(oristano20, nClasses=2)
aug20     
#see the details -> we have only 2 classes now 
# class 2: low vegetation cover 
# class 1: high vegetation cover
plot(aug20$map)

aug21 <- unsuperClass(oristano21, nClasses=2)
aug21
plot(aug21$map)

# we can plot the unsupervised classification together with the original map to visualise the correspondance of 
  # part of the burned area with the #2 value 
  # the vegetation with the #1 value

par(mfrow=c(2,2)) # 2 rows and 2 columns
plot(aug20$map, main = "August 2020")
plot(oristano20, col = cl, main = "FCover August 2020")
plot(aug21$map, main = "August 2021")
plot(oristano21, col = cl, main = "FCover August 2021")
dev.off()

#save as PNG
png(file="outputs/Unsupervised_class_20-21.png", units="cm", width=25, height=30, res=600)
par(mfrow=c(2,2))
plot(aug20$map, main = "August 2020")
plot(oristano20, col = cl, main = "FCover August 2020")
plot(aug21$map, main = "August 2021")
plot(oristano21, col = cl, main = "FCover August 2021")
dev.off()

# measure of the percentage of vegetation and burned area (number of pixels)
# calculate the frequencies of our map for august 2020

freq(aug20$map)
aug20       # observe ncell to have the total number of pixels

#class 1 = 54975       # high vegetation land
#class 2 = 21619       # low vegetation land
# NA = 24878     # the sea
# total = ncell-NA = 101472 - 24878 = 76594

total2020 <- 76594 #the total amount of pixels

# compute percentage of land with different vegetation cover

propburned20 <- 21619/total2020  # class 2
propveg20 <- 54975/total2020     # class 1

propburned20
# 0.2822545 --> 28%         # class 2 -> % of low vegtation
propveg20
# 0.7177455 --> 72%         # class 1 -> % of high vegetation

# building a dataframe with type of cover and proportion of pixels
cover <- c("Vegetation", "No vegetation")
prop2020 <- c(0.7177455, 0.2822545)
proportion2020 <- data.frame(cover, prop2020) # proportion of pixels in 2020
proportion2020 # quantitative data

# plotting data with ggplot2
# ggplot function -> first argument = dataset, other arguments = aesthetic, color stored in cover
# geom_bar function explainig type of graph -> barplot
# stat - statistics used, identity bc we're using data as they are (no median or mean)

ggplot(proportion2020, aes(x=cover, y=prop2020, color=cover)) + geom_bar(stat="identity", fill="white")


# calculate the frequencies of our map for august 2021
freq(aug21$map)
aug21

#1 = 26667   # high veg
#2 = 44594   # low veg
#NA = 30211 --> the sea
# total = ncell-NA = 101472 - 30211 = 71261

total2021 <- 71261

# compute percentage of land with different vegetation cover
propburned21 <- 44594/total2021     # class 2 
propveg21 <- 26667/total2021        # class 1

propburned21
# 0.6257841 = 63%
propveg21
# 0.3742159 = 37%

# building a dataframe with type of cover and proportion of pixels
cover <- c("Vegetation", "No vegetation")
prop2021 <- c(0.3742159, 0.6257841)
proportion2021 <- data.frame(cover, prop2021) # proportion of pixels in 2021
proportion2021

# plotting data with ggplot2

ggplot(proportion2021, aes(x=cover, y=prop2021, color=cover)) + geom_bar(stat="identity", fill="white")

# put the 2 barplots together using Patchwork package
h2020 <- ggplot(proportion2020, aes(x=cover, y=prop2020, color=cover)) + 
         geom_bar(stat="identity", fill="white") + ylim(0,1)
h2021 <- ggplot(proportion2021, aes(x=cover, y=prop2021, color=cover)) + 
         geom_bar(stat="identity", fill="white") + ylim(0,1)
         
h2020 + h2021     # 1 row, 2 columns

# to do the same thing we can also use the function grid.arrange from gridExtra package
# grid.arrange (h2020, h2021, nrow = 1)

# export as PNG
png(file="outputs/Proportions_land20-21.png", units="cm", width=50, height=30, res=600)
h2020 + h2021
dev.off()


##### Analysis of Land surface temperature - LST - during the fires

# using Land Surface Temperature - 10-daily LST Daily Cycle Global V1 from Copernicus - 5km 

# c_gls_LST10-DC_202007210000_GLOBE_GEO_V1.2.1 data from 21/07/2020 to 31/07/2020
# c_gls_LST10-DC_202107210000_GLOBE_GEO_V2.0.1 data from 21/07/2021 to 31/07/2021   # part of the period in which the Montiferru forest was burning


# import the data from 2020
LST20 <- raster("c_gls_LST10-DC_202007210000_GLOBE_GEO_V1.2.1.nc")

# crop to the area of sardinia
# extSAR <- c(7, 11, 38, 42)

LST20_sar <- crop(LST20, extSAR)
plot(LST20_sar)

# crop to the area of the region under study
# extor <- c(8.2, 9.2, 39.7, 40.6)
LST20_or <- crop(LST20, extor)

plot(LST20_or)


# import data from 2021 
LST21 <- raster("c_gls_LST10-DC_202107210000_GLOBE_GEO_V2.0.1.nc")

# crop to the area of sardinia
# extSAR <- c(7, 11, 38, 42)

LST21_sar <- crop(LST21, extSAR)
plot(LST21_sar)

# crop to the area of the region under study
# extor <- c(8.2, 9.2, 39.7, 40.6)
LST21_or <- crop(LST21, extor)

plot(LST21_or)
 
# create a custom color ramp palette
cl_lst <- colorRampPalette(c("Black", "Red", "Pink")) (100)

# plot the 2 maps together using the color ramp palette
par(mfrow = c(1,2))
plot(LST20_or, col = cl_lst, main = "LST in Montiferru, July 2020")
plot(LST21_or, col = cl_lst, main = "LST in Montiferru, July 2021")
dev.off()

# ggplot the data
# using Viridis to change the palette -> option MAGMA

# 2020
pt1 <- ggplot() + geom_raster (LST20_or, mapping=aes(x=x, y=y, fill=Fraction.of.Valid.Observations )) + 
       scale_fill_viridis( option = "magma") + ggtitle ("LST in 2020")

# 2021
pt2 <- ggplot() + geom_raster (LST21_or, mapping=aes(x=x, y=y, fill=Fraction.of.Valid.Observations )) + 
       scale_fill_viridis( option = "magma") + ggtitle ("LST in 2021")

#plot the 2 images together using Patchwork
pt1/pt2

# export as PNG
png(file="outputs/LST_2020-2021.png", units="cm", width=30, height=50, res=600)
pt1/pt2
dev.off()

# lets plot the Fcover and the LST data together using Patchwork
(p1 | p2) / (pt1 | pt2)  # 2 rows and 2 columns

# export this image
png(file="outputs/LST_Fcover_2020-2021.png", units="cm", width=60, height=40, res=600)
(p1 | p2) / (pt1 | pt2)
dev.off()

# Measure the difference in LST from 2020 to 2021
diff_LST <- LST20_or - LST21_or
plot(diff_LST, col = cldiff, main = "Difference in LST - 2020-2021")

#export as PNG file
png(file="outputs/LST_diff_2020-2021.png", units="cm", width=40, height=40, res=600)
diff_LST <- LST20_or - LST21_or
plot(diff_LST, col = cldiff, main = "Difference in LST - 2020-2021")
dev.off()

# we observe that the maximum difference (in red) corresponds to the area of the Montiferru forest

# plotting the frequency distribution of LST values using histograms
par(mfrow=c(1,2))
hist(LST20_or, xlab = "LST values in 2020", ylab = "frequency", xlim = c(0.5, 1), ylim = c(0, 300))
hist(LST21_or, xlab = "LST values in 2021", ylab = "frequency", xlim = c(0.5, 1), ylim = c(0, 300))
dev.off()

# export as PNG
png(file="outputs/LST_frequencies_2020-2021.png", units="cm", width=40, height=40, res=600)
par(mfrow=c(1,2))
hist(LST20_or, xlab = "LST values in 2020", ylab = "frequency", xlim = c(0.5, 1), ylim = c(0, 300))
hist(LST21_or, xlab = "LST values in 2021", ylab = "frequency", xlim = c(0.5, 1), ylim = c(0, 300))
dev.off()

# compute scatterplot 
plot(LST20_or, LST21_or, pch =19, cex = 1.5, col = "blue", xlab = "LST in 2020", ylab = "LST in 2021")
dev.off()

# export as PNG
png(file="outputs/LST_scatterplot_2020-2021.png", units="cm", width=30, height=30, res=600)
plot(LST20_or, LST21_or, pch =19, cex = 1.5, col = "blue", xlab = "LST in 2020", ylab = "LST in 2021")
dev.off()



## We can also import the files all together using list.files
# LST_list <- list.files(pattern = "LST")
# LST_raster <- lapply (LST_list, raster) # apply raster function to all the files in the list
# LST_stack <- stack(LST_raster) # make a RasterStack
# LST_stack

# LST_or <- crop(LST_stack, extor)  # crop the stack to the extension of the area under study
# names(LST_or) <- c("AUG_2020", "AUG_2021") # change the names of the layers of the stack

## stats
# plot(LST_or$AUG_2020, LST_or$AUG_2021)
# pairs(LST_or)  
####### END
