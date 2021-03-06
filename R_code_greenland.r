# ice melt in Greenland
# proxy: LST (Land Surface Temperature)

library(raster)
library(ggplot2)
library(RStoolbox)
library(patchwork)
library(viridis)

# setting the working directory
setwd("C:/lab/greenland")

# list the files
rlist <- list.files(pattern = "lst")
import <- lapply(rlist, raster)

#make a stack : all files together
tgr <- stack (import)

# plot the stack with custom palette
cl <- colorRampPalette (c("blue","light blue","pink", "yellow"))(100)
plot(tgr, col = cl)

# ggplot the first and last images: 2000 vs 2015
# 2000
p1 <- ggplot() + 
geom_raster (tgr$lst_2000, mapping=aes(x=x, y=y, fill=lst_2000 )) + 
scale_fill_viridis( option = "magma") + ggtitle ("LST in 2000")

# 2015
p2 <- ggplot() + 
geom_raster (tgr$lst_2015, mapping=aes(x=x, y=y, fill=lst_2015 )) + 
scale_fill_viridis( option = "magma") + ggtitle ("LST in 2015")

# plotting the frequency distribution using an histogram
par(mfrow=c(1,2))
hist(tgr$lst_2000)
hist(tgr$lst_2015)      # this distribution has an anomaly because it has 2 peaks, one of which in the higher temperature

# all of them
par(mfrow=c(2,2))
hist(tgr$lst_2000)
hist(tgr$lst_2005)
hist(tgr$lst_2010)
hist(tgr$lst_2015)

plot(tgr$lst_2010, tgr$lst_2015, xlim=c(12500, 15000), ylim=c(12500, 15000))
abline(0, 1, col="red")

# make a plot with all the histograms and regressions for all the data
par(mfrow=c(3,4))
hist(tgr$lst_2000)
hist(tgr$lst_2005)
hist(tgr$lst_2010)
hist(tgr$lst_2015)
plot(tgr$lst_2010, tgr$lst_2015, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(tgr$lst_2005, tgr$lst_2015, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(tgr$lst_2000, tgr$lst_2015, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(tgr$lst_2010, tgr$lst_2005, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(tgr$lst_2000, tgr$lst_2005, xlim=c(12500, 15000), ylim=c(12500, 15000))
plot(tgr$lst_2010, tgr$lst_2000, xlim=c(12500, 15000), ylim=c(12500, 15000))

# or do the same with the pairs() function
pairs(tgr)
# histograms of frequency distribution
# 
