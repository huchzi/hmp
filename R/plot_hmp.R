#' @export
plot_hmp <- function(hmp_table) {

  hmp_table$x <- log10(hmp_table$threshold_red / hmp_table$threshold_green)
  hmp_table$y <- log10(100 / (hmp_table$threshold_red + hmp_table$threshold_green))

  show_function <- data.frame(x = numeric(0), y = numeric(0))
  for (fr in unique(hmp_table$frequency)) {
    hmp_fit <- NULL
    ymin <- min(hmp_table[hmp_table$frequency == fr, ]$y)
    try(hmp_fit <- nls(y ~ hmp(x, h, v, ymin), data = hmp_table[hmp_table$frequency == 20, ], start = list(h = 0, v = 2))  )
    if (!is.null(hmp_fit)) show_function <- rbind(show_function,
                                                  data.frame(x = seq(-1, 1, .01),
                                                       y = predict(hmp_fit, data.frame(x = seq(-1, 1, .01))),
                                                       frequency = fr,
                                                       h = coef(hmp_fit)[[1]],
                                                       ymin = ymin))

  }

  ggplot(hmp_table, aes(x = x, y = y)) +
    geom_point() +
    facet_wrap(~ frequency) +
    geom_line(data = show_function) +
    geom_label(data = unique(show_function[, 3:5]), aes(x = h, y = ymin - .2, label = round(h, 3))) +
    scale_y_continuous(limits = c(-1, 2)) +
    theme_bw() +
    scale_x_continuous("log10 C1/C2") +
    scale_y_continuous("log10 Sensitivity")

}
