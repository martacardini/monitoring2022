# R code for uploading and visualizing Copernicus data in R 
install.packages("ncdf4")
library(ncdf4)
setwd("C:/lab/copernicus")

# import the copernicus data into R
snow20211214 <- raster("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
plot(snow20211214)
