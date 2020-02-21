prep_si <- function(x, file = tempfile(fileext = '.R')){
  UseMethod('prep_si')
}

#' @importFrom utils capture.output
prep_si.sessionInfo <- function(x, file = tempfile(fileext = '.R')){
  
  cat(utils::capture.output(print(x)),sep = '\n', file = file)
  
  file
  
}


prep_si.session_info <- function(x, file = tempfile(fileext = '.R')){
  
  x <- as.character(x)
  
  x[grepl('(Session info)|(Packages)',x)] <- c('--Session info----','--Packages----')
  
  cat(x,sep = '\n', file = file)
  
  file
  
}
