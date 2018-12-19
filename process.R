library(tidyverse)
library(readtext)

email_index <- read_csv("data/emails.csv")

newsletters <- readtext("data/newsletters/*")
newsletters <- tibble(subject = newsletters$doc_id, text = newsletters$text) %>%
  mutate(subject = gsub("^Hit and Miss #", "", subject)) %>%
  separate(subject, into = c("id", "subject"), sep = ": ") %>%
  mutate(id = parse_number(id)) %>%
  arrange(id)
