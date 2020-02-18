
<!-- README.md is generated from README.Rmd. Please edit that file -->

# slackreprex

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![R-win build
status](https://github.com/yonicd/slackreprex/workflows/R-win/badge.svg)](https://github.com/yonicd/slackreprex)
[![R-mac build
status](https://github.com/yonicd/slackreprex/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackreprex)
[![R-linux build
status](https://github.com/yonicd/slackreprex/workflows/R-linux/badge.svg)](https://github.com/yonicd/slackreprex)
[![Covrpage
Summary](https://img.shields.io/badge/covrpage-Last_Build_2020_02_06-brightgreen.svg)](http://tinyurl.com/tf2xf4d)
<!-- badges: end -->

`slackreprex` is a part of `slackverse`

|                                                                                                                                 |                                                                                                                                     |                                                                                                                                    |
| :-----------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------------------------------: |
|                                                                                                                                 | slackcalls<br>[![](https://github.com/yonicd/slackcalls/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackcalls)<br>↙️⬇️↘️ |                                                                                                                                    |
| slackthreads<br>[![](https://github.com/yonicd/slackthreads/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackthreads) |  slackteams<br>[![](https://github.com/yonicd/slackteams/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackteams)<br>⬅️➡️  | slackblocks<br>[![](https://github.com/yonicd/slackblocks/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackblocks)<br>⬇️ |
|                                                                                                                                 |                                                                                                                                     |    slackreprex<br>[![](https://github.com/yonicd/slackreprex/workflows/R-mac/badge.svg)](https://github.com/yonicd/slackreprex)    |

The goal of `slackreprex` is to post reprex outputs to Slack using
`slackblocks`.

## Installation

``` r
# install.packages("remotes")
remotes::install_github("yonicd/slackreprex")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(slackreprex)
library(magrittr)
```

``` r
slackteams::load_team_dcf(team = 'r4ds')
slackteams::activate_team('r4ds')
```

``` r
slack_reprex({
  x <- 10
  hist(runif(x))
  hist(runif(2*y))
},
text = 'My question is ...) ',
channel = 'yonicd')
```

<img src="man/figures/plot_example.png" width="100%" />

## Reprex Under the Hood

### Convert reprex `gh` output to slack blocks

``` r
reprex_block <- reprex::reprex({
x <- 10
hist(runif(x))
hist(runif(2*y))
},
venue = 'gh', advertise = FALSE, show = FALSE)%>%
reprex_to_blocks()
#> Rendering reprex...
```

    #> [
    #>   {
    #>     "type": "section",
    #>     "text": {
    #>       "type": "mrkdwn",
    #>       "text": "```\nx <- 10\nhist(runif(x))\n```"
    #>     }
    #>   },
    #>   {
    #>     "type": "image",
    #>     "image_url": "https://i.imgur.com/sVHQqTV.png",
    #>     "alt_text": "image"
    #>   },
    #>   {
    #>     "type": "context",
    #>     "elements": [
    #>       {
    #>         "type": "mrkdwn",
    #>         "text": ":rotating_light:"
    #>       },
    #>       {
    #>         "type": "mrkdwn",
    #>         "text": "```\nhist(runif(2*y))\n#> Error in runif(2 * y): object 'y' not found\n```"
    #>       }
    #>     ]
    #>   }
    #> ]

### post the blocks

``` r
reprex_block%>%
  slackblocks::post_block(
    channel = 'yonicd'
  )
```

### Post with a question and attach the reprex into a thread.

``` r
q_txt <- slackblocks::block_text(
  text = 'My Question is ...'
)
```

    #> {
    #>   "type": "mrkdwn",
    #>   "text": "My Question is ..."
    #> }

``` r

q_txt%>%
slackblocks::post_block(
  channel = 'yonicd'
    )%>%
slackblocks::post_thread(
  block = reprex_block
)
```
