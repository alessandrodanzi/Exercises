#R_Project_monitoring_ecosystems
#climate change is acting as fast modification in the ecosystems.
#Higher temperatures are melting the snow and giving more space to the vegetation to grow direction north.
#The albedo of the snow is higher then the one of the grass that is higher than the one of the trees
#We would expect, during the years, a reduction in the albedo, with a progressively movement of the line of the vegetation going towards the Arctic
setwd("/Users/alessandro/lab/climatechange")
library(raster)
library(ncdf4)


albedojune2020 <-brick("c_gls_ALDH_202005240000_GLOBE_PROBAV_V1.5.1.nc")

cl <- colorRampPalette(c('darkblue','dark green','yellow'))(100) 
plot(albedojune2020,col=cl)
#the file seems heavy, let's try to reduce the size through the function aggregate
albedojune2020_10<- aggregate (albedojune2020,fact=10)
plot(albedojune2020_10,col=cl)

