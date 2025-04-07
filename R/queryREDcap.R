library(REDCapR)

uri <- "https://redcap.uk-erlangen.de/api/"
token <- "455C492B79046DDF4F56CCB0C1A1EE13"

data <- redcap_read(
  redcap_uri = uri,
  token = token,
  batch_size = 100,
  forms = c("Basic Examination")
)$data
