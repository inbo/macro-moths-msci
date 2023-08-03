dataframe_per_trait <- function(combo) {
  require("dplyr")
  require("tidyr")

  if (length(combo) == 2) {
    row <- combo[1]
    column <- combo[2]
    out <- species_traits_final %>%
      filter(.data$trait_name %in% combo) %>%
      pivot_wider(
        id_cols = c("species_nl", "species_new", "n_grids", "period",
                    "sum_per_period"),
        names_from = "trait_name",
        values_from = "trait_value"
      ) %>%
      # Fill in missing trait values for species that occur twice
      group_by(.data$species_nl) %>%
      arrange(.data$species_nl, .data$species_new,
              !!sym(row), !!sym(column)) %>%
      mutate(
        "{row}" := ifelse(is.na(!!sym(row)), # nolint: object_name_linter.
                          first(!!sym(row)), !!sym(row)
        ),
        "{column}" := ifelse(is.na(!!sym(column)), # nolint: object_name_linter.
                             first(!!sym(column)), !!sym(column)
        )
      ) %>%
      ungroup() %>%
      # Reference group is most frequent group
      mutate("{row}" := factor(!!sym(row), # nolint: object_name_linter.
                               levels(forcats::fct_infreq(!!sym(row)))),
             "{column}" := factor(!!sym(column), # nolint: object_name_linter.
                                  levels(forcats::fct_infreq(!!sym(column))))) %>%
      # How many species per trait combination?
      group_by_at(c("period", combo)) %>%
      mutate(n_species = n()) %>%
      ungroup() %>%
      select(-.data$species_nl) %>%
      mutate(species_nl = .data$species_new) %>%
      select(-.data$species_new) %>%
      select_at(c("species_nl", "n_grids", "period", "sum_per_period", combo,
                  "n_species")) %>%
      # How many species per trait separately?
      group_by_at(c("period", row)) %>%
      mutate(n_trait1 = n()) %>%
      ungroup() %>%
      group_by_at(c("period", column)) %>%
      mutate(n_trait2 = n()) %>%
      ungroup() %>%
      # Filter out small trait groups
      filter(.data$n_trait1 > filter_size,
             .data$n_trait2 > filter_size) %>%
      select(-c(.data$n_trait1, .data$n_trait2))
  } else if (length(combo) == 1) {
    out <- species_traits_final %>%
      filter(.data$trait_name == combo) %>%
      pivot_wider(
        id_cols = c("species_nl", "species_new", "n_grids", "period",
                    "sum_per_period"),
        names_from = "trait_name",
        values_from = "trait_value"
      ) %>%
      # Reference group is most frequent group
      mutate("{combo}" := factor(!!sym(combo), # nolint: object_name_linter.
                                 levels(forcats::fct_infreq(!!sym(combo))))) %>%
      # How many species per trait combination?
      group_by_at(c("period", combo)) %>%
      mutate(n_species = n()) %>%
      ungroup() %>%
      select(-.data$species_nl) %>%
      mutate(species_nl = .data$species_new) %>%
      select(-.data$species_new) %>%
      select_at(c("species_nl", "n_grids", "period", "sum_per_period", combo,
                  "n_species")) %>%
      # Filter out small trait groups
      filter(.data$n_species > filter_size)
  } else {
    stop("Function not implemented for combinations of more than 2 traits.",
         call. = FALSE)
  }
  return(out)
}
