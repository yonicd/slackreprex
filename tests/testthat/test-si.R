testthat::context('sessioninfo')

si <- slackreprex:::prep_si.session_info(sessioninfo::session_info())

testthat::describe('sessioninfo classification',{
  
  it('file exists',{
     testthat::expect_true(file.exists(si))
  })
  
  it('file contents',{
    testthat::expect_equal(readLines(si)[1],expected = "--Session info----")
  })

})

sI <- slackreprex:::prep_si.sessionInfo(utils::sessionInfo())

testthat::describe('sessionInfo classification',{
  
  it('file exists',{
    testthat::expect_true(file.exists(sI))
  })
  
  it('file contents',{
    testthat::expect_true(grepl('^R version',readLines(sI)[1]))
  })
  
})

unlink(si)
unlink(sI)

