post_reprex <- function(block, channel, text = NULL, token = Sys.getenv('SLACK_API_TOKEN')){
  UseMethod('post_reprex')
}

post_reprex.no_thread <- function(block, channel, text = NULL, token = Sys.getenv('SLACK_API_TOKEN')){
  
  slackblocks::post_block(
    channel = channel, 
    block   = block,
    token   = token
  )
  
}

post_reprex.new_thread <- function(block, channel, text = NULL, token = Sys.getenv('SLACK_API_TOKEN')){
  
  res <- slackblocks::post_block(
    channel = channel, 
    block   = slackblocks::block_text(text = text),
    token   = token
  )
  
  slackblocks::post_thread(
    res   = res,
    block = block
  )
  
}

post_reprex.existing_thread <- function(block, channel, text = NULL, token = Sys.getenv('SLACK_API_TOKEN')){
  
  if(!is.null(text)){
    
    slackblocks::post_block(
      channel = channel,
      thread_ts  = attr(channel,"thread_ts"),
      block   = slackblocks::block_text(text = text),
      token   = token
    )    
    
  }
  
  slackblocks::post_block(
    channel = channel,
    thread_ts  = attr(channel,"thread_ts"),
    block   = block,
    token   = token
  )
  
}
