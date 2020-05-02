#Open R#
#set the work directory
setwd("/Users/alessandro/r_exercises")    ####put your working directory###

library(tidyverse) # metapackage with lots of helpful functions

## Reading in files

# You can access files from datasets you've added to this kernel in the "../input/" directory.
# You can see the files added to this kernel by running the code below. 

list.files(path = "../input")


library(data.table)
library(dplyr, warn.conflicts = FALSE)
library(ggplot2)
library(tibble)

#importing the data
rain = read.csv("/Users/alessandro/r_exercises/weatherAUS.csv")  ####put your working directory####
head(rain, n=10)

summary(rain)


colSums(is.na(rain))  
#sum of the number of data for each dataset


str(rain)
#str is a compact way to display the structure of an R object


rain <- rain[!(is.na(rain$RainToday)),]
#to find missing values you check for NA (not available) in R using the is.na() function
#'!' it's the logical operator for negation
#‘$’ refers to a specific column relative to a specific data frame
#####WHAT DOES IT MEANS?######


rain$Year =substr(rain$Date, 1, 4)
rain$Month =substr(rain$Date, 6, 7)

rownames(rain)= paste0("Event",seq(from=1, to=nrow(rain),by=1))
head(rain)

#####WHAT DOES IT MEANS?######


#Remove some columns
rain=select (rain,-c(WindGustDir,WindDir9am,WindDir3pm,Date))

#Convert numeric
rain$RainToday= as.numeric(rain$RainToday)
rain$RainTomorrow= as.numeric(rain$RainTomorrow)
