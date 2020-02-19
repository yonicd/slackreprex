#' @title post reprex output to slack
#' @description Converts reprex output to slackblocks and 
#' posts the blocks to a slack conversation which can be a channel,
#' a direct message, a group message or a thread in one of them.
#' @param ... code to evaluate in reprex
#' @param text question text to attach to the reprex blocks
#' @param channel character, channel to post to
#' @param token Slack API token, Default: Sys.getenv("SLACK_API_TOKEN")
#' @return [response][httr::response] from slack api
#' @details channel can be on of the following in an activated team
#'   - name of channel
#'   - channel id
#'   - link to a message in a channel, direct message or a group message
#'   
#' @examples 
#' \dontrun{
#' if(interactive()){
#' 
#' # assumes '~/.slackteams' exists.
#' slackteams::load_team()
#' team <- slackteams::get_teams()[1]
#' slackteams::activate_team(team)
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
