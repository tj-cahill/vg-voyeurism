################################################################################
# GSR_CLEAN.R                                                                  #
# ============================================================================ #
# This script takes output from pre-processed GSR data in iMotions and cleans  #
# it up so that it's usable and readable for subsequent analysis, outputting   #
# as a CSV file.                                                               #
################################################################################

library(readr)
library(dplyr)

w1_gsr <- read_delim(
  "data/W1_GSRSummaryScore.tsv",
  "\t",
  escape_double = FALSE,
  col_types = cols(
    Age = col_integer(),
    `Duration (sec)` = col_skip(),
    Gender = col_factor(levels = c("FEMALE",
                                   "MALE")),
    Group = col_skip(),
    HasPeak = col_logical(),
    `Peak Detection Name` = col_skip(),
    PeakCount = col_integer(),
    RespondentName = col_character(),
    Segmentation = col_skip(),
    `Start-Stop (sec)` = col_skip(),
    `StimulusName/Scene` = col_character(),
    StudyName = col_skip()
  ),
  trim_ws = TRUE
)

w2_gsr <- read_delim(
  "data/W2_GSRSummaryScore.tsv",
  "\t",
  escape_double = FALSE,
  col_types = cols(
    Age = col_integer(),
    `Duration (sec)` = col_skip(),
    Gender = col_factor(levels = c("FEMALE",
                                   "MALE")),
    Group = col_skip(),
    HasPeak = col_logical(),
    `Peak Detection Name` = col_skip(),
    PeakCount = col_integer(),
    RespondentName = col_character(),
    Segmentation = col_skip(),
    `Start-Stop (sec)` = col_skip(),
    `StimulusName/Scene` = col_character(),
    StudyName = col_skip()
  ),
  trim_ws = TRUE
)

# Merge waves of data
w1_gsr$wave <- as.integer(1)
w2_gsr$wave <- as.integer(2)

gsr <- bind_rows(w1_gsr, w2_gsr)

# Clean column names
colnames(gsr) <-
  c("scene",
    "id",
    "gender",
    "age",
    "hasPeak",
    "peakCount",
    "peaksPerMin",
    "wave")

# Remove non-stimulus segments from data
gsr <- gsr %>% filter(!grepl('Survey', scene))

# Parse stimulus conditions into factors
gsr$stimGender <- factor('MALE', levels = c("FEMALE", "MALE"))
gsr$stimGender[grepl('female', gsr$scene)] <- factor('FEMALE')

gsr$stimFace <- FALSE
gsr$stimFace[grepl('facecam', gsr$scene)] <- TRUE

gsr$stimGame <- factor('PORTAL', levels = c("HITMAN", "PORTAL"))
gsr$stimGame[grepl('Hitman', gsr$scene)] <- factor("HITMAN")

gsr <- gsr %>% select(-scene)

# dedupe ------------------------------------------------------------------

# Clean up participant ID codes
gsr$id <- gsub("[^0-9.-]", "", gsr$id)
gsr$id <- gsub("(^|[^0-9])0+", "\\1", gsr$id, perl = TRUE)

# Participants 3304 and 3529 were identified as having likely participated in 
# both waves, in violation of study protocols >> manually remove records from
# the second wave for each

gsr <- gsr %>% filter(!((id == 3304 | id == 3529) & wave == 2))

# Participant codes 4993 and 5569 were accidentally re-used for different 
# participants >> recode IDs to avoid duplication

# Participants with code 4993 can be differentiated based on age, with new IDs
# manually assigned
gsr[gsr$id==4993 & gsr$age == 22, "id"] <- 9901
gsr[gsr$id==4993 & gsr$age == 19, "id"] <- 9902

# Participants with code 5569 have to be manually removed since there is no
# way to differentiate them
gsr <- gsr %>% filter(id != 5569)

# export ------------------------------------------------------------------

# Export clean and merged CSV file
write_csv(gsr, "data/GSR_merged.csv")