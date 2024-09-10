### Dis is my fwirst scwipt. I'm learning, I'm doing it! 
### Created by: kelli 
### Created on: 2024-09-09

### Load libraries ####
library(tidyverse)

library(here) #here() starts at /Users/kellikonicek/Desktop/Repositories/Konicek

### read in my data ####
weightdata <-read_csv(here("Week_02","data","weightdata.csv"))

### data analysis ####

head(weightdata) # looks at the top 6 lines of dataframe. Always look 

tail(weightdata) #look at the bottom 6 lines

view(weightdata) #open into new window to see whole thing
