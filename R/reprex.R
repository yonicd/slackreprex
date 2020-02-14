#' @title FUNCTION_TITLE
#' @description FUNCTION_DESCRIPTION
#' @param ... PARAM_DESCRIPTION
#' @param text PARAM_DESCRIPTION
#' @param channel PARAM_DESCRIPTION
#' @param token PARAM_DESCRIPTION, Default: Sys.getenv("SLACK_API_TOKEN")
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples 
#' \dontrun{
#' if(interactive()){
#'  #EXAMPLE1
#'  }
#' }
#' @seealso 
#'  \code{\link[reprex]{reprex}}
#' @rdname slack_reprex
#' @export 
#' @importFrom slackblocks post_block post_thread
#' @importFrom reprex reprex
slack_reprex <- function(..., text = NULL, channel, token = Sys.getenv('SLACK_API_TOKEN')){
  
  rx <- reprex::reprex(
    ...,
    venue = 'gh',
    advertise = FALSE,
    show = FALSE)
  
  reprex_block <- reprex_to_blocks(rx)
  
  if(!is.null(text)){
    
    res <- slackblocks::post_block(
      channel = channel, 
      block   = slackblocks::block_text(text = text),
      token   = token
    )
    
    slackblocks::post_thread(
      res   = res,
      block = reprex_block
    )
    
  }else{

    slackblocks::post_block(
      channel = channel, 
      block   = reprex_block,
      token   = token
    )
        
  }

}
