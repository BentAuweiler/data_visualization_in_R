library(dslabs)
library(ggplot2)
library(tidyverse)
data(murders)
head(murders)

# the most simple use of ggplot

p <- murders %>% ggplot() + geom_point(aes(x = population/10^6, y = total))
print(p)

# a little bit more refined
p_with_text <- p + geom_text(aes(x = population/10^6, y = total, label = abb))
print(p_with_text)

# we get a little bit better here
p_a_little_better <- murders %>% ggplot() + geom_point(aes(x = population/10^6, y = total), size = 3) + geom_text(aes(x = population/10^6, y = total, label = abb), nudge_x = 1)
print(p_a_little_better)

# now use a global aesthetic mapping to simplify the code above
# note that all geomitries will default to the globally defined aes
p_simplified <-  murders %>% ggplot(aes(x = population/10^6, y = total, label = abb)) + geom_point(size = 3) + geom_text(nudge_x = 1)
print(p_simplified)
