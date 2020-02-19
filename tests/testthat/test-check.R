testthat::context('reprex to blocks')

path <- '../assets'

no_fig <- reprex_to_blocks(
  reprex::reprex(input = file.path(path,'no_fig.R'),
                 venue = 'gh', 
                 advertise = FALSE, 
                 show = FALSE)
)

err <- reprex_to_blocks(
  reprex::reprex(input = file.path(path,'err.R'),
                 venue = 'gh', 
                 advertise = FALSE, 
                 show = FALSE)
)

fig <- reprex_to_blocks(
  reprex::reprex(input = file.path(path,'fig.R'),
                 venue = 'gh', 
                 advertise = FALSE, 
                 show = FALSE)
)

testthat::describe('class',{
  
   it('no_fig',{
     testthat::expect_true(inherits(no_fig,'blocks'))
   })
   
  it('err',{
    testthat::expect_true(inherits(err,'blocks'))
  })
  
  it('fig',{
    testthat::expect_true(inherits(fig,'blocks'))
  })
  
})

testthat::describe('element type',{
  
  it('no_fig',{
    testthat::expect_equal(no_fig[[1]]$text$type,'mrkdwn')
  })

  it('err',{
    testthat::expect_equal(err[[1]]$type,'context')
  })
    
  it('err emo',{
    testthat::expect_equal(err[[1]]$elements[[1]]$text,':rotating_light:')
  })
  
  it('fig',{
    testthat::expect_equal(fig[[2]]$type,'image')
  })
  
})
