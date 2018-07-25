# devtools::install_github("rstudio/cloudml")
# cloudml::gcloud_install()
# cloudml::gcloud_init()

# Then navigate to the CloudML console:
# https://console.cloud.google.com/mlengine/


library(here)

setwd(here("cloudml"))

library(cloudml)

# Upload the data to storage bucket using storage browser
# https://console.cloud.google.com/storage/browser
# Also see instructions at
# https://tensorflow.rstudio.com/tools/cloudml/articles/storage.html


cloudml_train("walking_cloudml.R", 
              master_type = "standard_gpu",
              collect = TRUE, 
              config = "tuning.yml"
)
