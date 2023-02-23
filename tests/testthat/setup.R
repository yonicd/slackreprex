# When we're in capture mode, clear out previous captures.

if (Sys.getenv("SLACK_API_TEST_MODE") == "capture") {
  if (Sys.getenv("SLACK_API_TOKEN") == "") {
    stop(
      "No SLACK_API_TOKEN available, cannot capture results. \n",
      "Unset SLACK_API_TEST_MODE to use mock.")
  }
  unlink(test_path("slack.com"), recursive = TRUE)
}
