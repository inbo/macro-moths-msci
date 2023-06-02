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
