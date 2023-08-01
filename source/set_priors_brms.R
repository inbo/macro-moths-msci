set_priors_brms <- function(combo, df, formula) {
  require("dplyr")
  require("tidyr")
  require("brms")

  trait1 <- stringr::str_split_i(combo, "_", 1)
  trait2 <- stringr::str_split_i(combo, "_", 2)

  present_combinations <- df %>%
    mutate(group = paste(paste0(trait1, !!sym(trait1)),
                         paste0(trait2, !!sym(trait2)), sep = ":")) %>%
    distinct(.data$group) %>%
    pull()

  all_combinations <- df %>%
    expand(!!sym(trait1), !!sym(trait2)) %>%
    mutate(group = paste(paste0(trait1, !!sym(trait1)),
                         paste0(trait2, !!sym(trait2)), sep = ":")) %>%
    pull(.data$group)



  missing_combinations <- gsub("(\\s|\\(|\\))", "",
                               setdiff(all_combinations, present_combinations))


  interactions <- paste("periodp2013_2022", missing_combinations, sep = ":")

  priors <- get_prior(
    formula = formula,
    data = df,
    family = poisson())

  if (length(missing_combinations) == 0) {
    prior_out <- priors
  } else {
    prior_out <- priors %>%
      mutate(prior = ifelse(coef %in% c(missing_combinations, interactions),
                            "constant(0)", .data$prior))
  }

  return(prior_out)
}
