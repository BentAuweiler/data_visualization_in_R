library(dslabs)
library(ggplot2)
library(tidyverse)

# a second demo for histograms and smooth density plots

data(heights) # using the heights data


# creating a simple plot
p <- heights %>% 
  ggplot(aes(height))

# plotting the first histogram
p + geom_histogram(binwidth = 1)

# plotting the first smooth density
p + geom_density()

# using group to create two line for each gender
heights %>% 
  ggplot(aes(height, group = sex)) +
  geom_density()

# instead of using the group argument you can also use the color argument to create a plot for each gender
heights %>% 
  ggplot(aes(height, color = sex)) +
  geom_density()

# a third way of achieving this is by using the fill argument for aes()

heights %>% 
  ggplot(aes(height, fill = sex)) + 
  geom_density(alpha = 0.2)

# this also works for histograms not only for smooth density plots

heights %>% 
  ggplot(aes(height, fill = sex)) + 
  geom_histogram(binwidth = 1, alpha = 0.2)
