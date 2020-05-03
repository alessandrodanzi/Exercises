#Open R#
#set the work directory
setwd("/Users/alessandro/r_exercises")    ####put your working directory###

library(tidyverse) # metapackage with lots of helpful functions

## Reading in files

# You can access files from datasets you've added to this kernel in the "../input/" directory.
# You can see the files added to this kernel by running the code below. 

list.files(path = "/Users/alessandro/r_exercises")


library(data.table)
library(dplyr, warn.conflicts = FALSE)
library(ggplot2)
library(tibble)

#importing the data
rain = read.csv("/Users/alessandro/r_exercises/weatherAUSclean.csv")  ####put your working directory####
head(rain, n=10)





summary(rain)


colSums(is.na(rain))  
#sum of the number of data for each dataset


str(rain)
#str is a compact way to display the structure of an R object


#rain <- rain[!(is.na(rain$RainToday)),]
#to find missing values you check for NA (not available) in R using the is.na() function
#'!' it's the logical operator for negation
#‘$’ refers to a specific column relative to a specific data frame
#####WHAT DOES IT MEANS?######

#Remove some columns
> rain=select (rain,-(Date))
> head(rain)

rain$Year =substr(rain$Date, 7, 10)
rain$Month =substr(rain$Date, 4, 5)

rownames(rain)= paste0("Event",seq(from=1, to=nrow(rain),by=1))
head(rain)

#####To create 2 more columns where we have separately months and years######

#Assingn NA variable according to mod in categorical features

#Location
val1 <- unique(rain$Location[!is.na(rain$Location)])  # Values in rain$Location
mode1 <- val1[which.max(tabulate(match(rain$Location, val1)))] # Mode of a feature

rain$Location[is.na(rain$Location)] <- mode1


#Add ID
rain$ID <- seq.int(nrow(rain))

a=select(rain, Location, ID)
head(a)


rain$Year=as.numeric(rain$Year)
rain$Month=as.numeric(rain$Month)


drops <- c("Location")
rain=rain[ , !(names(rain) %in% drops)]


#Assingn NA variable according to mean in numerical features

rain = data.frame(
    sapply(
        rain,
        function(x) ifelse(is.na(x),
            mean(x, na.rm = TRUE),
            x)))
colSums(is.na(rain))
      
      
rain=round(rain, digits=2)
      
      
#Inner Join a data frame and rain data frame because I want to add Location column like before.
final=merge(x = rain, y = a, by = "ID", all.x = TRUE)
final <- final[order(final$ID),]
      
      
final$AvgTemp <- round(rowMeans(rain[c('MinTemp', 'MaxTemp')], na.rm=TRUE),digits=2)
      
      
      
      
#######DESCRIPTIVE STATISTICS######

print("mean:")
mean(final$AvgTemp)
print("variance:")
var(final$AvgTemp)
print("standard deviation:")
sd(final$AvgTemp)
print("q1, q2, q3, q4 :")
quantile(final$AvgTemp)
print("median:")
median(final$AvgTemp)
print("range:")
range(final$AvgTemp)
print("Difference between boundaries :")
range(final$AvgTemp)[2]- range(final$AvgTemp)[1]
print("q3-q1:")
unname(quantile(final$AvgTemp)[4] - quantile(final$AvgTemp)[2])
      
      
      
      
#VISUALIZATION
install.packages("viridis")  # Install
library("viridis")           # Load
library(ggplot2)
# Gradient color
#in most cases you start with ggplot(), supply a dataset and aesthetic mapping (with aes()).
#You then add on layers (like geom_point() or geom_histogram()), scales (like scale_colour_brewer()), 
#faceting specifications (like facet_wrap()) and coordinate systems (like coord_flip()).
ggplot(final, aes(MinTemp, MaxTemp))+
  geom_point(aes(color = MinTemp)) +
  scale_color_viridis(option = "D")+
  theme_minimal() +
  theme(legend.position = "bottom")
