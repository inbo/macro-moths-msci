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
    labs(x = "", y = "potential scale reduction factor")
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

get_contrast_matrix <- function(model, combo) {
  trait1 <- stringr::str_split_i(combo, "_", 1)
  trait2 <- stringr::str_split_i(combo, "_", 2)

  n_trait1 <- length(unique(model$data[[trait1]]))
  n_trait2 <- length(unique(model$data[[trait2]]))

  # Reference group
  ref_group <- cbind(
    create_contrast_matrix(n_trait1),
    matrix(rep(0, ((n_trait1 * n_trait2) - n_trait1) * n_trait1), n_trait1))

  # Other groups
  parts1 <- vector("list", length = n_trait2 - 1)
  for (i in seq_along(parts1)) {
    parts1[[i]] <- create_contrast_matrix(n_trait1)
  }
  parts2 <- vector("list", length = n_trait2 - 1)
  for (i in seq_along(parts2)) {
    part <- matrix(rep(0, n_trait1 * (n_trait2 - 1)), nrow = n_trait1)
    part[, i] <- rep(1, n_trait1)
    parts2[[i]] <- part
  }
  parts3 <- vector("list", length = n_trait2 - 1)
  j <- 0
  for (i in seq_along(parts3)) {
    cntr_trt <- contr.treatment(n_trait1)
    part <- matrix(rep(0, n_trait1 * (n_trait1 - 1) * (n_trait2 - 1)),
                   nrow = n_trait1)

    first <- i + (j * (n_trait1 - 2))
    last <- first + n_trait1 - 2
    part[, first:last] <- cntr_trt
    parts3[[i]] <- part
    j <- j + 1
  }

  rest_group <- cbind(
    do.call(rbind, parts1),
    do.call(rbind, parts2),
    do.call(rbind, parts3))

  return(rbind(ref_group, rest_group))
}

order_traits <- function(df, var) {
  out <- df
  # maak vector met ordered traits --> if any erin dan al die ifjes doen
  # if any not erin dan if length = 1 median doen
  # if lenth is 2 kijken hoeveel geordend moeten worden volgens median

  ordered_traits <- c(
    "NutrientValueBiotope",
    "ForewingLength",
    "Voltinism",
    "OverwinteringStage",
    "HostPlantSpecificity",
    "TempHum",
    "FlightPeriod"
  )

  # Manual sorting where applicable
  if (any(var %in% ordered_traits)) {
    if ("NutrientValueBiotope" %in% names(out)) {
      out <- out %>%
        mutate(NutrientValueBiotope = factor(.data$NutrientValueBiotope,
                                   levels = c(
                                     "VeryNutrientPoor",
                                     "NutrientPoor",
                                     "NutrientRich",
                                     "VeryNutrientRich"
                                   ), ordered = TRUE)
        )
    }
    if ("ForewingLength" %in% names(out)) {
      out <- out %>%
        mutate(ForewingLength = factor(.data$ForewingLength,
                             levels = c(
                               "VerySmall",
                               "Small",
                               "Medium",
                               "Large",
                               "VeryLarge"
                             ), ordered = TRUE)
        )
    }
    if ("Voltinism" %in% names(out)) {
      out <- out %>%
        mutate(Voltinism = factor(.data$Voltinism,
                                     levels = c(
                                       "1",
                                       "2"
                                     ), ordered = TRUE)
        )
    }
    if ("OverwinteringStage" %in% names(out)) {
      out <- out %>%
        mutate(OverwinteringStage = factor(.data$OverwinteringStage,
                                           levels = c(
                                             "Egg",
                                             "Caterpillar",
                                             "Pupa",
                                             "Adult"
                                           ), ordered = TRUE)
        )
    }
    if ("HostPlantSpecificity" %in% names(out)) {
      out <- out %>%
        mutate(HostPlantSpecificity = factor(.data$HostPlantSpecificity,
                              levels = c(
                                "Monophagous",
                                "Oligophagous",
                                "Polyphagous"
                              ), ordered = TRUE)
        )
    }
    if ("TempHum" %in% names(out)) {
      out <- out %>%
        mutate(TempHum = factor(.data$TempHum,
                                levels = c(
                                  "Cold_VeryWet",
                                  "Cold_Wet",
                                  "Hot_Wet",
                                  "Hot_Dry",
                                  "VeryHot_Dry"
                                ), ordered = TRUE)
        )
    }
    if ("FlightPeriod" %in% names(out)) {
      out <- out %>%
        mutate(FlightPeriod = factor(.data$FlightPeriod,
                                    levels = c(
                                      "Spring",
                                      "SpringSummer",
                                      "Summer",
                                      "SummerAutumn",
                                      "Autumn",
                                      "Winter",
                                      "AutumnSpring",
                                      "SpringSummerAutumn"
                                    ), ordered = TRUE)
        )
    }
  }

  # Sort according to median effect for traits without logical ordering
  # only if there is one unordered trait
  if (any(!var %in% ordered_traits)) {
    unordered_var <- setdiff(var, ordered_traits)
    if (length(unordered_var) == 1) {
      out <- out %>%
        group_by_at(unordered_var) %>%
        mutate(msci_median = median(.data$msci)) %>%
        ungroup() %>%
        mutate("{unordered_var}" := reorder(!!sym(unordered_var), # nolint.
                                            .data$msci_median,
                                            decreasing = TRUE)) %>%
        select(-c(.data$msci_median))
    }
  }

  return(out)
}
