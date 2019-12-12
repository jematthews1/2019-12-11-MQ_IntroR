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

interviews
interviews_select <- select(interviews, village, no_membrs, years_liv)

filter(interviews, village == "God")

interviews2 <- filter(interviews, village == "God")
interviews_god <- select(interviews2, no_membrs, years_liv)

interviews_god <- select(filter(interviews, village == "God"), no_membrs,
                         years_liv)
interviews_god
pipe -> %>% (don't run this')

interviews_god <- interviews %>%
  filter(village == "God") %>%
  select(no_membrs, years_liv)

interviews_new <- interviews %>%
  mutate(people_per_room = no_membrs / rooms)

interviews_new$people_per_room

interviews_filter <- interviews %>%
  filter(!is.na(memb_assoc)) %>%
  mutate(people_per_room = no_membrs / rooms)
interviews_filter

#---------------------------------
interviews %>%
  group_by(village, respondent_wall_type) %>%
  # group_by(respondent_wall_type) %>%
  summarise(mean_no_membrs = mean(no_membrs))

interviews %>%
  filter(!is.na(memb_assoc)) %>%
  group_by(village, memb_assoc) %>%
  summarise(mean_no_membrs = mean(no_membrs),
            min_membrs = min(no_membrs))

interviews %>%
  filter(!is.na(memb_assoc)) %>% 
  group_by(village, memb_assoc) %>%
  summarise(mean_no_membrs = mean(no_membrs),
            min_membrs = min(no_membrs)) %>%
  arrange(desc(min_membrs))

interviews %>%
  count(village)

interviews_spread <- interviews %>%
  mutate(wall_type_logical = TRUE) %>%
  spread(key = respondent_wall_type, value = wall_type_logical,
         fill = "I don't know")
interviews_spread

interviews_gather <- interviews_spread %>%
  gather(key = respondent_wall_type, value = "wall_type_logical",
         burntbricks:sunbricks) %>%
  # filter(wall_type_logical) %>%
  select(-wall_type_logical)

interviews_item_owned <- interviews %>%
  mutate(split_items = str_split(items_owned, ";")) %>%
  unnest(cols = c(split_items)) %>%
  mutate(items_owned_logical = TRUE) %>%
  spread(key = split_items, value = items_owned_logical,
         fill = FALSE)
 interviews_item_owned <- interviews_item_owned %>% 
   rename(no_list_items = '<NA>')

interviews_item_owned %>%
  filter(bicycle) %>%
  group_by(village) %>%
  count(bicycle)

write_csv(interviews_item_owned, path = "data_output/interviews_plotting.csv")
 
 
 

