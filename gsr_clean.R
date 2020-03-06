library(readr)
library(dplyr)

w1_gsr <- read_delim("data/W1_GSRSummaryScore.tsv", 
                     "\t", escape_double = FALSE, col_types = cols(Age = col_integer(), 
                                                                   `Duration (sec)` = col_skip(), Gender = col_factor(levels = c("FEMALE", 
                                                                                                                                 "MALE")), 
                                                                   Group = col_skip(), 
                                                                   HasPeak = col_logical(), `Peak Detection Name` = col_skip(), 
                                                                   PeakCount = col_integer(), RespondentName = col_character(), 
                                                                   Segmentation = col_skip(), `Start-Stop (sec)` = col_skip(), 
                                                                   `StimulusName/Scene` = col_character(), 
                                                                   StudyName = col_skip()), trim_ws = TRUE)

w2_gsr <- read_delim("data/W2_GSRSummaryScore.tsv", 
                     "\t", escape_double = FALSE, col_types = cols(Age = col_integer(), 
                                                                   `Duration (sec)` = col_skip(), Gender = col_factor(levels = c("FEMALE", 
                                                                                                                                 "MALE")), 
                                                                   Group = col_skip(), 
                                                                   HasPeak = col_logical(), `Peak Detection Name` = col_skip(), 
                                                                   PeakCount = col_integer(), RespondentName = col_character(), 
                                                                   Segmentation = col_skip(), `Start-Stop (sec)` = col_skip(), 
                                                                   `StimulusName/Scene` = col_character(), 
                                                                   StudyName = col_skip()), trim_ws = TRUE)


# Remove non-stimulus segments from data

