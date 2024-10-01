###working with lubridate dates/times and joins
###created by kelli 
### last update:9/30/2024

###load libraries #####
library(tidyverse)
library(here)
library(lubridate)
library(ggplot2)

### Load data ####
cond <- read_csv(here("week_05", "data", "CondData.csv"))
#this one needs rounding to the nearest ten seconds

depth <- read_csv(here("week_05", "data", "DepthData.csv"))


### Clean, Join, Summarize data ####

depth %>%
  mutate(date = floor_date(date, "min")) #round down to nearest minute

joined <- cond %>%
  mutate(date = mdy_hms(date), #convert date column to dttm as well 
date = floor_date(date, "min")) %>% #round to nearest minute
  inner_join(depth)%>%
  select (-c(AbsPressure, Serial)) #remove these
  
summary <- joined %>%
  pivot_longer(cols = Temperature:Depth, #columns you want to pivot
               names_to = "Variables", #names of new columns with all the variables
               values_to = "Values") %>% #name of the new column with all the values 
  group_by(date, Variables) %>%
  summarise(mean = mean(Values, na.rm = TRUE)) #make a summary of means to plot
  

### Plot Data ####

#rename variables for plot
variables <- list( 
  'Depth'="Depth (m)",
  'Salinity'="Salinity (ppt)",
  'Temperature'="Temperature (°C)"
)

#create a labeller function 

summary_labeller <- function(variable,value){
  return(variables[value])
}

#did this work? YES! But it's been updated from this. you got it from https://stackoverflow.com/questions/3472980/how-to-change-facet-labels

summary %>%
  ggplot(aes(x = date, y = mean))+
  geom_line() + 
  facet_wrap(~Variables, labeller = summary_labeller, scales = "free") +
  theme_linedraw()+
  labs(x = "Time on January 15, 2021",
       y = "Mean reading per minute",
       title = "Timeseries of Average Depth, Salinity and Temperature")

###SAVE THE PLOT####

ggsave(here("week_05" , "outputs", "timeseries.png"), width = 11, height = 7)
