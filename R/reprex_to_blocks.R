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
  
  rx_chr_raw <- x[nzchar(x)]
  
  rx_chr <- split_blocks(rx_chr_raw)
  
  rx_txt_mat <- matrix(c(grep('^``` r',rx_chr),grep('```$',rx_chr)),ncol=2) 
  
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
      txt <- paste0(y,collapse = '\n')
      
      slackblocks::section_block(text = slackblocks::block_text(txt))
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

document_to_blocks <- function(x){
  
  if(length(x)==1&utils::file_test(op = '-f',x = x))
    x <- readLines(x)
  
  rx_chr <- x[nzchar(x)]
  
  rx_txt <- grep('^```',rx_chr)
  
  rx_txt_mat <- matrix(rx_txt,ncol=2,byrow = TRUE)
  
  rx_txt_list <- split(rx_txt_mat, 1:nrow(rx_txt_mat))
  
  rx_txt_idx <- lapply(unname(rx_txt_list),function(x) x[1]:x[2])
  
  rx_txts <- lapply(rx_txt_idx,function(x){
    y <- rx_chr[x]
    y <- gsub('^```\\s*r','```',y)
    
    slackblocks::section_block(text = slackblocks::block_text(paste0(y,collapse = '\n') ))
    
  })
  
  rx_combine_idx <- rx_txt_idx 
  rx_combine <- rx_txts
  
  rx_img_idx <- as.list(grep('^!\\[\\]',rx_chr))
  
  if(length(rx_img_idx)>0){
    
    rx_imgs <- lapply(rx_img_idx,function(x){
      slackblocks::image_element(url = gsub('^!\\[\\]\\(|\\)','',rx_chr[x]))
    })
    
    rx_combine_idx <- c(rx_combine_idx,rx_img_idx)
    rx_combine <- c(rx_txts,rx_imgs)
    
    rx_order <- order(unlist(lapply(rx_combine_idx,max)))
    rx_combine <- rx_combine[rx_order]
    
  }
  
  slackblocks::as.blocks(rx_combine)
}

split_blocks <- function(rx_chr_raw){
  
  rx_chr <- c()
  for(i in seq_along(rx_chr_raw)){
    x_split <- strsplit(rx_chr_raw[i], "(?<=.{2000})", perl = TRUE)[[1]]
    if(length(x_split)>1){
      x_split <- sapply(x_split,pad_ticks,USE.NAMES = FALSE)
      rx_chr[length(rx_chr)] <- pad_ticks(rx_chr[length(rx_chr)],side = 'tail')
      rx_chr_raw[i+1] <- pad_ticks(rx_chr_raw[i+1],'head')
    }
    rx_chr <- c(rx_chr,x_split)
  }
  
  rx_chr
}

pad_ticks <- function(x,side = c('head','tail')){

if('head'%in%side){
  
if(!grepl('^```',x)){
  x <- sprintf('``` r\n%s',x)
}}

if('tail'%in%side){
if(!grepl('```$',x)){
  x <- sprintf('%s ```',x)
}
}
  
  x
}
