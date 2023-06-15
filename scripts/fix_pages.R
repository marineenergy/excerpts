librarian::shelf(
  dplyr, fs, glue, here, stringr)

# move docs/ferc_*.html ----
dir_docs <- here("docs")

d <- tibble(
  f_old = dir_ls(dir_docs)) |>
  filter(
    str_detect(f_old, "ferc_[0-9]+\\.html")) |>
  mutate(
    num   = str_replace(f_old, "^(.*ferc_)([0-9]+)\\.html$", "\\2") |> as.integer(),
    f_new = glue("{dir_docs}/ferc_{num}.html"))
file_move(d$f_old, d$f_new)

# search.json: fix docs/ferc_*.html ----
search_json <- glue("{dir_docs}/search.json")

readLines(search_json) |>
  str_replace_all("ferc_0+", "ferc_") |>
  writeLines(search_json)

