Tests and Coverage
================
19 February, 2020 14:17:31

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                            | Coverage (%) |
| :------------------------------------------------ | :----------: |
| slackreprex                                       |      58      |
| [R/reprex.R](../R/reprex.R)                       |      0       |
| [R/reprex\_to\_blocks.R](../R/reprex_to_blocks.R) |     100      |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                  | n | time | error | failed | skipped | warning |
| :------------------------------------ | -: | ---: | ----: | -----: | ------: | ------: |
| [test-check.R](testthat/test-check.R) | 7 | 0.06 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                      | context          | test                  | status | n |  time |
| :---------------------------------------- | :--------------- | :-------------------- | :----- | -: | ----: |
| [test-check.R](testthat/test-check.R#L29) | reprex to blocks | class: no\_fig        | PASS   | 1 | 0.053 |
| [test-check.R](testthat/test-check.R#L33) | reprex to blocks | class: err            | PASS   | 1 | 0.001 |
| [test-check.R](testthat/test-check.R#L37) | reprex to blocks | class: fig            | PASS   | 1 | 0.001 |
| [test-check.R](testthat/test-check.R#L45) | reprex to blocks | element type: no\_fig | PASS   | 1 | 0.002 |
| [test-check.R](testthat/test-check.R#L49) | reprex to blocks | element type: err     | PASS   | 1 | 0.001 |
| [test-check.R](testthat/test-check.R#L53) | reprex to blocks | element type: err emo | PASS   | 1 | 0.001 |
| [test-check.R](testthat/test-check.R#L57) | reprex to blocks | element type: fig     | PASS   | 1 | 0.001 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                               |                                                                                                                                                                                                                                                                     |
| :------- | :---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Version  | R version 3.6.2 (2019-12-12)        |                                                                                                                                                                                                                                                                     |
| Platform | x86\_64-apple-darwin15.6.0 (64-bit) | <a href="https://github.com/yonicd/slackreprex/commit/7634263f93e5a0fb6f5abff923dcba72b5d4ae98/checks" target="_blank"><span title="Built on Github Actions">![](https://github.com/metrumresearchgroup/covrpage/blob/actions/inst/logo/gh.png?raw=true)</span></a> |
| Running  | macOS Catalina 10.15.3              |                                                                                                                                                                                                                                                                     |
| Language | en\_US                              |                                                                                                                                                                                                                                                                     |
| Timezone | UTC                                 |                                                                                                                                                                                                                                                                     |

| Package  | Version |
| :------- | :------ |
| testthat | 2.3.1   |
| covr     | 3.4.0   |
| covrpage | 0.0.71  |

</details>

<!--- Final Status : pass --->
