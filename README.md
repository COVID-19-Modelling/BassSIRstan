# BassSIR
Infectious disease modelling with Bass SIR models using R and stan


## Install package
In R, you can install from github
```r
devtools::install_github("COVID-19-Modelling/BassSIRstan", upgrade = FALSE)
```

Load the package before use it
```r
library(BassSIRstan)
```

## Contents

- [Modelling](#modelling)
  - [Data prepartion](#data-preparation)
  - [Model fitting](#model-fitting)
  - [Simulation](#simulation)
  - [Model comparison](#model-comparison)
  - [Scenario analysis](#scenario-analysis)
  
- [Output and visualisation](#output-and-visualisation)

- [Academic contact](#academic-contact)



## Modelling
### Data preparation
```r
cases <- tail(n_by_country$US, 20)
est <- fit_two_step(cases, "US", r_is0 = 1/6, n_iter_2 = 1E4)
sim <- simulate(est, nsim = 1000)
```

### Model fitting
Fit BassSIR model to data
```r
est_bass <- fit_two_step(cases, "US", r_is0 = 1/6, n_iter_2 = 1E4)
summary(est_bass)
```

### Simulation, TBA
```r
sim <- simulate(est_bass, nsim = 1000)
```

### Scenario analysis, TBA
```r
zero_kappa <- function(pars) {
  pars$kappa <- rep(0, length(pars$kappa))
  return(pars)
}
lockdown <- run_scenario(sim, zero_kappa)
```

**compare_scenarios** will output two group of time-series

- **Trajectories** The trends of simulations of each variable
- **Change** Calculate the value changes from the baseline case 

```{r}
cp <- compare_scenarios(sim, Lockdown = lockdown, fn_change = "Yt")
```

## Output and visualisation
```r
TBA
```


## Academic contact

Chu-Chang Ku,

Health Economic and Decision Science, University of Sheffield, UK

Email: c.ku@sheffield.ac.uk


## License

MIT (c) 2020 Chu-Chang Ku, Ta-Chou Ng, and Hsien-Ho Lin

