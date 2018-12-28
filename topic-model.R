library(dfrtopics)
library(mallet)

source("load.R")

conf_num_topics <- 10
conf_num_runs <- 1000

instance_list <- mallet.import(newsletters$doc_id, newsletters$text, stoplist = "stoplist.txt")

m <- train_model(instance_list, n_topics=conf_num_topics,
                 n_iters=conf_num_runs,
                 n_hyper_iters=20,
                 n_burn_in = 50)

metadata(m) <- newsletters %>% mutate(pubdate = publish_date)
