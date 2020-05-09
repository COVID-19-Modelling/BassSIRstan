#' Fitted values of BassSIR models
#'
#' @param est estimated model
#'
#' @return
#' @export
#'
#' @examples
#' f_bass_sir = fit_two_step(tail(n_by_country$US, 20), "US", refresh = 0)
#' fitted(f_bass_sir)
#' 
fitted.estBassSIR <- function(est) {
  rt <- rstan::summary(est$Models$Bass, pars = "Rt")$summary
  i1 <- rstan::summary(est$Models$Absorb, pars = "I")$summary
  i2 <- rstan::summary(est$Models$Bass, pars = "I_hat")$summary
  
  y <- list(
    I_data = i1,
    I_hat = i2,
    Rt_hat = rt
  )
  
  class(y) <- "fittedBassSIR"
  return(y)
}
