data {
  int<lower=0> n_t;
  
  vector[n_t] dh;
  vector[n_t] dd;
  vector[n_t] dr;
  vector[n_t] x1;
  
  vector[n_t] H;
  
  real<lower=0> r_iso;
}
parameters {
  real<lower=0> sigma_d;
  real<lower=0> sigma_r;
  
  real<lower=0> tt_rec;
  real<lower=0> tt_death;
}
transformed parameters {
  real<lower=0> r_rec;
  real<lower=0> r_death;
  
  r_rec = 1 / tt_rec;
  r_death = 1/ tt_death;
}
model {
  tt_rec ~ gamma(1E-2, 1E-2);
  tt_death ~ gamma(1E-2, 1E-2);
  sigma_r ~ gamma(1E-2, 1E-2);
  sigma_d ~ gamma(1E-2, 1E-2);
  
  target += normal_lpdf(dd | r_death * x1, sigma_d);
  target += normal_lpdf(dr| r_rec * x1, sigma_r);
}
generated quantities {
  vector[n_t] I;
  real hidden;
  real hi_death;
  real hi_rec;
  real<lower=0, upper=1> cdg;
  
  cdg = r_iso / (r_iso + r_rec + r_death);
 
  hidden = neg_binomial_2_rng(H[n_t] * (r_rec + r_death) / r_iso, H[n_t]);
  hi_death = hidden * r_death / (r_rec + r_death);
  hi_rec = hidden * r_rec / (r_rec + r_death);
  
  for (i in 1:n_t) {
    I[i] = (dh[i] + x1[i] * (r_rec + r_death)) / r_iso / 2;
  }
}
