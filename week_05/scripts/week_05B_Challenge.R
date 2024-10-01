### Da big challenge-- convert the date column to a datetime using pipelines
###created by kelli
### updated 9/29/2024



### load libraries ####
library(tidyverse)
library(here)
library(lubridate)




###Import Data -- conductivity data ####

cond <- read_csv(here("week_05", "data", "CondData.csv"))
view(cond)

### convert date column to a datetime

#glimpse how excel read the dates: 
glimpse(cond)
#date is already a character: 1/15/2021 8:24:42


#change to character if necessary- NOT NECESSSARY  

#convert using tidyverse lubridate 
condISO <- cond %>%
  mutate(date = mdy_hms(date))

glimpse(condISO)
  

