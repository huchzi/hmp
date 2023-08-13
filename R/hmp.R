#' @export
hmp <- function(x, h, v, ymin) {

  y <- log10(abs((10^h - 10^x)/(1+10^x)/(1+10^h))) + v
  y[y < ymin] <- ymin

  return(y)

}
