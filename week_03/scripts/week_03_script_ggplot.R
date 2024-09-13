### PALMER PENGUINS GGPLOT ###

# Kelli Konicek 
#created on 2024-09-10

###libraries#### 
library(tidyverse)
library(here)
library(palmerpenguins)
library(ggplot2)
library(beyonce)
library(ggthemes)

###LOOK AT YOUR DATA ####
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

### WEEK3B ####

ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm))+
  geom_point()+
  geom_smooth(method="lm", se= FALSE)+ #best way to plot regressions! Whahoo! You can remove the standard error with se=FALSE
  labs(x = "Bill depth (mm)",
       y = "Bill length (mm)")



#### GROUP FUNCTION IN AES####

ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species, #GROUP BY SPECIES OR ANOTHER COLUMN WHOO HOO!
                     color = species))+
  geom_point()+
  geom_smooth(method="lm")+ 
  labs(x = "Bill depth (mm)",
       y = "Bill length (mm)")


#### CHANGING SCALES ####

ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species, 
                     color = species))+
  geom_point()+
  geom_smooth(method="lm")+ 
  labs(x = "Bill depth (mm)",
       y = "Bill length (mm)")+
  scale_x_continuous(limits = c(12,20))+ #make a limit for the scales! 
  scale_y_continuous(limits = c(30, 50))

#### CHANGE BREAKS ####

ggplot(data=penguins,
       mapping = aes(x = bill_depth_mm,
                     y = bill_length_mm,
                     group = species, 
                     color = species))+
  geom_point()+
  geom_smooth(method="lm")+ 
  labs(x = "Bill depth (mm)",
       y = "Bill length (mm)")+
  scale_x_continuous(breaks = c(14,17,21),
                     labels = c("low", "medium", "high")) 
  scale_y_continuous(limits = c(30, 50))

  
  
  
  #### MANUALLY CHANGE THE COLOR ####
  
  ggplot(data=penguins,
         mapping = aes(x = bill_depth_mm,
                       y = bill_length_mm,
                       group = species, 
                       color = species))+
    geom_point()+
    geom_smooth(method="lm")+ 
    labs(x = "Bill depth (mm)",
         y = "Bill length (mm)")+
  scale_x_continuous(breaks = c(14,17,21),
                       labels = c("low", "medium", "high"))+ 
  scale_y_continuous(limits = c(30, 50))+
  scale_color_manual(values = c("orange","blue","black"))

  ### COLOR PALLETS ####
  ##instead of using install.packages, use install_github(USERNAME,PACKAGE NAME)
  ggplot(data=penguins,
         mapping = aes(x = bill_depth_mm,
                       y = bill_length_mm,
                       group = species, 
                       color = species))+
    geom_point()+
    geom_smooth(method="lm")+ 
    labs(x = "Bill depth (mm)",
         y = "Bill length (mm)")+
    scale_x_continuous(breaks = c(14,17,21),
                       labels = c("low", "medium", "high"))+ 
    scale_y_continuous(limits = c(30, 50))+
    scale_color_manual(values = beyonce_palette(2)) #now you can use the pallette in the place of manual colors!

  ### COORDINATES ####
  
  #default coordinates for ggplot are cartesian (x,y)
  #flip the axes 
  
  ggplot(data=penguins,
         mapping = aes(x = bill_depth_mm,
                       y = bill_length_mm,
                       group = species, 
                       color = species))+
    geom_point()+
    geom_smooth(method="lm")+ 
    labs(x = "Bill depth (mm)",
         y = "Bill length (mm)")+
    scale_x_continuous(breaks = c(14,17,21),
                       labels = c("low", "medium", "high"))+ 
    scale_y_continuous(limits = c(30, 50))+
    scale_color_manual(values = c("orange","blue","black"))+
    coord_flip()
  
  #flip the aspect ratio 
  ggplot(data=penguins,
         mapping = aes(x = bill_depth_mm,
                       y = bill_length_mm,
                       group = species, 
                       color = species))+
    geom_point()+
    geom_smooth(method="lm")+ 
    labs(x = "Bill depth (mm)",
         y = "Bill length (mm)")+
    scale_x_continuous(breaks = c(14,17,21),
                       labels = c("low", "medium", "high"))+ 
    scale_y_continuous(limits = c(30, 50))+
    scale_color_manual(values = c("orange","blue","black"))+
    coord_fixed()
#transform x and y axis 
  #want to keep the data in its natural scale, but wanna log the visual itself 
  
  #coord_trans(x = "log10", y = "log10") #make the space log times scale. cool! lots of transformations
  
  #make coordinates polar 
  #turn x axis into polar coordinates 
  #coord_polar("x")
  
  ###THEMES####
  #composed of four main elements:non data elements you can control
  #element_text can set the font size and stuff 
  #theme() allows you to override all the default
  #complete themes can also be done like theme_gray
  
  ggplot(data=penguins,
         mapping = aes(x = bill_depth_mm,
                       y = bill_length_mm,
                       group = species, 
                       color = species))+
    geom_point()+
    geom_smooth(method="lm")+ 
    labs(x = "Bill depth (mm)",
         y = "Bill length (mm)")+
    scale_x_continuous(breaks = c(14,17,21),
                       labels = c("low", "medium", "high"))+ 
    scale_y_continuous(limits = c(30, 50))+
    scale_color_manual(values = c("orange","blue","black"))+
    theme_bw()+
    theme(axis.title = element_text(size = 20,
                                    color = "blue"),
          panel.background = element_rect(fill = "linen")) #fill changes the inside, color just changes the outside
  ###SAVE THE PLOT####
  
  ggsave(here("week_03" , "outputs", "penguins.png"), width = 7, height = 5)
  ###OTHER GGPLOT EXTENSIONS####
  #GGPUBR- ggplot extension that makes it publicaion 
  