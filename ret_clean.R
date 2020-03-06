library(readr)
library(dplyr)

w1_ret <- read_table2(
  "data/W1_MovingAOIResult.tsv",
  col_names = FALSE,
  col_types = cols(
    X1 = col_skip(),
    X11 = col_integer(),
    X12 = col_skip(),
    X14 = col_double(),
    X15 = col_double(),
    X16 = col_double(),
    X17 = col_double(),
    X18 = col_skip(),
    X19 = col_skip(),
    X2 = col_skip(),
    X20 = col_skip(),
    X21 = col_double(),
    X25 = col_skip(),
    X26 = col_skip(),
    X3 = col_skip(),
    X4 = col_skip(),
    X5 = col_character(),
    X6 = col_skip(),
    X9 = col_character()
  ),
  skip = 11
)

w2_ret <- read_table2(
  "data/W2_MovingAOIResult.tsv",
  col_names = FALSE,
  col_types = cols(
    X1 = col_skip(),
    X11 = col_integer(),
    X12 = col_skip(),
    X14 = col_double(),
    X15 = col_double(),
    X16 = col_double(),
    X17 = col_double(),
    X18 = col_skip(),
    X19 = col_skip(),
    X2 = col_skip(),
    X20 = col_skip(),
    X21 = col_double(),
    X25 = col_skip(),
    X26 = col_skip(),
    X3 = col_skip(),
    X4 = col_skip(),
    X5 = col_character(),
    X6 = col_skip(),
    X9 = col_character()
  ),
  skip = 11
)


# Merge waves of data
w1_ret$wave <- as.integer(1)
w2_ret$wave <- as.integer(2)
ret <- bind_rows(w1_ret, w2_ret)

# Add column names for all non-empty columns
colnames(ret) <-
  c(
    "stimGame",
    "stimGender",
    "stimFace",
    "respondent",
    "gender",
    "age",
    "aoi",
    "aoiDuration",
    "hitTime",
    "timeSpentG",
    "perSpentG",
    "revisitCountG",
    "ttfF",
    "timeSpentF",
    "perSpentF",
    "revisitCountF",
    "fixCount",
    "wave"
  )

# Clean up data types
ret <-
  ret %>% mutate(
    stimGame = factor(
      stimGame,
      levels = c("Hitman", "Portal"),
      labels = c("HITMAN", "PORTAL")
    ),
    stimGender = factor(
      stimGender,
      levels = c("female", "male"),
      labels = c("FEMALE", "MALE")
    ),
    stimFace = as.logical(grepl('facecam', stimFace)),
    gender = factor(
      gender,
      levels = c("Female", "Male"),
      labels = c("FEMALE", "MALE")
    ),
    aoi = factor(
      aoi,
      levels = c("Game", "Face"),
      labels = c("GAME", "FACE")
    )
  )

# Export clean and merged CSV file
write_csv(ret, "data/RET_merged.csv")