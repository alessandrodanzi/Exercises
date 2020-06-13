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
#KI17122019 <- stack("LC08_L1TP_098085_20191208_20191217_01_T1.jpg")
#KI14012020 <- stack("LC08_L1TP_098085_20200109_20200114_01_T1.jpg")
#KI24022020 <- stack("LC08_L1TP_098085_20200210_20200224_01_T1.jpg")
#KI09042020 <- stack("LC08_L1TP_098085_20200329_20200409_01_T1.jpg")
#KI22042020 <- stack("LC08_L1TP_098085_20200414_20200422_01_T1.jpg")
#KI09052020 <- stack("LC08_L1TP_098085_20200430_20200509_01_T1.jpg")
#KI27052020 <- stack("LC08_L1TP_098085_20200516_20200527_01_T1.jpg")

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

#from Landsat8 .tiff with 11 bands divided
KI14012020B1<- stack("LC08_L1TP_098085_20200109_20200114_01_T1_B1.TIF")
KI14012020B2<- stack("LC08_L1TP_098085_20200109_20200114_01_T1_B2.TIF")
KI14012020B3<- stack("LC08_L1TP_098085_20200109_20200114_01_T1_B3.TIF")
KI14012020B4<- stack("LC08_L1TP_098085_20200109_20200114_01_T1_B4.TIF")
KI14012020B5<- stack("LC08_L1TP_098085_20200109_20200114_01_T1_B5.TIF")
KI14012020B6<- stack("LC08_L1TP_098085_20200109_20200114_01_T1_B6.TIF")
KI14012020B7<- stack("LC08_L1TP_098085_20200109_20200114_01_T1_B7.TIF")
KI14012020B8<- stack("LC08_L1TP_098085_20200109_20200114_01_T1_B8.TIF")
KI14012020B9<- stack("LC08_L1TP_098085_20200109_20200114_01_T1_B9.TIF")
KI14012020B10<- stack("LC08_L1TP_098085_20200109_20200114_01_T1_B10.TIF")
KI14012020B11<- stack("LC08_L1TP_098085_20200109_20200114_01_T1_B11.TIF")

#Scenes from the Level-1 GeoTIFF Data Product are distributed as .tar.gz files, which are Unix gzipped tape archives that can be opened with a program like 7-Zip. Each archive contains individual GeoTIFF files for each of the 11 bands captured by the Landsat sensor.
#It is possible to construct an RGB RasterStack using the red, green and blue bands (numbers 4, 3 and 2 respectively), although the color-enhanced LandsatLook rasters are generally preferred if you need visible-light color imagery.
blue = raster("LC08_L1TP_098085_20200109_20200114_01_T1_B2.TIF")
green = raster("LC08_L1TP_098085_20200109_20200114_01_T1_B3.TIF")
red = raster("LC08_L1TP_098085_20200109_20200114_01_T1_B4.TIF")

rgb = stack(red, green, blue)
plotRGB(rgb, stretch='hist')

#NDVI 
# Load visible (red) and infrared bands
red = raster("LC08_L1TP_098085_20200109_20200114_01_T1_B4.TIF")
infrared = raster("LC08_L1TP_098085_20200109_20200114_01_T1_B5.TIF")

# Perform raster algebra to calculate a raster of NDVI values
ndvi = (infrared - red) / (infrared + red)

# Plot the NDVI as a false-color image
palette = colorRampPalette(c("blue", "white", "red"))(256)
plot(ndvi, col=palette)
#The range of NDVI is -1 to +1, although NDVI values will generally be in a small area in the middle of the full potential range of -1 to +1.
#In such cases, visualization may be improved by passing a breaks parameter to plot() that assigns colors to specific ranges for plotting:
breaks = seq(-0.4, 0.4, 0.1)
palette = colorRampPalette(c("blue", "white", "red"))(8)
plot(ndvi, breaks=breaks, col=palette)

#Since the ultimate end of such analysis is usually to know what is going on at a specific location or set of locations, it can be helpful to plot NDVI over a base map that gives geographic context to the data:
library(OpenStreetMap)

# Find extent of raster in lat/long
wgs84 = CRS('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs')
outline = extent(projectExtent(ndvi, wgs84))
upperLeft = c(extent(outline)@ymax, extent(outline)@xmin)
lowerRight = c(extent(outline)@ymin, extent(outline)@xmax)

# Plot a monochrome base map
basemap = openmap(upperLeft, lowerRight, type='stamen-toner')
plot(basemap)

# Calculate NDVI
red = raster("LC08_L1TP_043027_20150330_20170228_01_T1_B4.TIF")
infrared = raster("LC08_L1TP_043027_20150330_20170228_01_T1_B5.TIF")
ndvi = (infrared - red) / (infrared + red)

# Reproject the NDVI raster to web mercator projection
ndvi = projectRaster(ndvi, projectExtent(ndvi, osm()))

# Plot the NDVI with a semi-transparent (alpha) palette
breaks = seq(-0.5, 0.5, 0.1)
palette = colorRampPalette(c("#0000FFC0", "#FFFFFFC0", "#FF0000C0"), alpha=T)(10)
plot(ndvi, breaks = breaks, col=palette, add=T)

#If you are interested in a smaller, more-specific area, the raster crop() function can be used to isolate a portion of the raster.
# Create a base map of Spokane and plot it
upperLeft = c(47.676, -117.453)
lowerRight = c(47.646, -117.381)
basemap = openmap(upperLeft, lowerRight, type='stamen-toner')
plot(basemap)

# Reproject the NDVI raster to web mercator projection
ndvi = projectRaster(ndvi, projectExtent(ndvi, osm()))

# Crop the raster to the region displayed on the base map
kangarooisland = crop(ndvi, raster(basemap))

# Plot the cropped raster
breaks = seq(-0.5, 0.5, 0.1)
palette = colorRampPalette(c("#0000FFC0", "#FFFFFFC0", "#FF0000C0"), alpha=T)(10)
plot(kangarooisland, breaks=breaks, col=palette, add=T)

