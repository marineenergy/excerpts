librarian::shelf(
  glue, here, stringr)
dir_repos   <- "/share/github"
dir_scripts <- glue("{dir_repos}/apps_dev/scripts")
source(glue("{dir_scripts}/common.R"))
source(glue("{dir_scripts}/db.R"))

do_ferc <- F
do_ba   <- T

if (do_ferc){
  rowids <- tbl(con, "ferc_docs") |>
    pull(rowid) |>
    sort()
  for (i in rowids){ # i = 1
    message(glue("i: {i}"))
    cmd <- glue("quarto render ferc_template.qmd -P id:{i} -o ferc_{i}.html")
    system(cmd) # i=1: 9:25pm # i=
  }
}

if (do_ba){
  rowids <- tbl(con, "ba_doc_excerpts") |>
    pull(rowid) |>
    sort()
  for (i in rowids){ # i = 1
    message(glue("i: {i}"))
    cmd <- glue("quarto render ba_template.qmd -P id:{i} -o ba_{i}.html")
    system(cmd) # i=1: 9:25pm # i=
  }
}
