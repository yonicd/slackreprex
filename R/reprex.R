#' @title post reprex output to slack
#' @description Converts reprex output to slackblocks and 
#' posts the blocks to a slack conversation which can be a channel,
#' a direct message, a group message or a thread in one of them.
#' @param ... code to evaluate in reprex
#' @param text question text to attach to the reprex blocks
#' @param channel character, channel to post to
#' @param ts character, Slack API time stamp, Default: NULL
#' @param token Slack API token, Default: Sys.getenv("SLACK_API_TOKEN")
#' @return [response][httr::response] from slack api
#' @details 
#' `channel` can be on of the following in an activated team
#'   - name of channel
#'   - channel id
#'   - link to a message in a channel, direct message or a group message
#'   
#' A pairing of `channel` and `ts` can be used instead of a link to post to a thread.
#'   
#' @examples 
#' \dontrun{
#' if(interactive()){
#' 
#' slack_reprex({
#'   x <- 10
#'   hist(runif(x))
#'   hist(runif(2*y))
#' },
#' text = 'My question is ... ',
#' channel = 'slackbot')
#'  }
#' }
#' @seealso  [reprex][reprex::reprex]
#' @rdname slack_reprex
#' @export 
#' @importFrom slackblocks post_block prep_channel
#' @importFrom reprex reprex
slack_reprex <- function(..., text = NULL, channel = NULL, ts = NULL, token = Sys.getenv('SLACK_API_TOKEN')){
  
  rx <- reprex::reprex(
    ...,
    venue = 'gh',
    advertise = FALSE,
    show = is.null(channel))
  
  if(is.null(channel)){
   return(invisible(rx)) 
  }
  
  channel <- slackblocks::prep_channel(channel,ts)
  
  reprex_block <- reprex_to_blocks(rx)
  
  reprex_block <- classify_post(reprex_block, text, channel)

  post_reprex(block = reprex_block, channel = channel, text = text, token = token)

}
