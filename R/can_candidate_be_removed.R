can_candidate_be_removed <- function(obj,
                                     obj_arg_name,
                                     idx, 
                                     results_init, 
                                     fun, 
                                     tolerate_warnings,
                                     ...) {
  
  # remove entry in list.
  obj[[idx]] <- NULL
  
  # compute results with object after removal.
  results <- get_results_for_object(obj, obj_arg_name, fun, 
                                    tolerate_warnings = tolerate_warnings, ...) 
  
  # were errors encountered?
  if (inherits(results, "error")) {
    return(FALSE)
  }
  
  # were warnings encountered?
  if (!tolerate_warnings && inherits(results, "warning")) {
    return(FALSE)
  }
  
  # check if results are identical.
  identical(results_init, results)
  
}