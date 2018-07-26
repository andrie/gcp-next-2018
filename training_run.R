library(tfruns)
library(dplyr)
setwd(here::here())
training_run("walking_experiments.R")

view_run()

ls_runs() %>% 
  as_tibble()

ls_runs(eval_acc > 0.95, order = eval_acc) %>% 
  as_tibble()

ls_runs(eval_acc > 0.95, order = eval_acc) %>% 
  as_tibble() %>% 
  head()


tfruns::training_run(
  "walking_flags.R",
  flags = list(
    conv_1_filters = 32,
    conv_1_kernel  = 8
  )
)


tfruns::training_run(
  "walking_flags.R",
  flags = list(
    conv_2_filters = 64,
    conv_2_kernel = 8
  )
)
