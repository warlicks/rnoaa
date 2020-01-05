#' Query Data From NOAA's CO-OPS Derived Product API
#'
#' Provides access to data available from NOAA's CO-OPS \href{https://tidesandcurrents.noaa.gov/dpapi/latest/#intro}{Derived Product API}. Four derived data products are available through the API: 1) Top Ten Water Levels, 2) Annual Flood Days, 3) Extreme Water Levels and 4) Sea Level Trends.  More detail about each data product is available with the \href{https://tidesandcurrents.noaa.gov/dpapi/latest/#intro}{API's documentation}
#'
#' @param station_name (numeric) a station name. Optional
#'
#' @param product (character) Specify the data type. See below for Details.
#' Required.
#'
#' @param year (numeric) used to limit the results from the annual
#' flood days endpoint to the indicated year. The argument is ignored if used
#' with other data products.
#'
#' @param affil an argument used to limit the results to U.S. (\code{'US'}) or
#' Global stations (\code{'Global'}). The argument is ignored if used with
#' other data products.
#'
#' @param units units (character) Specify metric or english (imperial) units,
#' one of 'metric', 'english'. Defaults to metric.
#'
#'  @param application (character) If called within an external package, set
#' to the name of your organization. Optional
#'
#' @param ... Curl options passed on to [crul::verb-GET] Optional
#'
#' @return a data frame
#'
#' @export
#'
#' @examples

coops_derived <- function(station_name = NULL,
                          product = NULL,
                          year = NULL,
                          affil = NULL,
                          units = "metric",
                          application = "rnoaa") {




    # Prepare the query & make the request.
    args <- nooa_compact(list(station = station_name,
                                      name = product,
                                      year = year,
                                      affil = toupper(affil),
                                      units = units,
                                      application = application)
                                )

    if (product != "sealeveltrends") {
        query_url <- derived_base()
    } else {
        query_url <- sea_lvl_base()
    }

    response <- coops_GET(query_url, args, ...)

    return(response)
    }

derived_base <- function(){"https://tidesandcurrents.noaa.gov/dpapi/latest/webapi/product.json"}
sea_lvl_base <- function(){"https://tidesandcurrents.noaa.gov/dpapi/latest/webapi/product/sealvltrends.json"}