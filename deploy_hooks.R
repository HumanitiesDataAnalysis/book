

library(purrr)
library(stringr)
library(readr)

problem_set_template = "\n---\ntitle: <<f>>\noutput: docx\n...\n\n\n```{r, include = FALSE}\nlibrary(tidyverse)\nlibrary(HumanitiesDataAnalysis)\nknitr::opts_chunk$set(eval=FALSE)\n```\n<<paste(lines, collapse='\n')>>\n"

completed = 0

extract_problem_section = function(f) {
  message(f)
  lines = read_lines(f)
  match = lines %>% str_which("## Exercise")
  if (length(match)==0) {
    message("No lines for ", f)
  } else {
    completed <<- completed + 1
    lines = lines[match:length(lines)]
    text = str_glue(problem_set_template, .open = "<<", .close = ">>")
    write_lines(text, path = paste0("extracted_problem_sets/", completed, "-", f))
  }
}

extract_problems = function() {

  fs = yaml::yaml.load_file("_bookdown.yml")$rmd_files
  message(fs)
  fs %>% map(extract_problem_section)
}

silent = extract_problems()
