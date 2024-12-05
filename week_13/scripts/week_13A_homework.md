week_13A_homework
================
kelli
2024-12-04

# Libraries

``` r
library(tidyverse)
```

    ## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
    ## ✔ dplyr     1.1.4     ✔ readr     2.1.5
    ## ✔ forcats   1.0.0     ✔ stringr   1.5.1
    ## ✔ ggplot2   3.5.1     ✔ tibble    3.2.1
    ## ✔ lubridate 1.9.3     ✔ tidyr     1.3.1
    ## ✔ purrr     1.0.2     
    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()
    ## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

``` r
library(here)
```

    ## here() starts at /Users/kellikonicek/Desktop/Repositories/Konicek

## Instructions

You have a set of 4 .csv files in data/homework. Each of these files is
a timeseries of temperature and light data collected in tide pools in
Oregon by Jenn Fields.

Your goal is to bring in all 4 files and calculate the mean and standard
deviation of both temperature (Temp.C) and light (Intensity.lux) for
each tide pool.

Use both a for loop and map() functions in your script. (Basically, do
it twice).

# For Loop

## Using loops to read in multiple .csv files

### Read in one of the files so that you can see what it looks like.

``` r
testdata<-read_csv(here("week_13", "data", "homework","TP1.csv"))
```

    ## Rows: 5981 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
glimpse(testdata)
```

    ## Rows: 5,981
    ## Columns: 7
    ## $ PoolID          <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
    ## $ Foundation_spp  <chr> "Phyllospadix", "Phyllospadix", "Phyllospadix", "Phyll…
    ## $ Removal_Control <chr> "Control", "Control", "Control", "Control", "Control",…
    ## $ Date.Time       <chr> "6/16/19 0:01", "6/16/19 0:16", "6/16/19 0:31", "6/16/…
    ## $ Temp.C          <dbl> 10.21, 10.08, 10.16, 10.12, 10.08, 10.08, 10.04, 10.04…
    ## $ Intensity.lux   <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, …
    ## $ LoggerDepth     <dbl> 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, 0.15, …

### list files in a directory

go to this folder and bring in all the data in this folder

``` r
# point to the location on the computer of the folder
homePath<-here("Week_13", "data", "homework")
# list all the files in that path with a specific pattern

# In this case we are looking for everything that has a .csv in the filename

# you can use regex to be more specific if you are looking for certain patterns in filenames

files <- dir(path = homePath,pattern = ".csv")
files
```

    ## [1] "TP1.csv" "TP2.csv" "TP3.csv" "TP4.csv"

### pre-allocate space for the loop

``` r
# pre-allocate space
# make an empty dataframe that has one row for each file and  columns
 home_data<-tibble(filename =  rep(NA, length(files)),  # column name for file
                   mean_temp = rep(NA, length(files)),
                   sd_temp = rep(NA, length(files)),# column name for the mean temperature
                   mean_lux = rep(NA, length(files)),
                   sd_lux = rep(NA, length(files))# column name for the mean salinity
                   ) # column name for the year name
home_data
```

    ## # A tibble: 4 × 5
    ##   filename mean_temp sd_temp mean_lux sd_lux
    ##   <lgl>    <lgl>     <lgl>   <lgl>    <lgl> 
    ## 1 NA       NA        NA      NA       NA    
    ## 2 NA       NA        NA      NA       NA    
    ## 3 NA       NA        NA      NA       NA    
    ## 4 NA       NA        NA      NA       NA

### test

write basic code to calculate a mean and build out

``` r
raw_data<-read_csv(paste0(homePath,"/",files[1])) 
```

    ## Rows: 5981 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

great, we can go to the next step

``` r
mean_temp<-mean(raw_data$Temp.C, na.rm = TRUE) # calculate a mean
mean_temp
```

    ## [1] 13.27092

### Turn it into a for loop

``` r
for (i in 1:length(files)){ # loop over 1:4 the number of files
}
```

the only thing that is being iterated here is the file, not saving the
raw data

Add in the loop over the raw data

``` r
for (i in 1:length(files)){ # loop over 1:4 the number of files 
raw_data<-read_csv(paste0(homePath,"/",files[i]))}
```

    ## Rows: 5981 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ## Rows: 5974 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ## Rows: 5972 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ## Rows: 5995 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

## Add in means and standard devs to the loop

``` r
for (i in 1:length(files)){ # loop over 1:3 the number of files 
raw_data<-read_csv(paste0(homePath,"/",files[i]))
#glimpse(raw_data)
home_data$filename[i]<-files[i]
home_data$mean_temp[i]<-mean(raw_data$Temp.C, na.rm =TRUE)
home_data$sd_temp[i]<- sd(raw_data$Temp.C, na.rm = TRUE)
home_data$mean_lux[i]<-mean(raw_data$Intensity.lux, na.rm =TRUE)
home_data$sd_lux[i]<- sd(raw_data$Intensity.lux, na.rm = TRUE)
} 
```

    ## Rows: 5981 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ## Rows: 5974 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ## Rows: 5972 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ## Rows: 5995 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
home_data
```

    ## # A tibble: 4 × 5
    ##   filename mean_temp sd_temp mean_lux sd_lux
    ##   <chr>        <dbl>   <dbl>    <dbl>  <dbl>
    ## 1 TP1.csv       13.3    2.32     427.  1661.
    ## 2 TP2.csv       13.2    2.31    5603. 11929.
    ## 3 TP3.csv       13.1    2.32    5605. 12101.
    ## 4 TP4.csv       13.2    2.27     655.  2089.

# Purrr

## Bring in files using purrr instead of a for loop

### find the files

``` r
# point to the location on the computer of the folder
housePath<-here("week_13", "data", "homework")
files <- dir(path = housePath,pattern = ".csv")
files
```

    ## [1] "TP1.csv" "TP2.csv" "TP3.csv" "TP4.csv"

gives you entirety of the path for each one

``` r
files <- dir(path = housePath,pattern = ".csv", full.names = TRUE)
#save the entire path name
files
```

    ## [1] "/Users/kellikonicek/Desktop/Repositories/Konicek/week_13/data/homework/TP1.csv"
    ## [2] "/Users/kellikonicek/Desktop/Repositories/Konicek/week_13/data/homework/TP2.csv"
    ## [3] "/Users/kellikonicek/Desktop/Repositories/Konicek/week_13/data/homework/TP3.csv"
    ## [4] "/Users/kellikonicek/Desktop/Repositories/Konicek/week_13/data/homework/TP4.csv"

### read in the files

``` r
data<-files %>%
  set_names()%>% # set's the id of each list to the file name
  map_df(read_csv,.id = "filename") # map everything to a dataframe and put the id in a column called filename
```

    ## Rows: 5981 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ## Rows: 5974 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ## Rows: 5972 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ## Rows: 5995 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
data
```

    ## # A tibble: 23,922 × 8
    ##    filename PoolID Foundation_spp Removal_Control Date.Time Temp.C Intensity.lux
    ##    <chr>     <dbl> <chr>          <chr>           <chr>      <dbl>         <dbl>
    ##  1 /Users/…      1 Phyllospadix   Control         6/16/19 …  10.2              0
    ##  2 /Users/…      1 Phyllospadix   Control         6/16/19 …  10.1              0
    ##  3 /Users/…      1 Phyllospadix   Control         6/16/19 …  10.2              0
    ##  4 /Users/…      1 Phyllospadix   Control         6/16/19 …  10.1              0
    ##  5 /Users/…      1 Phyllospadix   Control         6/16/19 …  10.1              0
    ##  6 /Users/…      1 Phyllospadix   Control         6/16/19 …  10.1              0
    ##  7 /Users/…      1 Phyllospadix   Control         6/16/19 …  10.0              0
    ##  8 /Users/…      1 Phyllospadix   Control         6/16/19 …  10.0              0
    ##  9 /Users/…      1 Phyllospadix   Control         6/16/19 …   9.95             0
    ## 10 /Users/…      1 Phyllospadix   Control         6/16/19 …   9.56             0
    ## # ℹ 23,912 more rows
    ## # ℹ 1 more variable: LoggerDepth <dbl>

### calculate means

``` r
data<-files %>%
  set_names()%>% # set's the id of each list to the file name
  map_df(read_csv,.id = "filename") %>% # map everything to a dataframe and put the id in a column called filename
  group_by(filename) %>%
  summarise(mean_temp = mean(Temp.C, na.rm = TRUE),
            sd_temp = sd(Temp.C, na.rm = TRUE),
            mean_lux = mean(Intensity.lux, na.rm = TRUE),
            sd_lux = sd(Intensity.lux ,na.rm = TRUE))
```

    ## Rows: 5981 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ## Rows: 5974 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ## Rows: 5972 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
    ## Rows: 5995 Columns: 7
    ## ── Column specification ────────────────────────────────────────────────────────
    ## Delimiter: ","
    ## chr (3): Foundation_spp, Removal_Control, Date.Time
    ## dbl (3): PoolID, Temp.C, LoggerDepth
    ## num (1): Intensity.lux
    ## 
    ## ℹ Use `spec()` to retrieve the full column specification for this data.
    ## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

``` r
data
```

    ## # A tibble: 4 × 5
    ##   filename                                     mean_temp sd_temp mean_lux sd_lux
    ##   <chr>                                            <dbl>   <dbl>    <dbl>  <dbl>
    ## 1 /Users/kellikonicek/Desktop/Repositories/Ko…      13.3    2.32     427.  1661.
    ## 2 /Users/kellikonicek/Desktop/Repositories/Ko…      13.2    2.31    5603. 11929.
    ## 3 /Users/kellikonicek/Desktop/Repositories/Ko…      13.1    2.32    5605. 12101.
    ## 4 /Users/kellikonicek/Desktop/Repositories/Ko…      13.2    2.27     655.  2089.

# YEEEE HAW!
