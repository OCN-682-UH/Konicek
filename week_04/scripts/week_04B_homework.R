###working with tidyr homework 4B: Silbiger et al. biochem data from Hawaii ####
### created by kelli #########
### last edit 9/24/2024 ########

### load libaries ####
library(tidyverse)
library(here)
library(ggplot2)

### Load data ######
chemdata <- read_csv(here("week_04", "data", "chemicaldata_maunalua.csv"))
#view(chemdata) looks good


### clean data ####
clean <- chemdata %>%
filter(complete.cases(.)) %>% #filters out everything that's not complete
separate(col = Tide_time, #old column
                  into = c("Tide","Time"), #new columns
                  sep = "_") #separate old column by this symbol 
#view(clean) #looks good 


###filter-- I want to look at how NN and phosphate change in the Transition areas by Spring tide####
filtered <- clean %>%
  select(c(Site, Season, Zone, Tide, Phosphate, NN)) %>%
  filter(Season == "SPRING",
       Zone == "Transition") 


### Pivot data #### 
long <- filtered %>%
  pivot_longer(cols = Phosphate:NN, #columns you want to pivot
               names_to = "Variables", #names of new columns with all the variables
               values_to = "Values") #name of the new column with all the values
#view(long) # looks good

mean_summary <- long %>%
  group_by(Site, Variables, Tide) %>% #group by everything we want 
  summarise(Param_means = mean(Values, na.rm = TRUE)) %>% #get mean
  pivot_wider(names_from = Tide:Variables, #column with names for new column 
              values_from = Param_means) %>% #column with the values
  write_csv(here("week_04", "outputs","data","summary_Tide_K_N.csv")) #export csv to output data folder

### PLOT TIME BABY. PLOT-PLOT-PLOT IT UP ####

ggplot(data=filtered, mapping= aes(x= log(NN),
                                   y= log(Phosphate),
                                   color = Tide,
                                   shape = Site)) + #colors the points by the actual raw data of that column,
  geom_point()+
  labs(title="Phosphate, Nitrate and Nitrite levels are higher at low tide",
       x= "Log of Nitrate and Nitrite level",
       y= "Log of Phosphate level",
       color = "Tide",
       shape = "Site Acronym",
       caption = "Source: N Silbiger et al., 2018") +
  theme_light()

ggsave(here("week_04" , "outputs","plots", "4B_Homework.png"), width = 7, height = 5)
