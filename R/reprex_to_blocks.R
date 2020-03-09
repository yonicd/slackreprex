#' @title Convert reprex output to slack blocks
#' @description Convert reprex output to slackblocks with text and figure
#' links if relevant
#' @param x reprex output
#' @return slackblocks
#' @details If a reprex chunk contains an error an rotating_light
#'  emoji will be attacheted to the textblock.
#' @examples 
#' \dontrun{
#' if(interactive()){
#' 
#' reprex_to_blocks(
#'    reprex::reprex({
#'       x <- 10
#'       x + 2
#'    },
#'    venue = 'gh', 
#'    advertise = FALSE, 
#'    show = FALSE)
#'  )
#' 
#' # with plot
#' reprex_to_blocks(
#'    reprex::reprex({
#'       x <- 10
#'       hist(runif(x))
#'    },
#'    venue = 'gh', 
#'    advertise = FALSE, 
#'    show = FALSE)
#'  )
#' 
#' # with error
#'  reprex_to_blocks(
#'    reprex::reprex({
#'       x <- 10
#'       hist(runif(2*y))
#'    },
#'    venue = 'gh', 
#'    advertise = FALSE, 
#'    show = FALSE)
#'  )
#'  
#'  }}
#' @rdname reprex_to_blocks
#' @export 
#' @importFrom slackblocks context_block block_text section_block image_element as.blocks
reprex_to_blocks <- function(x){
  
  rx_chr <- x[nzchar(x)]
  
  rx_txt <- grep('^```',rx_chr)
  
  rx_txt_mat <- matrix(rx_txt,ncol=2,byrow = TRUE)
  
  rx_txt_list <- split(rx_txt_mat, 1:nrow(rx_txt_mat))
  
  rx_txt_idx <- lapply(unname(rx_txt_list),function(x) x[1]:x[2])
  
  rx_txts <- lapply(rx_txt_idx,function(x){
    y <- rx_chr[x]
    y <- gsub('^``` r','```',y)
    
    if(any(grepl('^#> Error',y))){
      slackblocks::context_block(elements = list(
        slackblocks::block_text(text = ':rotating_light:'),
        slackblocks::block_text(paste0(y,collapse = '\n'))
      ))
    }else{
      slackblocks::section_block(text = slackblocks::block_text(paste0(y,collapse = '\n') ))  
    }
    
    
  })
  
  rx_combine_idx <- rx_txt_idx 
  rx_combine <- rx_txts
  
  rx_img_idx <- as.list(grep('^!\\[\\]',rx_chr))
  
  if(length(rx_img_idx)>0){
    
    rx_imgs <- lapply(rx_img_idx,function(x){
      slackblocks::image_element(gsub('^!\\[\\]\\(|\\)','',rx_chr[x]))
    })
    
    rx_combine_idx <- c(rx_combine_idx,rx_img_idx)
    rx_combine <- c(rx_txts,rx_imgs)
    
    rx_order <- order(unlist(lapply(rx_combine_idx,max)))
    rx_combine <- rx_combine[rx_order]
    
  }
  
  slackblocks::as.blocks(rx_combine)
}
