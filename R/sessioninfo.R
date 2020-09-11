#' @title Post session info to Slack
#' @description Post sessioninfo to Slack as a snippet
#' @param channel character, channel to post to
#' @param ts character, Slack API time stamp, Default: NULL
#' @param initial_comment character, comment that precedes the snippet, Default: NULL
#' @param \dots arguments passed to sessioninfo::session_info() if installed else passed to sessionInfo()
#' @param token Slack API token, Default: Sys.getenv("SLACK_API_TOKEN")
#' @return [response][httr::response] from Slack api
#' @details 
#' `channel` can be on of the following in an activated team
#'   - name of channel
#'   - channel id
#'   - link to a message in a channel, direct message or a group message
#'   
#' A pairing of `channel` and `ts` can be used instead of a link to post to a thread.
#' @examples 
#' \dontrun{
#' if(interactive()){
#' 
#' post_sessioninfo(channel = 'slackbot')
#' 
#'  }
#' }
#' @rdname post_sessioninfo
#' @export 
#' @importFrom slackblocks prep_channel
#' @importFrom utils sessionInfo
#' @importFrom slackposts file_post
post_sessioninfo <- function(channel, ts = NULL, initial_comment = NULL, ..., token = Sys.getenv('SLACK_API_TOKEN')){
  
  chnl <- slackblocks::prep_channel(channel,ts)
  thread_ts <- NULL
  
  if(inherits(chnl,'slackpost')){
    channel <- chnl$channel
    thread_ts <- chnl$thread_ts
  }
  
  if(try(requireNamespace('sessioninfo',quietly = TRUE),silent = TRUE)){
    si <- prep_si(sessioninfo::session_info(...))
  }else{
    si <- prep_si(utils::sessionInfo(...))
  }

  on.exit({unlink(si)},add = TRUE)
  
  slackposts::file_post(
      token = token,
      file = si,
      filename = 'sessioninfo.R',
      filetype = 'r',
      title = 'session info',
      channels = channel,
      thread_ts = thread_ts,
      initial_comment = initial_comment
  )

}
