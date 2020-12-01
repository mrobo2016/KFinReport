
<!-- README.md is generated from README.Rmd. Please edit that file -->

# KFinReport

<!-- badges: start -->

[![R build
status](https://github.com/mrobo2016/KFinReport/workflows/R-CMD-check/badge.svg)](https://github.com/mrobo2016/KFinReport/actions)
<!-- badges: end -->

Handling Korea’s Corporate Filings from DART

This package utilizes Korea’s Repository of Corporate Filings (DART).
It’s goal is to assist users to browse through the repository via R.
Users are able to retrieve corporate filings as data. Upon retrieval,
users can select the corporate of interest, the time span, types of
report, etc.

## Installation

You can install the released version of KFinReport from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("KFinReport")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("mrobo2016/KFinReport")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(KFinReport)
ss <- report_earning1("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "삼성전자", "2019" ,"y", "c" )
ss 
#> # A tibble: 210 x 17
#>    rcept_no reprt_code bsns_year corp_code sj_div sj_nm account_id account_nm
#>    <chr>    <chr>      <chr>     <chr>     <chr>  <chr> <chr>      <chr>     
#>  1 2020033… 11011      2019      00126380  BS     재무상태… ifrs-full… 유동자산  
#>  2 2020033… 11011      2019      00126380  BS     재무상태… ifrs-full… 현금및현금성자산…
#>  3 2020033… 11011      2019      00126380  BS     재무상태… dart_Shor… 단기금융상품…
#>  4 2020033… 11011      2019      00126380  BS     재무상태… -표준계정코드 미… 단기매도가능금융자…
#>  5 2020033… 11011      2019      00126380  BS     재무상태… -표준계정코드 미… 단기상각후원가금융…
#>  6 2020033… 11011      2019      00126380  BS     재무상태… ifrs-full… 단기당기손익-공정…
#>  7 2020033… 11011      2019      00126380  BS     재무상태… dart_Shor… 매출채권  
#>  8 2020033… 11011      2019      00126380  BS     재무상태… -표준계정코드 미… 미수금    
#>  9 2020033… 11011      2019      00126380  BS     재무상태… -표준계정코드 미… 선급금    
#> 10 2020033… 11011      2019      00126380  BS     재무상태… -표준계정코드 미… 선급비용  
#> # … with 200 more rows, and 9 more variables: account_detail <chr>,
#> #   thstrm_nm <chr>, thstrm_amount <chr>, frmtrm_nm <chr>, frmtrm_amount <chr>,
#> #   bfefrmtrm_nm <chr>, bfefrmtrm_amount <chr>, ord <chr>,
#> #   thstrm_add_amount <chr>
```
