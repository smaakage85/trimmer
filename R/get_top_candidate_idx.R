# get position index of top candidate.
get_top_candidate_idx <- function(dt, verbose = TRUE) {
  
  # extract size.
  size <- dt$size
  
  # extract all cols except 'size'.
  cols <- names(dt)[!names(dt) %in% "size"]
  
  dt <- dt[, ..cols, drop = FALSE]
  
  # get position index as vector.
  idx <- as.numeric(dt)
  # remove any NA's from position index.
  idx <- idx[!is.na(idx)]
  
  if (verbose) {
    cat_bullet("Trying to remove element [[", blue("c("),
               blue(paste0(idx, collapse = ",")), blue(")"), "]], element size = ", 
               blue(pf_obj_size(as.numeric(size))), sep = "", 
               bullet = "continue",bullet_col = "gray")
  }
  
  idx
  
}
