> # R_code_quantitative_estimate_land_cover.r
> # mato grosso
> library(raster)

> setwd("C:/lab")
> 
> # import the images with all the layers at the same time # brick but to import all the images at the same time #lapply
> # first list all the files with a common pattern
> # second make a stack
> 
> rlist <- list.files(pattern= "defor")
> rlist
[1] "defor1_.jpg" "defor2_.jpg"
> 
> list_rast <- lapply(rlist, brick)
> 
> 
> list_rast
[[1]]
class      : RasterBrick 
dimensions : 478, 714, 341292, 3  (nrow, ncol, ncell, nlayers)
resolution : 1, 1  (x, y)
extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : defor1_.jpg 
names      : defor1_.1, defor1_.2, defor1_.3 
min values :         0,         0,         0 
max values :       255,       255,       255 


[[2]]
class      : RasterBrick 
dimensions : 478, 717, 342726, 3  (nrow, ncol, ncell, nlayers)
resolution : 1, 1  (x, y)
extent     : 0, 717, 0, 478  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : defor2_.jpg 
names      : defor2_.1, defor2_.2, defor2_.3 
min values :         0,         0,         0 
max values :       255,       255,       255 


> plot(list_rast[[1]])
> plotRGB(list_rast[[1]], r=1, g=2, b=3)
> plotRGB(list_rast[[1]], r=1, g=2, b=3, stretch = lin)
Errore in .local(x, ...) : oggetto 'lin' non trovato
> plotRGB(list_rast[[1]], r=1, g=2, b=3, stretch = "lin")
> l2006 <- list_rast[[2]]
> plotRGB(l2006, r=1, g=2, b=3, stretch="lin")
> library(RStoolbox)
Messaggio di avvertimento:
il pacchetto ‘RStoolbox’ è stato creato con R versione 4.1.2 
> l1992c <- unsuperClass(l1992, nClasses=2)
Errore in h(simpleError(msg, call)) : 
  errore durante la valutazione dell'argomento 'x' nella selezione di un metodo per la funzione 'ncell': oggetto 'l1992' non trovato
> l1992 <- list_rast[[1]]
> l1992c <- unsuperClass(l1992, nClasses=2)
> l1192c
Errore: oggetto 'l1192c' non trovato
> l1992c
unsuperClass results

*************** Map ******************
$map
class      : RasterLayer 
dimensions : 478, 714, 341292  (nrow, ncol, ncell)
resolution : 1, 1  (x, y)
extent     : 0, 714, 0, 478  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : memory
names      : layer 
values     : 1, 2  (min, max)

> plot(l1992c$map)
> 
> freq(l1992c$map)
     value  count
[1,]     1 305547
[2,]     2  35745
> total
Errore: oggetto 'total' non trovato
> total <- 341292 # total number of pixels
> propagri <- 35745/341292
> propforest <- 305547/341292
> propagri
[1] 0.1047344
> propagri <- 35745/total
> propforest <- 305547/total
> propagri
[1] 0.1047344
> propforest
[1] 0.8952656
> 
> cover <- c("Forest", "Agriculture")
> prop1992 <- c(0.8952656, 0.1047344)
> 
> proportion1992 <- data.frame(cover, prop1992)
> proportion1992
        cover  prop1992
1      Forest 0.8952656
2 Agriculture 0.1047344
> library(ggplot2)
Messaggio di avvertimento:
il pacchetto ‘ggplot2’ è stato creato con R versione 4.1.2 
> 
> ggplot(proportion1992, aes (x = cover, y = prop1992, color = cover)) + geom_bar(stat="identity", fill= "white")
> 
