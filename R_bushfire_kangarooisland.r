#R_bushfire_kangarooisland
setwd("/Users/alessandro/lab/bushfire/kangarooisland") #mac

#install.packages("raster")
#RStoolbox is a package for remote sensing image processing and analysis, such as calculating spectral indices, principal component transformation, unsupervised and supervised classification or fractional cover analyses.
#install.packages("RStoolbox")
#make use of the library
library(raster)
library(rgdal)
#from sentinel2
ki16122019 <- stack("L1C_T53HPA_A023408_20191216T004701.tif")
ki26122019 <- stack("L1C_T53HPA_A023551_20191226T004700.tif")
ki08012020 <- stack("L1C_T53HPA_A023737_20200108T005702.tif")
ki28012020 <- stack("L1C_T53HPA_A024023_20200128T005701.tif")

#seeing as human eye through:
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
par(mfrow=c(1,2))
plotRGB(ki16122019, r=3, g=2,b=1, stretch="Lin")
plotRGB(ki08012020, r=3, g=2,b=1, stretch="Lin")

#from Landsat8 .jpg
KI17122019 <- stack("LC08_L1TP_098085_20191208_20191217_01_T1.jpg")
KI14012020 <- stack("LC08_L1TP_098085_20200109_20200114_01_T1.jpg")
KI24022020 <- stack("LC08_L1TP_098085_20200210_20200224_01_T1.jpg")
KI09042020 <- stack("LC08_L1TP_098085_20200329_20200409_01_T1.jpg")
KI22042020 <- stack("LC08_L1TP_098085_20200414_20200422_01_T1.jpg")
KI09052020 <- stack("LC08_L1TP_098085_20200430_20200509_01_T1.jpg")
KI27052020 <- stack("LC08_L1TP_098085_20200516_20200527_01_T1.jpg")

#seeing as human eye through:
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
par(mfrow=c(4,2))
plotRGB(KI17122019, r=3, g=2,b=1, stretch="Lin")
plotRGB(KI14012020, r=3, g=2,b=1, stretch="Lin")
plotRGB(KI24022020, r=3, g=2,b=1, stretch="Lin")
plotRGB(KI09042020, r=3, g=2,b=1, stretch="Lin")
plotRGB(KI22042020, r=3, g=2,b=1, stretch="Lin")
plotRGB(KI09052020, r=3, g=2,b=1, stretch="Lin")
plotRGB(KI27052020, r=3, g=2,b=1, stretch="Lin")

#from Landsat8 .tiff
<- stack("LC08_L1TP_098085_20200109_20200114_01_T1_B1.TIF")

