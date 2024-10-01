#GOODBYE PENGUINS####


#filter(df, type == "otter" & site == "bay")
#if the answer is yes, it keeps it-- look at page 8 of Week 4A
# == means exactly equal to
#asking very explicit 

filter(.data = penguins, sex == "female") 

#list of logical expressions: 
#x<y less than 
# x%in% y (give it two options-- is it within-- in group membership)
#is.na(x) only keep NAs
#!is.na(x) do NOT keep NAs
#x>y greater than
# == exactly equal
#x <= y less than or equal to 
#x >= y greater than or equal to 
#x != y not equal to 


#Choose penguins measured in 2008

glimpse (penguins)

filter(.data = penguins, year == "2008")

#Choose penguins with body mass greater than 5000
filter(.data = penguins, body_mass_g > 5000)

#when do I use quotes? If you want to find an exact value or have a character, use quotes. Numbers don't need quotes. Treat things you want EXACTLY like a character.

#you can add in multiple layers of things separating by commas 

filter(.data = penguins, sex == "female", body_mass_g > 5000)

### BOOLEAN OPERATORS ####

#a & b is a AND b
#a | b is a OR b 
#!a is NOT A 

#default for filter is &, but you can use comma for it 

filter(.data = penguins, year == "2008" | year == "2009")
#OR
filter(.data = penguins, year %in% c("2008", "2009"))

filter(.data = penguins, island != "Dream")

filter(.data = penguins, species %in% c("Adelie", "Gentoo"))

#penguins between 3000 and 5000 g
filter(.data = penguins,
       body_mass_g <5000,
       body_mass_g > 3000)

### MUTATE ####

#add a new column converting body mass in g to kg and save the new dataframe
data2<-mutate(.data= penguins,
              body_mass_kg = body_mass_g/1000,
              bill_length_depth = bill_length_mm/bill_depth_mm)
#add multiple new columns 

#mutate multiple columns at the same time: 
#mutate_if(), mutate_at()-- the columns that I tell you, do the same to them, this is good if you have a bunch of columns if you want to do the same thing to them 
#mutate_all-- examples on the 4a slide 

### ifelse()####
# if this is true, give it whatever value you want, if it is false, give whatever value you want
#add new columns based of ddata you already have 

#case_when: ask it for multiple ifelse stuffs -- ifelse is for two things

data2 <- mutate(.data = penguins,
                after_2008 = ifelse(year > 2008, "After 2008", "Before 2008"))

data2<-mutate(.data= penguins,
              flipper_plus_body = flipper_length_mm + body_mass_g +
                BIGBOYS = ifelse(body_mass_g > 4000, "BIG BOY", "SMALL BOY"))       

### THE PIPE ####
#says "and then do" verb 1 and do verb 2 

##|>this is also called a NATIVE pipe  magritter pipe needs tidyverse
## using the pipe means you don't need the .data 

data3 <- penguins %>%
  filter(sex=="female") %>%
  mutate(log_mass = log(body_mass_g))

### SELECT ####
#SELECT COLUMNS 
data4 <- penguins %>%
  filter (sex == "female") %>%
  mutate(log_mass = log(body_mass_g) %>%
           select(species, island, sex, log_mass))

#can use select to RENAME columns, can do it within the select function 
#NEW FIRST, THEN OLD 


###SUMMARIZE ####
#have less rows because you are summarizing by a variable you're interested in
#want to calculate mean for flipper length 

data4 <- penguins %>% 
  summarize(mean_flipper = mean(flipper_length_mm, na.rm = TRUE))

#you can add mulitple different things to this 
#can do summarizeat, summarizeif, summarizeall 

###GROUPBY####
#almost always associated with summarize 
data5 <- penguins %>% 
  group_by(island) %>% 
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE))

data5 <- penguins %>% 
  group_by(island, sex) %>% 
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE))

####REMOVE NAS###
#only drop missing data from the column you want
penguins %>% 
  drop_na(sex) %>%
  group_by(island, sex) %>% 
  summarize(mean_bill_length = mean(bill_length_mm, na.rm = TRUE))

#### PIPE TO A GGPLOT ####
#you can clean up all your data and pipe it straight ot GGplot 

#YOU GOTTA SWITCH FROM THE PIPE TO THE + WHEN YOU USE GGPLOT

#HOMEWORK write a script that's on the 4A


### 4B NOTES ####

###working with tidyr homework 4B: Silbiger et al. biochem data from Hawaii ####
### created by kelli #########
### last edit 9/24/2024 ########

### load libaries ####
library(tidyverse)
library(here)
library(ggplot2)

### Load data ######
chemdata <- read_csv(here("week_04", "data", "chemicaldata_maunalua.csv"))
view(chemdata)


### Clean data ####
clean <- chemdata %>%
  filter(complete.cases(.)) %>% #filters out everything that's not complete
  separate(col = Tide_time, #old column
           into = c("Tide","Time"), #new columns
           sep = "_") #separate old column by this symbol 
view(clean) #looks good 

#can set "remove = FALSE" to keep the separate column 

#UNITE 
#brings two columns together 

clean <- chemdata %>%
  filter(complete.cases(.)) %>% #filters out everything that's not complete
  separate(col = Tide_time, #old column
           into = c("Tide","Time"), #new columns
           sep = "_") %>% #separate old column by this symbol
  unite(col = "Site_Zone", #NEW column
        c(Site,Zone), #existing columns to unite
        sep = ".", #separating symbol 
        remove = FALSE) #DO NOT delete the original columns 

#PIVOT DATA FROM WIDE TO LONG STYLE 

#easier to summarize with group_by() and facet_wrap()-- can do these as a function of the variable

#pivot_longer()

long <- clean %>%
  pivot_longer(cols = Temp_in:percent_sgd, #columns you want to pivot
               names_to = "Variables", #names of new columns with all the variables
               values_to = "Values") #name of the new column with all the values
long %>%
  group_by(Variables, Site) %>% #group by everything we want 
  summarise(Param_means = mean(Values, na.rm = TRUE), #get mean
            Param_vars = var(Values, na.rm = TRUE))
view(long)

#THE CHALLENGE 

summary <- long %>%
  group_by(Variables, Site_Zone, Tide) %>%
  summarise(Param_means= mean(Values, na.rm = TRUE), #get mean
            Param_vars = var(Values, na.rm = TRUE),
            Param_sd = sd(Values, na.rm = TRUE))

### facet_wrap with long data- fix the y axis to let scale be free

long %>%
  ggplot(aes(x = Site, y = Values))+
  geom_boxplot()+
  facet_wrap(~Variables, scales = "free")

#if you want to scale the x, scales = "free_x" or "free_y" to do y only 

###LONG TO WIDE ####

#instead of names_to, we go names_from 

wide <- summary %>%
  pivot_wider(names_from = Variables, #column with names for new column 
              values_from = Param_means:Param_sd) #column with the values

### SUMMARY STATS AND CSV FILE ####

write_csv("week_04", "output","data","summary.csv")
