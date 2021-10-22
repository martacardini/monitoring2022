# this is my first code in R

# here are the input data

# Costanza data on stream
water <- c(100,200,300,400,500)
water

# Marta data on fishes genomes
fishes <- c(10,50,60,100,200)
fishes

# plot the diversity of fishes [Y] versus the amount of water [X]

plot(water, fishes)

# the data with developed can be stored in a data
# a table in R is called data frame
# the fonction is data.frame

streams <-data.frame(water, fishes)
streams

# to visualise the table we use the fonction View 
View(streams)

# From now on, we are going to import and export data
# setting working directory (setwd fonction)

setwd("C:/lab/")

data.frame(water, fishes)

streams <-data.frame(water, fishes)

# let's export our table
# https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/write.table
write.table(streams, file = "my_first_table.txt")

# how to import a table into R
read.table("my_first_table.txt")
# let's assign it to an object into R
ducciotable <- read.table("my_first_table.txt")

# the first statistics 
# do a summary of the dataset
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/summary
summary(ducciotable)

#marta does not like water
# marta wants info only on fishes
summary(ducciotable$fishes)

# let's make an histogram
hist(ducciotable$fishes)
hist(ducciotable$water)

