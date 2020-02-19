Tests and Coverage
================
18 February, 2020 21:03:25

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

| file                                  | n |  time | error | failed | skipped | warning |
| :------------------------------------ | -: | ----: | ----: | -----: | ------: | ------: |
| [test-check.R](testthat/test-check.R) | 7 | 0.006 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                      | context          | test                  | status | n |  time |
| :---------------------------------------- | :--------------- | :-------------------- | :----- | -: | ----: |
| [test-check.R](testthat/test-check.R#L29) | reprex to blocks | class: no\_fig        | PASS   | 1 | 0.001 |
| [test-check.R](testthat/test-check.R#L33) | reprex to blocks | class: err            | PASS   | 1 | 0.001 |
| [test-check.R](testthat/test-check.R#L37) | reprex to blocks | class: fig            | PASS   | 1 | 0.001 |
| [test-check.R](testthat/test-check.R#L45) | reprex to blocks | element type: no\_fig | PASS   | 1 | 0.001 |
| [test-check.R](testthat/test-check.R#L49) | reprex to blocks | element type: err     | PASS   | 1 | 0.001 |
| [test-check.R](testthat/test-check.R#L53) | reprex to blocks | element type: err emo | PASS   | 1 | 0.001 |
| [test-check.R](testthat/test-check.R#L57) | reprex to blocks | element type: fig     | PASS   | 1 | 0.000 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                               |
| :------- | :---------------------------------- |
| Version  | R version 3.6.1 (2019-07-05)        |
| Platform | x86\_64-apple-darwin15.6.0 (64-bit) |
| Running  | macOS Mojave 10.14.5                |
| Language | en\_US                              |
| Timezone | America/New\_York                   |

| Package  | Version |
| :------- | :------ |
| testthat | 2.2.1   |
| covr     | 3.3.0   |
| covrpage | 0.0.70  |

</details>

<!--- Final Status : pass --->
