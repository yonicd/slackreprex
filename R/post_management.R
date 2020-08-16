.slack <- new.env()

push_post <- function(res){
  
  last_post <- list(list(ts = res$ts,
                         channel = res$channel))
  
  .slack$post_stack <- append(.slack$post_stack,last_post)
  
}

pop_post <- function(){
  .slack$post_stack[length(.slack$post_stack)] <- NULL
}


#' @title Manage Posts
#' @description Query/Remove posts created by slackreprex. Each post is logged 
#'   for channel and timestamp (ts) in an internal package environment. Which 
#'   serves the purpose of querying or removing specific posts. 
#'   - post_stack: lists in decreasing order the posts sent during the session.
#'   - last_post: retrieves the last post sent.
#'   - rm_last_post: deletes the last post from the specified channel.
#' @return NULL
#' @seealso [delete_post][slackcalls::delete_post]
#' @rdname post_manage
#' @export 
last_post <- function(){
  if(length(.slack$post_stack)==0){
    warning('No posts in stack')
    return(invisible(NULL))
  }
    
  .slack$post_stack[[length(.slack$post_stack)]]
}

#' @rdname post_manage
#' @export
post_stack <- function(){
  .slack$post_stack
}

#' @rdname post_manage
#' @importFrom slackcalls delete_post
#' @export
rm_last_post <- function(){
  lp <- last_post()
  if(is.null(lp)){
    return(invisible(NULL))
  }
  pop_post()
  slackcalls::delete_post(channel = lp$channel,ts = lp$ts)
}
