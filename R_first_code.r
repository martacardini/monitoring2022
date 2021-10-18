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
