library(dslabs)
library(ggplot2)
library(tidyverse)
library(dplyr)
# This demo uses the US gun murders data set from wikipedia https://en.wikipedia.org/wiki/Gun_violence_in_the_United_States_by_state
# altough the data is similar the dataset used here is from 2010 and the wikipedia data is from 2015
data(murders)
head(murders)

# the most simple use of ggplot

p <- murders %>% ggplot() + geom_point(aes(x = population/10^6, y = total))
print(p)

# a little bit more refined
p_with_text <- p +
  geom_text(aes(x = population/10^6, y = total, label = abb))
print(p_with_text)

# we get a little bit better here
p_a_little_better <- murders %>% ggplot() +
  geom_point(aes(x = population/10^6, y = total), size = 3) +
  geom_text(aes(x = population/10^6, y = total, label = abb), nudge_x = 1)
print(p_a_little_better)

# now use a global aesthetic mapping to simplify the code above
# note that all geomitries will default to the globally defined aes
# important you can still overwrite the global aes in each of the layers locally
p_simplified <-  murders %>% ggplot(aes(x = population/10^6, y = total, label = abb)) +
  geom_point(size = 3) + geom_text(nudge_x = 1)
print(p_simplified)

# changing the scale of the x and y axis, adding lables to the axis and add a title
p_scaled <- murders %>% ggplot(aes(x = population/10^6, y = total, label = abb)) +
  geom_point(size = 3) +
  geom_text(nudge_x = 0.075) + # we have to adjust the nudge because the plot is now in the log scale
  scale_y_log10() +
  scale_x_log10() +
  xlab("Populations in millions (log scale)") +
  ylab("total number of murders (log scale)") +
  ggtitle("US Gun Murders in US 2010")

print(p_scaled)

# adding a color mapping to the plot for the regions

# changing the scale of the x and y axis, adding lables to the axis and add a title
p_colored <- murders %>% ggplot(aes(x = population/10^6, y = total, label = abb)) +
  geom_point(aes(col=region), size = 3) +
  geom_text(nudge_x = 0.075) +
  scale_y_log10() +
  scale_x_log10() +
  xlab("Populations in millions (log scale)") +
  ylab("total number of murders (log scale)") +
  ggtitle("US Gun Murders in US 2010")

print(p_colored)

# adding the average murder rate to the graph
# therefore we need to calculate the average rate with the help of the dplyr package
rate <- murders %>% summarize(rate = sum(total) / sum(population) * 10^6) %>% .$rate
p_average_line <- murders %>% ggplot(aes(x = population/10^6, y = total, label = abb)) +
  geom_abline(intercept = log10(rate), lty = 2, color = "darkgrey") +
  geom_point(aes(col=region), size = 3) +
  geom_text(nudge_x = 0.075) +
  scale_y_log10() +
  scale_x_log10() +
  xlab("Populations in millions (log scale)") +
  ylab("total number of murders (log scale)") +
  ggtitle("US Gun Murders in US 2010") +
  scale_color_discrete(name = "Region")

print(p_average_line)


# last but not least using addon packages for plot themes and enhance the readability
library(ggthemes)
library(ggrepel)
p_final <- murders %>% ggplot(aes(x = population/10^6, y = total, label = abb)) +
  geom_abline(intercept = log10(rate), lty = 2, color = "darkgrey") +
  geom_point(aes(col=region), size = 3) +
  geom_text_repel() + # new from the ggrepel package; replaced the geom_text function
  scale_y_log10() +
  scale_x_log10() +
  xlab("Populations in millions (log scale)") +
  ylab("total number of murders (log scale)") +
  ggtitle("US Gun Murders in US 2010") +
  scale_color_discrete(name = "Region") +
  theme_economist() # new line from the ggthemes package

print(p_final)
