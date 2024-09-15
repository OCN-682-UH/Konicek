###INTRO####

##This code will run a new plot made from data in the Palmer penguins package

#created by Kelli Konicek
#created on 2024-9-12
#updated on 2024-9-12

### libraries ####
library(here)
library(tidyverse)
library(here)
library(palmerpenguins)
library(ggplot2)
library(ggthemes)
library(ggpubr)
library(ggridges)


### load data ####
#data set is built into library(palmerpenguins)

# here are ways to take a look at your dataset 
view(penguins)
head(penguins)
tail(penguins)
glimpse(penguins) 

### load functions ####

#no functions for this yet 

### data analysis:Are males or females heavier? ####

#remove NAs
penguins1<- na.omit(penguins)

#make a plot
ggplot(data=penguins1, mapping=aes(x = body_mass_g, 
                      y = species,)) +               
 geom_density_ridges(scale = 1,
    aes(point_color = sex, point_fill = sex, point_shape = sex),
    alpha = .7, point_alpha = .5, jittered_points = TRUE
  ) +                                                 # create density curves to show distribution of penguin weights. Maybe a histogram would be better?
  scale_x_continuous(breaks = c(3000,4000,5000,6000),
                     labels = c("3", "4", "5","6"))+ # I donʻt know how to quickly convert the grams to kiloGssss without just relabeling it
  labs(title="Distribution of penguin mass by species and sex",
       subtitle="Gentoo's got some big boys",
       x= "Body Weight (kg)",
       y= "Species",
       caption = "Source: Palmer station") +
  theme_fivethirtyeight()

#red text:"picking joint bandwidth of 116" 


###save plot ####
ggsave(here("week_03" , "outputs", "homework_3.png"), width = 11, height = 7)