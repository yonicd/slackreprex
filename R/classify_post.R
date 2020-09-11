classify_post <- function(block, text, channel){

  action <- 'no_thread'
    
  if(inherits(channel,'character') & !is.null(text)){

    action <- 'new_thread'
      
  }
  
  if(inherits(channel,'slackpost')){
    
    action <- 'existing_thread'
    
  }
  
  structure(block, class = c(class(block),action))

}
