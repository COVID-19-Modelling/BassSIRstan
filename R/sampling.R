#' Sample from stan models
#'
#' @param d data to be fitted
#' @param r_iso rate of isolation
#' @param r_out rate of recovery and death
#' @param pars parameters for outputing
#' @param ... arguments from rstan::sampling
#'
#' @return mcmc results from rstan
#' @export
sample_absorb <- function(d, r_iso,
                          pars = c("r_death", "r_rec", "I", "cdg", "hi_death", "hi_rec"),
                          ...) {
  d$r_iso <- r_iso
  out <- rstan::sampling(stanmodels$absorb, data = d, pars=pars, ...)
  return(out)
}


#' @rdname sample_absorb
#' @export
sample_bass <- function(d, r_iso, r_out = d$r_out,
                        pars = c("beta", "kappa", "m", "I_hat", "R0", "Rt", "PrEx"),
                        ...) {
  d$r_iso <- r_iso
  d$r_out <- r_out
  out <- rstan::sampling(stanmodels$bass, data = d, pars=pars, ...)
  return(out)
}
