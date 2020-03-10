Tests and Coverage
================
10 March, 2020 13:55:05

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                            | Coverage (%) |
| :------------------------------------------------ | :----------: |
| slackreprex                                       |    30.43     |
| [R/classify\_post.R](../R/classify_post.R)        |     0.00     |
| [R/engine.R](../R/engine.R)                       |     0.00     |
| [R/post\_reprex.R](../R/post_reprex.R)            |     0.00     |
| [R/reprex.R](../R/reprex.R)                       |     0.00     |
| [R/sessioninfo.R](../R/sessioninfo.R)             |     0.00     |
| [R/prep\_si.R](../R/prep_si.R)                    |    85.71     |
| [R/reprex\_to\_blocks.R](../R/reprex_to_blocks.R) |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                  | n |  time | error | failed | skipped | warning |
| :------------------------------------ | -: | ----: | ----: | -----: | ------: | ------: |
| [test-check.R](testthat/test-check.R) | 7 | 0.045 |     0 |      0 |       0 |       0 |
| [test-si.R](testthat/test-si.R)       | 4 | 0.005 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                      | context          | test                                      | status | n |  time |
| :---------------------------------------- | :--------------- | :---------------------------------------- | :----- | -: | ----: |
| [test-check.R](testthat/test-check.R#L29) | reprex to blocks | class: no\_fig                            | PASS   | 1 | 0.039 |
| [test-check.R](testthat/test-check.R#L33) | reprex to blocks | class: err                                | PASS   | 1 | 0.001 |
| [test-check.R](testthat/test-check.R#L37) | reprex to blocks | class: fig                                | PASS   | 1 | 0.001 |
| [test-check.R](testthat/test-check.R#L45) | reprex to blocks | element type: no\_fig                     | PASS   | 1 | 0.001 |
| [test-check.R](testthat/test-check.R#L49) | reprex to blocks | element type: err                         | PASS   | 1 | 0.001 |
| [test-check.R](testthat/test-check.R#L53) | reprex to blocks | element type: err emo                     | PASS   | 1 | 0.001 |
| [test-check.R](testthat/test-check.R#L57) | reprex to blocks | element type: fig                         | PASS   | 1 | 0.001 |
| [test-si.R](testthat/test-si.R#L8)        | sessioninfo      | sessioninfo classification: file exists   | PASS   | 1 | 0.001 |
| [test-si.R](testthat/test-si.R#L12)       | sessioninfo      | sessioninfo classification: file contents | PASS   | 1 | 0.002 |
| [test-si.R](testthat/test-si.R#L22)       | sessioninfo      | sessionInfo classification: file exists   | PASS   | 1 | 0.001 |
| [test-si.R](testthat/test-si.R#L26)       | sessioninfo      | sessionInfo classification: file contents | PASS   | 1 | 0.001 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                               |                                                                                                                                                                                                                                                                     |
| :------- | :---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Version  | R version 3.6.3 (2020-02-29)        |                                                                                                                                                                                                                                                                     |
| Platform | x86\_64-apple-darwin15.6.0 (64-bit) | <a href="https://github.com/yonicd/slackreprex/commit/828006246e279ee4519bacd99b640b2ad3d4f381/checks" target="_blank"><span title="Built on Github Actions">![](https://github.com/metrumresearchgroup/covrpage/blob/actions/inst/logo/gh.png?raw=true)</span></a> |
| Running  | macOS Catalina 10.15.3              |                                                                                                                                                                                                                                                                     |
| Language | en\_US                              |                                                                                                                                                                                                                                                                     |
| Timezone | UTC                                 |                                                                                                                                                                                                                                                                     |

| Package  | Version |
| :------- | :------ |
| testthat | 2.3.2   |
| covr     | 3.5.0   |
| covrpage | 0.0.71  |

</details>

<!--- Final Status : pass --->
