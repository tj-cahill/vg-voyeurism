library(readr)
library(dplyr)
library(batman)

# pre ---------------------------------------------------------------------

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

# Convert variables to logical
pre <- pre %>% mutate(useTwitch = to_logical(as.character(useTwitch)),
                      postTwitch = to_logical(as.character(postTwitch)),
                      useYT = to_logical(as.character(useYT)),
                      postYT = to_logical(as.character(postYT)))

# Remove incomplete responses
pre <- pre %>% filter(complete) %>% select(-complete)

# post --------------------------------------------------------------------

# Import data from post-test survey

likert_levels <- c("Very untrue", "Untrue", "Somewhat untrue", 
                  "Neutral", "Somewhat true", "True", "Very true")

w1_post <- read_csv("data/W1_PostTestResponse.csv", 
                    col_names = FALSE, skip = 3,
                    col_types = cols(
                    X1 = col_character(),
                    X2 = col_integer(),
                    X3 = col_factor(levels = c("No", "Maybe", "Yes")),
                    X4 = col_factor(levels = c("No", "I am equally fluent in English and another language", "Yes")),
                    X5 = col_logical(),
                    X6 = col_factor(levels = likert_levels),
                    X7 = col_factor(levels = likert_levels),
                    X8 = col_factor(levels = likert_levels),
                    X9 = col_factor(levels = likert_levels),
                    X10 = col_factor(levels = likert_levels),
                    X11 = col_factor(levels = likert_levels),
                    X12 = col_factor(levels = likert_levels),
                    X13 = col_factor(levels = likert_levels),
                    X14 = col_factor(levels = likert_levels),
                    X15 = col_factor(levels = likert_levels),
                    X16 = col_factor(levels = likert_levels),
                    X17 = col_factor(levels = likert_levels),
                    X18 = col_factor(levels = likert_levels),
                    X19 = col_factor(levels = likert_levels),
                    X20 = col_factor(levels = likert_levels),
                    X21 = col_factor(levels = likert_levels),
                    X22 = col_factor(levels = likert_levels),
                    X23 = col_factor(levels = likert_levels),
                    X24 = col_factor(levels = likert_levels),
                    X25 = col_factor(levels = likert_levels),
                    X26 = col_factor(levels = likert_levels),
                    X27 = col_factor(levels = likert_levels),
                    X28 = col_factor(levels = likert_levels),
                    X29 = col_factor(levels = c("Female", "Male", "Other")),
                    X30 = col_factor(levels = c("Interested in women", "Interested in men",
                                                "Interested in both/all", "Interested in neither/none",
                                                "Other")))) 

w2_post <- read_csv("data/W2_PostTestResponse.csv", 
                    col_names = FALSE, skip = 3,
                    col_types = cols(
                      X1 = col_character(),
                      X2 = col_integer(),
                      X3 = col_factor(levels = c("No", "Maybe", "Yes")),
                      X4 = col_factor(levels = c("No", "I am equally fluent in English and another language", "Yes")),
                      X5 = col_logical(),
                      X6 = col_factor(levels = likert_levels),
                      X7 = col_factor(levels = likert_levels),
                      X8 = col_factor(levels = likert_levels),
                      X9 = col_factor(levels = likert_levels),
                      X10 = col_factor(levels = likert_levels),
                      X11 = col_factor(levels = likert_levels),
                      X12 = col_factor(levels = likert_levels),
                      X13 = col_factor(levels = likert_levels),
                      X14 = col_factor(levels = likert_levels),
                      X15 = col_factor(levels = likert_levels),
                      X16 = col_factor(levels = likert_levels),
                      X17 = col_factor(levels = likert_levels),
                      X18 = col_factor(levels = likert_levels),
                      X19 = col_factor(levels = likert_levels),
                      X20 = col_factor(levels = likert_levels),
                      X21 = col_factor(levels = likert_levels),
                      X22 = col_factor(levels = likert_levels),
                      X23 = col_factor(levels = likert_levels),
                      X24 = col_factor(levels = likert_levels),
                      X25 = col_factor(levels = likert_levels),
                      X26 = col_factor(levels = likert_levels),
                      X27 = col_factor(levels = likert_levels),
                      X28 = col_factor(levels = likert_levels),
                      X29 = col_factor(levels = c("Female", "Male", "Other")),
                      X30 = col_factor(levels = c("Interested in women", "Interested in men",
                                                  "Interested in both/all", "Interested in neither/none",
                                                  "Other")))) 

# Merge waves of data
w1_post$wave <- as.integer(1)
w2_post$wave <- as.integer(2)

post <- bind_rows(w1_post, w2_post)

# Clean column names
colnames(post) <-
  c("id",
    "age",
    "recognizedStreamer",
    "firstLangEng",
    "complete",
    "IMI_Enjoyment.1",
    "IMI_Enjoyment.2",
    "IMI_Enjoyment.3",
    "IMI_Enjoyment.4",
    "IMI_Enjoyment.5",
    "IMI_Enjoyment.6",
    "IMI_Enjoyment.7",
    "PSI_Cognitive.1",
    "PSI_Cognitive.2",
    "PSI_Cognitive.3",
    "PSI_Cognitive.4",
    "PSI_Cognitive.5",
    "PSI_Cognitive.6",
    "PSI_Affective.1",
    "PSI_Affective.2",
    "PSI_Affective.3",
    "PSI_Behavioral.1",
    "PSI_Behavioral.2",
    "PSI_Behavioral.3",
    "playerSkill",
    "playerExp",
    "playerBetterThanAvg",
    "playerBetterThanViewer",
    "gender",
    "orientation",
    "wave")
          
# Remove incomplete responses
post <- post %>% filter(complete) %>% select(-complete)

# Clean up data types (convert Likert-type scales into numerics)
post <- post %>%  mutate_at(vars(matches("IMI|PSI|playerSkill|playerExp|playerBetterThan")), as.numeric)

# Clean up levels for some of the other factor variables
post$firstLangEng <- recode_factor(post$firstLangEng, `Yes`= "English", `No` = "Other", `I am equally fluent in English and another language` = "Equal")
post <- post %>% rename(firstLang = firstLangEng)

post$orientation <- recode_factor(post$orientation, `Interested in women` = "Women", `Interested in men` = "Men", `Interested in both/all` = "Both", `Interested in neither/none` = "None", `Other` = "Other")
