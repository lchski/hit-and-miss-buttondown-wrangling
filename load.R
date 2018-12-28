library(tidyverse)
library(lubridate)
library(readtext)

email_index <- read_csv("data/emails.csv")
email_index <- email_index %>%
  arrange(publish_date) %>%
  mutate(
    email_number = row_number(),
    publish_date = with_tz(time = publish_date, "America/Toronto")
  )

newsletters <- readtext("data/newsletters/*")
newsletters <- tibble(doc_id = newsletters$doc_id, subject = newsletters$doc_id, text = newsletters$text) %>%
  mutate(subject = gsub("^Hit and Miss #", "", subject)) %>%
  separate(subject, into = c("id", "subject"), sep = ": ") %>%
  mutate(id = parse_number(id)) %>%
  arrange(id) %>%
  inner_join(
    email_index %>% select(email_number, publish_date),
    by = c("id" = "email_number")
  )
