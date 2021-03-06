library("dplyr")
library("tidylog")
context("test_group_by")

test_that("group_by", {
    expect_message({
        out <- tidylog::group_by(mtcars, mpg)
    })
    expect_equal(is.grouped_df(out), TRUE)

    expect_silent({
        out <- dplyr::group_by(mtcars, mpg)
    })
})

test_that("group_by: scoped variants", {
    expect_message({
        out <- tidylog::group_by_all(mtcars)
    }, "11 grouping variables") # nolint

    expect_message({
        out <- tidylog::group_by_if(mtcars, is.numeric)
    }, "11 grouping variables") # nolint

    expect_message({
        out <- tidylog::group_by_at(mtcars, vars(vs:am))
    }, "2 grouping variables") # nolint
})

test_that("group_by: argument order", {
    expect_message({
        out <- tidylog::group_by(mpg, .data = mtcars)
    })
    expect_equal(is.grouped_df(out), TRUE)
})
