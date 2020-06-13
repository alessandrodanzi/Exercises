setwd("/Users/alessandro/lab/bushfire/kangarooisland") #mac

#install.packages("raster")
#RStoolbox is a package for remote sensing image processing and analysis, such as calculating spectral indices, principal component transformation, unsupervised and supervised classification or fractional cover analyses.
#install.packages("RStoolbox")
#make use of the library
library(raster)
library(sp)
library(rgdal)

rlist <- list.files(pattern="LC08_L1TP_098085_20200109_20200114_01_T1_")
#rlist to see the files within it
#we can now make the stack function to connect the images on layers
#RGB
KI14012020_r <- raster("LC08_L1TP_098085_20200109_20200114_01_T1_B4.TIF")
KI14012020_g <- raster("LC08_L1TP_098085_20200109_20200114_01_T1_B3.TIF")
KI14012020_b <-raster("LC08_L1TP_098085_20200109_20200114_01_T1_B2.TIF")
KI14012020_ir <-raster("LC08_L1TP_098085_20200109_20200114_01_T1_B5.TIF")
KI14012020_nir <-raster("LC08_L1TP_098085_20200109_20200114_01_T1_B8.TIF")
KI14012020_swir <-raster("LC08_L1TP_098085_20200109_20200114_01_T1_B11.TIF")

KI14012020_RGB<- stack(c(KI14012020_r, KI14012020_g, KI14012020_b,KI14012020_ir,KI14012020_nir,KI14012020_swir))
#i cannot do it because KI14012020_nir has different extent from the rest
KI14012020_nir <- resample(KI14012020_nir, KI14012020_ir)
KI14012020_RGB<- stack(c(KI14012020_r, KI14012020_g, KI14012020_b,KI14012020_ir,KI14012020_nir,KI14012020_swir))
#now it works 


#B1 red
#B2 green
#B3 blue
#B4 infrared
#B5 NIR
#B6 SWIR

#three plots highlighting different things (human eye, vegetation, burnt area)
par(mfrow=c(3,1))
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
#as the human eye see it
plotRGB(KI14012020_RGB,1,2,3, stretch="lin")
#highlighting vegetation in red
plotRGB(KI14012020_RGB,4,1,2, stretch="lin")
#highlight the burnt area
plotRGB(KI14012020_RGB,6,5,1, stretch="lin")


###################################################


#NDVI
KI14012020_NDVI<-stack(c(KI14012020B4, KI14012020B5))


#the SHP file
###xp <- raster("M145.tif") 
shp <- shapefile("LANDSCAPE_Biophysical_L3LandZones_GDA2020")

proj4string(KI14012020)
proj4string(shp)

shp <- spTransform(shp, proj4string(KI14012020)) 

plot(KI14012020)
  plot(shp, add=T)

KI14012020 <- mask(crop(KI14012020, extent(shp)), shp)  

plot(KI14012020)
  plot(shp, add=T)
