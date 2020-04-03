################################################################################
# DATA_MERGE.R                                                                 #
# ============================================================================ #
# This script takes the cleaned output from the *_clean.R scripts and merges   #
# them together into a single master dataset for all subsequent analysis.      #
################################################################################

library(readr)
library(dplyr)

# import ------------------------------------------------------------------
gender_levels <- c("FEMALE", "MALE", "OTHER")

qualtrics <- read_csv("data/Qualtrics_merged.csv", 
                      col_types = cols(id = col_character(),
                                       wave = col_integer(),
                                       gender = col_factor(levels = gender_levels),
                                       age = col_integer()))
gsr <- read_csv("data/GSR_merged.csv",
                col_types = cols(id = col_character(),
                                 wave = col_integer(),
                                 gender = col_factor(levels = gender_levels),
                                 age = col_integer()))
ret <- read_csv("data/RET_merged.csv",
                col_types = cols(id = col_character(),
                                 wave = col_integer(),
                                 gender = col_factor(levels = gender_levels),
                                 age = col_integer()))

# merge -------------------------------------------------------------------

# Clean up ID codes in the iMotions output data to be consistent with the 
# (parsed) participant IDs entered into Qualtrics
gsr$id <- gsub("[^0-9.-]", "", gsr$id)
gsr$id <- gsub("(^|[^0-9])0+", "\\1", gsr$id, perl = TRUE)
ret$id <- gsub("[^0-9.-]", "", ret$id)
ret$id <- gsub("(^|[^0-9])0+", "\\1", ret$id, perl = TRUE)

# Join together the three datasets, attempting to match on variables that
# (should be) the same in all instances of the same case while not losing 
# any data

imotions <- left_join(ret, gsr, by = c("id", "wave", 
                                  "gender", "age", 
                                  "stimGender", "stimFace", "stimGame"))

# Age is actually no longer useful since the age entered into iMotions may not
# be accurate (so we prefer the age self-reported in Qualtrics)
imotions <- imotions %>% select(-age)

all <- left_join(imotions, qualtrics, by = c("id", "wave",
                                        "gender"))

# dedupe ------------------------------------------------------------------

all <- all %>% distinct()