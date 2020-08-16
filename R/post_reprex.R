post_reprex <- function(block, channel, text = NULL, token = Sys.getenv('SLACK_API_TOKEN')){
  UseMethod('post_reprex')
}

post_reprex.no_thread <- function(block, channel, text = NULL, token = Sys.getenv('SLACK_API_TOKEN')){
  
  res <- slackblocks::post_block(
    channel = channel, 
    block   = block,
    token   = token
  )
  
  push_post(res)
  
  return(res)
}

post_reprex.new_thread <- function(block, channel, text = NULL, token = Sys.getenv('SLACK_API_TOKEN')){
  
  res1 <- slackblocks::post_block(
    channel = channel, 
    block   = slackblocks::block_text(text = text),
    token   = token
  )
  
  push_post(res1)
  
  res2 <- slackblocks::post_thread(
    res   = res1,
    block = block
  )
  
  push_post(res2)
  
  return(res2)
  
}

post_reprex.existing_thread <- function(block, channel, text = NULL, token = Sys.getenv('SLACK_API_TOKEN')){
  
  if(!is.null(text)){
    
    res1 <- slackblocks::post_block(
      channel = channel,
      thread_ts  = attr(channel,"thread_ts"),
      block   = slackblocks::block_text(text = text),
      token   = token
    )  
    
    push_post(res1)
    
  }
  
  res2 <- slackblocks::post_block(
    channel = channel,
    thread_ts  = attr(channel,"thread_ts"),
    block   = block,
    token   = token
  )
 
  push_post(res2)
  
  return(res2)
   
}
