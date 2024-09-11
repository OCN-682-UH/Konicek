### PALMER PENGUINS GGPLOT ###

# Kelli Konicek 
#created on 2024-09-10

#libraries 
library(tidyverse)
library(palmerpenguins)
library(ggplot2)
view(penguins)
head(penguins)
tail(penguins)
glimpse(penguins) #ways to take a look at your dataset 

#make a plot
ggplot(data=penguins) #I know what dataset I'm using but I'm not telling you what to do 

#make aesthetics- anything that determines how the thing looks based on the data set
ggplot(data=penguins, mapping= aes(x= bill_depth_mm,
                                   y= bill_length_mm,
                                   color = species, #colors the points by the actual raw data of that column,
                                   shape = island,
                                   size = body_mass_g,
                                   alpha = flipper_length_mm)) +  #alpha changes the density of points
  geom_point() + # plus adds a new function, comma add
  labs(title="Bill depth and length",
       subtitle="Big Bills and Deep Bills for cold ducks",
       x= "Bills Deep (mm)",
       y= "Bills Big (mm)",
       color = "Names of Cold Ducks",
       caption = "Source: Palmer station or citation here") + scale_color_viridis_d()
#mapping v setting. settings are things that are not based ont the values. put settings in the geom_point () layer

ggplot(data=penguins, mapping= aes(x= bill_depth_mm,
                                   y= bill_length_mm,
                                   color = species, #colors the points by the actual raw data of that column,
                                   shape = island,
                                   size = body_mass_g,
                                   alpha = flipper_length_mm)) +  #alpha changes the density of points
  geom_point(size=2) + # plus adds a new function, comma add
  labs(title="Bill depth and length",
       subtitle="Big Bills and Deep Bills for cold ducks",
       x= "Bills Deep (mm)",
       y= "Bills Big (mm)",
       color = "Names of Cold Ducks",
       caption = "Source: Palmer station or citation here") + scale_color_viridis_d()

#faceting-- useful for exploring conditional relationships in large data sets 

###FACET GRID
ggplot(data=penguins, mapping= aes(x= bill_depth_mm,
                                   y= bill_length_mm))+
         geom_point() +
         facet_grid(species~sex) #EACH ROW AS A FUNCTION OF COLUMNS

###FACET WRAP
ggplot(data=penguins, mapping= aes(x= bill_depth_mm,
                                   y= bill_length_mm))+
  geom_point() +
  facet_wrap(~species) # 1D ribbon: YOU determine the dimensions with facet wrap- tilda can make it organized by COLUMNS like this or species~ to make ROWS

ggplot(data=penguins, mapping= aes(x= bill_depth_mm,
                                   y= bill_length_mm,
                                   color= species,
                                   guides(color= FALSE)))+ #GET RID OF THAT LEGEND
  geom_point() +
  facet_wrap(~species, ncol=2) #gives more control with the wrap! 
