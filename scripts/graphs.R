library(tidyverse)

interviews_plotting <- read_csv("data_output/interviews_plotting.csv")

interviews_plotting <- interviews_plotting %>% 
  mutate(number_items = rowSums(select(., bicycle:television)))

table(interviews_plotting$number_items)

ggplot(data = interviews_plotting,
       aes(x = no_membrs, y = number_items)) +
  geom_point()

interview_plot <- ggplot(data = interviews_plotting,
        aes(x = no_membrs, y = number_items))
interview_plot + 
  geom_point(alpha = 0.5)

interview_plot +
  geom_jitter(alpha = 0.5, width = 0.25, height = 0, colour = "blue")
  
interview_plot +
  scale_colour_manual(values = c("purple", "blue", "green")) +
  geom_jitter(aes(colour = village), alpha = 0.5)
  
ggplot(data = interviews_plotting,
       aes(x = village, y = rooms)) +
  geom_jitter(aes(colour = respondent_wall_type), height = 0)

ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, y = rooms)) +
  geom_boxplot()

ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, y = rooms)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.5, colour = "tomato")

ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, y = rooms)) +
  geom_violin(alpha = 0) +
  geom_jitter(alpha = 0.5, colour = "tomato")

ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type, y = liv_count)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(aes(colour = memb_assoc), alpha = 0.5)

ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type)) +
  geom_bar()

ggplot(data = interviews_plotting,
       aes(x = respondent_wall_type)) +
  geom_bar(aes(fill = village))

ggplot(data = filter(interviews_plotting,
                     respondent_wall_type != "cement"),
       aes(x = respondent_wall_type)) +
  geom_bar(aes(fill = village), position = "dodge", alpha = 0.5)

percent_wall_type <- interviews_plotting %>% 
  filter(respondent_wall_type != "cement") %>% 
  count(village, respondent_wall_type) %>% 
  group_by(village) %>% 
  mutate(percent = n / sum(n)) %>% 
  ungroup()

ggplot(percent_wall_type,
       aes(x = village, y = percent, fill = respondent_wall_type)) +
  geom_bar(position = "dodge", stat = "identity") +
  scale_y_continuous(labels = scales::percent) +
  ylab("Percent") +
  xlab("Village") +
  ggtitle("Proportion of wall type by village")

ggplot(percent_wall_type,
       aes(x = respondent_wall_type, y = percent)) +
  geom_bar(stat = "identity", position = "dodge") +
  ylab("Percent") +
  xlab("Wall Type") +
  ggtitle("Proportion of wall type by village") +
  facet_wrap(~ village) +
  theme_bw() +
  theme(panel.grid = element_blank())

percent_items <- interviews_plotting %>% 
  gather(items, items_owned_logical, bicycle:no_list_items) %>% 
  filter(items_owned_logical)

