classify_post <- function(block, text, channel){

  action <- 'no_thread'
    
  if(inherits(channel,'post_default') & !is.null(text)){

    action <- 'new_thread'
      
  }
  
  if(inherits(channel,'post_thread')){
    
    action <- 'existing_thread'
    
  }
  
  structure(block, class = c(class(block),action))

}
