# R_code_bushfire.r
#1st set the working directory to the folder snow in the folder lab instead of the usual setwd("/Users/alessandro/lab")
#we create a folder within the folder lab because we will use the function lapply() to search files that comprehend the name within the folder.
#in this case we don't have other files named snow but it's better to know this
setwd("/Users/alessandro/lab/bushfire")

#we will use raster library and ncdf4(interface with netcdf data, some sort of .tif). Since most of the copernicus are based on nCDF we need to import this library (sometimes is comprehended in raster).
#once installed we can launch the libraries in R

library(raster)
library(rgdal)

# open raster layer
tassiefirst <- raster("Hansen_GFC-2019-v1.7_first_40S_140E.tif")
tassielast <- raster("Hansen_GFC-2019-v1.7_last_40S_140E.tif")
tassietreecover2000 <- raster("Hansen_GFC-2019-v1.7_treecover2000_40S_140E.tif")
tassielossyear <- raster("Hansen_GFC-2019-v1.7_lossyear_40S_140E.tif")

# plot Tassie GFC (Global Forest Change)
plot(tassielossyear, col = rev(terrain.colors(50)))

# import the vector boundary
crop_extent <- readOGR("TAS_STATE_POLYGON_shp.shp")

# plot imported shapefile
# use add = T to add a layer on top of an existing plot
plot(crop_extent,main = "Shapefile imported into R - crop extent",axes = TRUE,border = "blue")

# crop the lidar raster using the vector extent
tassielossyear_crop <- crop(tassielossyear, crop_extent)
plot(tassielossyear_crop, main = "Cropped Tasmanian Vegetation Loss")

# add shapefile on top of the existing raster
plot(crop_extent, add = TRUE)

cl<-colorRampPalette(c("red","olive","light yellow"))(100)  
par(mfrow=c(2,2))
plot(tassiefirst_crop, col=cl)
plot(tassielast_crop, col=cl)



