`%n%` <- function (x, y){
  if (is.null(x)) y else x  
}

#' @importFrom details details
#' @importFrom slackcalls upload_slack
#' @importFrom slackteams validate_channel
eng_slack <- function (options) {
  
  type <- options$type %n% "slack"

  options$type <- 'r'

  code <- details::details(eval(parse(text = options$code)), imgur = FALSE, output = 'character')

  code <- gsub('(^<details closed>\n\n)|(\\n\\n</details>\n<br>(.*?)$)','',code)
  code <- gsub('```r','``` r',code)
  
  output_code <- sprintf("chunk succesfully posted to: '%s'",options$channel)

  if(grepl('```',code)){
    
    reprex_block <- reprex_to_blocks(code)
    
    reprex_block <- classify_post(reprex_block, text = NULL, channel = options$channel)
    
    res_body <- post_reprex(block = reprex_block, channel = options$channel, text = NULL, token = options$token)
    
    
  }
  
  if(length(attr(code,'file'))>0){
    
    res_fig <- slackcalls::upload_slack(channels = slackteams::validate_channel(options$channel), token = options$token, file = attr(code,'file'), filename = 'output.R',filetype = 'png')
    
  }
    
  knitr::engine_output(options,code = options$code,out = output_code)

}

#' @importFrom stats setNames
register_eng_slack = function(envs, engine) {
  knitr::knit_engines$set(stats::setNames(lapply(envs, function(env) {
    function(options) {
      options$type = env
      engine(options)
    }
  }), envs))
}

.onLoad = function(lib, pkg) {
  register_eng_slack('slack', eng_slack)
}
