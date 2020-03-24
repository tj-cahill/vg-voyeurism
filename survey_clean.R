library(readr)
library(dplyr)

# Import data from pre-test survey
w1_pre <- read_csv("data/W1_PreTestResponse.csv", col_names = FALSE, skip = 3,
                   col_types = cols(X1 = col_character(), 
                                    X2 = col_factor(levels = c("No", "Yes")),
                                    X3 = col_factor(levels = c("No", "Yes")), 
                                    X4 = col_factor(levels = c("No", "Yes")), 
                                    X5 = col_factor(levels = c("No",  "Yes")), 
                                    X6 = col_logical(), X7 = col_integer(), 
                                    X8 = col_integer(), X9 = col_integer(),
                                    X10 = col_integer(),  X11 = col_integer(), 
                                    X12 = col_integer(), X13 = col_integer(), 
                                    X14 = col_integer(), X15 = col_integer(), 
                                    X16 = col_integer(), X17 = col_integer(), 
                                    X18 = col_integer(), X19 = col_integer(), 
                                    X20 = col_integer(), X21 = col_integer(),
                                    X22 = col_integer(), X23 = col_integer(), 
                                    X24 = col_integer(), X25 = col_integer()))

w2_pre <- read_csv("data/W2_PreTestResponse.csv", col_names = FALSE, skip = 3,
                   col_types = cols(X1 = col_character(), 
                                    X2 = col_factor(levels = c("No", "Yes")),
                                    X3 = col_factor(levels = c("No", "Yes")), 
                                    X4 = col_factor(levels = c("No", "Yes")), 
                                    X5 = col_factor(levels = c("No",  "Yes")), 
                                    X6 = col_logical(), X7 = col_integer(), 
                                    X8 = col_integer(), X9 = col_integer(),
                                    X10 = col_integer(),  X11 = col_integer(), 
                                    X12 = col_integer(), X13 = col_integer(), 
                                    X14 = col_integer(), X15 = col_integer(), 
                                    X16 = col_integer(), X17 = col_integer(), 
                                    X18 = col_integer(), X19 = col_integer(), 
                                    X20 = col_integer(), X21 = col_integer(),
                                    X22 = col_integer(), X23 = col_integer(), 
                                    X24 = col_integer(), X25 = col_integer()))
# Merge waves of data
w1_pre$wave <- as.integer(1)
w2_pre$wave <- as.integer(2)

pre <- bind_rows(w1_pre, w2_pre)

# Clean column names
colnames(pre) <-
  c("id",
    "useTwitch",
    "postTwitch",
    "useYT",
    "postYT",
    "complete",
    "hrsWatchingVideo_weekday",
    "hrsWatchingTV_weekday",
    "hrsWatchingRecordedVGContent_weekday",
    "hrsOtherInternet_weekday",
    "hrsWatchingStreamedVGContent_weekday",
    "hrsPlayingSinglePlayer_weekday",
    "hrsPlayingMultiPlayer_weekday",
    "hrsWatchingVideo_weekend",
    "hrsWatchingTV_weekend",
    "hrsWatchingRecordedVGContent_weekend",
    "hrsOtherInternet_weekend",
    "hrsWatchingStreamedVGContent_weekend",
    "hrsPlayingSinglePlayer_weekend",
    "hrsPlayingMultiPlayer_weekend",
    "streamersWatched",
    "TwitchChannelsSubscribed",
    "ownChannelFollowers",
    "VGChannelsSubscribed",
    "ownChannelSubscribers",
    "wave")

# Remove incomplete responses
pre <- pre %>% filter(complete) %>% select(-complete)