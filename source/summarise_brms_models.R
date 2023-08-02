get_rhats <- function(models) {
  require("dplyr")
  require("tibble")
  # get rhats and make dataframe
  rhat_list <- lapply(seq_along(models), function(i) {
    model <- models[[i]]
    rhats <- brms::rhat(model)
    as.data.frame(rhats) %>%
      rownames_to_column("variable") %>%
      rename_with(~paste0("rhat"), .cols = starts_with("rhat")) %>%
      mutate(model = names(models)[i])
  })
  names(rhat_list) <- names(models)
  return(rhat_list)
}

show_rhat <- function(rhat_df) {
  require("ggplot2")
  palette <- colorRampPalette(RColorBrewer::brewer.pal(9,
                              name = "Set1"))(length(unique(rhat_df$variable)))
  rhat_df |>
    ggplot(aes(y = .data$rhat, x = .data$model, colour = .data$variable)) +
    geom_hline(yintercept = 1, colour = "darkgrey", linetype = "dashed") +
    geom_hline(yintercept = 1.1, colour = "firebrick", linetype = "dashed") +
    geom_jitter(width = 0.2, height = 0, size = 1) +
    scale_colour_manual(values = palette) +
    theme(legend.position = "",
          axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
    labs(x = "", y = "Gelman-Rubin diagnostic")
}

get_traits <- function(model) {
  sort(unique(model$data$trait_value))
}

create_contrast_matrix <- function(model) {
  if (is.numeric(model)) {
    n_col <- model
  } else {
    n_col <- length(get_traits(model))
  }
  matrix(cbind(rep(1, n_col), contr.treatment(n_col)), ncol = n_col)
}
