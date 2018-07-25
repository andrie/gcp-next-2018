# devtools::install_github("rstudio/cloudml")
# cloudml::gcloud_install()
# cloudml::gcloud_init()

# Then navigate to the CloudML console:
# https://console.cloud.google.com/mlengine/


library(here)

setwd(here("cloudml"))

library(dplyr)

# Upload the data to storage bucket using storage browser
# https://console.cloud.google.com/storage/browser
# Also see instructions at
# https://tensorflow.rstudio.com/tools/cloudml/articles/storage.html


id <- "cloudml_2018_07_25_033119663"


trials <- job_trials(id) %>% 
  as_tibble() %>% 
  select(-one_of("hyperparameters.data_dir"))
trials
View(trials)

trials_clean <- job_trials(id) %>% 
  as_tibble() %>% 
  select(-one_of("hyperparameters.data_dir")) %>% 
  mutate_at(vars(starts_with("hyperParameters")), round, 2) %>% 
  rename_all(~sub("finalMetric.", "", .)) %>% 
  rename_all(~sub("hyperparameters.", "", .)) %>% 
  select(-c(trainingStep)) %>% 
  select(trialId, everything()) %>% 
  arrange(desc(objectiveValue))

trials_clean

library(ggplot2)
trials_clean %>% 
  ggplot(aes(x = trialId, y = objectiveValue)) +
  geom_point() +
  stat_smooth(method = "lm") +
  theme_bw(16) + 
  xlab("Trial ID") +
  ylab("Validation Accuracy")

job_collect(job = id, trials = "best")


cloudml::cloudml_deploy()
cloudml_deploy("runs/cloudml_2018_07_25_033119663-06", name = "walking_01")
