###created by Kelli
### Updated on 9/22/2024

###Load Libraries####
library(palmerpenguins)
library(tidyverse)
library(here)

### Load data ####
#library part of package 
glimpse(penguins)

### Analysis####

# task 1) calculate mean and variance of body mass by species, island and sex: 

task1 <- penguins %>% 
  drop_na(c(species, island, sex)) %>% #get rid of any NAs for any column
  group_by(species, island, sex) %>% #group by the desired columns
  summarise(mean_body_mass_g = mean(body_mass_g, na.rm = TRUE), #summarize the mean for each group
            var_body_mass_g = var(body_mass_g, na.rm = TRUE)) #summarize the variant for each group
view(task1)

#task 2) exclude male penguins (I am going to assume that also means NA, since I cannot confirm those AREN'T Males), log body mass, make a plot 

task2 <- penguins %>%
  filter(sex=="female") %>%
  mutate(log_mass = log(body_mass_g)) %>%
  select(c(species, island, sex, log_mass)) #selects only columns for species, island, sex and log body mass 

#plot 
ggplot(data=task2,
         mapping = aes(x = species,
                       y = log_mass,))+
  geom_boxplot(show.legend = FALSE)+
  labs(title = "Log of female penguin body mass by species",
         x = "Species",
       y = "Log of Body Mass (g)")



ggsave(here("week_04" , "outputs", "4A_homework.png"), width = 7, height = 5)


