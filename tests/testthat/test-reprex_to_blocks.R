# Set up tests. ----------------------------------------------------------------
# While this *could* go into a setup.R file, that makes interactive testing
# annoying. I compromised and put it in a collapsible block at the top of each
# test file.

# To test the API:

# Sys.setenv(SLACK_API_TEST_MODE = "true")

# To capture test data:

# Sys.setenv(SLACK_API_TEST_MODE = "capture")

# To go back to a "normal" mode:

# Sys.unsetenv("SLACK_API_TEST_MODE")

slack_api_test_mode <- Sys.getenv("SLACK_API_TEST_MODE")
withr::defer(rm(slack_api_test_mode))

library(httptest)

# All tests use #slack-r on slackr-test (or a mocked version of it).
slack_test_channel <- "CNTFB9215"
withr::defer(rm(slack_test_channel))
sleep_secs <- 0L
withr::defer(rm(sleep_secs))

if (slack_api_test_mode == "true" || slack_api_test_mode == "capture") {
  # In these modes we need a real API token. If one isn't set, this should throw
  # an error right away.
  if (Sys.getenv("SLACK_API_TOKEN") == "") {
    stop(
      "No SLACK_API_TOKEN available, cannot test. \n",
      "Unset SLACK_API_TEST_MODE to use mock.")
  }
  sleep_secs <- 1L
  
  if (slack_api_test_mode == "true") {
    # Override the main mock function from httptest, so we use the real API.
    with_mock_api <- force
  } else {
    # This tricks httptest into capturing results instead of actually testing.
    with_mock_api <- httptest::capture_requests
  }
  withr::defer(rm(with_mock_api))
}

# Set up assets. ---------------------------------------------------------------

# Set up test files in a tempdir so renders will be deleted when it's done.
assets_path <- fs::dir_copy(test_path("assets"), tempdir())
withr::defer(
  unlink(assets_path, recursive = TRUE)
)

# Tests. -----------------------------------------------------------------------

test_that("reprex_to_blocks works", {
  reprex_output_no_fig <- reprex::reprex_slack(
    input = fs::path(assets_path, "no_fig.R"),
    advertise = FALSE,
    html_preview = FALSE
  )
  
  reprex_output_fig <- reprex::reprex_slack(
    input = fs::path(assets_path, "fig.R"),
    advertise = FALSE,
    html_preview = FALSE
  )
})

no_fig <- reprex_to_blocks(
  reprex::reprex(input = test_path("assets", "no_fig.R"),
                 venue = 'gh', 
                 advertise = FALSE, 
                 show = FALSE)
)

err <- reprex_to_blocks(
  reprex::reprex(input = test_path("assets", "err.R"),
                 venue = 'gh', 
                 advertise = FALSE, 
                 show = FALSE)
)

fig <- reprex_to_blocks(
  reprex::reprex(input = test_path("assets", "fig.R"),
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
