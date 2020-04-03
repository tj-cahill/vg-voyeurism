################################################################################
# DATA_MERGE.R                                                                 #
# ============================================================================ #
# This script takes the cleaned output from the *_clean.R scripts and merges   #
# them together into a single master dataset for all subsequent analysis.      #
################################################################################

library(readr)
library(dplyr)

# import ------------------------------------------------------------------
qualtrics <- read_csv("data/Qualtrics_merged.csv", 
                      col_types = cols(id = col_character()))
gsr <- read_csv("data/GSR_merged.csv")
ret <- read_csv("data/RET_merged.csv")

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

all <- left_join(ret, gsr, by = c("id", "wave", 
                                  "gender", "age", 
                                  "stimGender", "stimFace", "stimGame"))

all <- left_join(all, qualtrics, by = c("id", "wave"))
