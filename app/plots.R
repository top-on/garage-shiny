# VISUALIZE PARKING GARAGE DATA

library(dplyr)
library(lubridate)
library(RSQLite)
library(ggplot2)

# READ DATA ----
load("data/df.Rdata")

# PREPROCESS ----
df_processed <-
  df %>%
  mutate(., free = as.numeric(free)) %>%
  mutate(., datetime = as_datetime(df$datetime, tz = "Europe/Berlin")) %>%
  mutate(., time = hms::as.hms(datetime))

# VISUALIZE ----
df_processed %>%
  filter(name == "Parkhaus Karstadt") %>% 
  ggplot(data = ., aes(x = time, y = free)) +
  geom_line(aes(group = date), alpha = .4) +
  theme_bw() +
  xlab("Time of day") +
  ylab("Free spots") +
  ggtitle(paste0("Free parking spots per day for parking 'Parkhaus Karstadt'")) +
  theme(text = element_text(size = 20))
