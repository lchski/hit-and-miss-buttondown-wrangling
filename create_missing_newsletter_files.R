source("load.R")

missing_newsletters <- newsletters %>%
  filter(id > 47)

for (i in 1:nrow(missing_newsletters)) {
  newsletter <- missing_newsletters[i,]
  
  filename <- paste(sep = "-", date(newsletter$publish_date), newsletter$id)
  
  output <- c(
    "---",
    "layout: study--newsletter",
    paste0("title: '", newsletter$subject, "'"),
    paste0("number: '", newsletter$id, "'"),
    paste0("date: '", newsletter$publish_date, "'"),
    "published: true",
    "---",
    "",
    newsletter$text
  )
  
  writeLines(output, paste0("output/missing-newsletters/", filename, ".md"))
}
