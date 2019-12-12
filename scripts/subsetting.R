library(tidyverse)

interviews <- read_csv("data/SAFI_clean.csv", na = "NULL")
head(interviews$memb_assoc)

interviews
interviews[1, 4]
interviews[3, ]
interviews[, 4]
interviews[1:3, 4]
1:3
tail(interviews[, 4], 3)
nrow(interviews)
ncol(interviews)
dim(interviews)

interviews[1:4, 10:ncol(interviews)]
interviews[, -4]
interviews[, -4:-6]

head_interviews <- interviews[1:6, ]
head_interviews

interviews[c(1, 3, 5), ]
interviews$no_membrs
interviews[, "no_membrs"]
