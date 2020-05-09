data {
  int<lower=0> n_t;
  vector[n_t] di;
  vector[n_t] dh;
  vector[n_t] x1;
  vector[n_t] x2;

  int<lower=0> n_a;
  vector[n_a] A;
  vector[n_a] I;

  real<lower=0> r_out;
  real<lower=0> r_iso;
  real m_mn;
  real m_mx;
}
parameters {
  real<lower=0> sigma_i;

  real<lower=0, upper=1> beta;
  real<lower=0, upper=1> kappa;
  real<lower=m_mn, upper=m_mx> m;
}
transformed parameters {
  vector[n_t] alpha0;
  vector[n_t] alpha1;
  vector[n_t] mu;

  real alpha2;

  alpha2 = - beta / m;
  for (i in 1:n_t) {
    alpha0[i] = kappa * (m - A[i + 1]);
    alpha1[i] = (beta * (1 - A[i + 1] / m) - kappa - r_iso - r_out) / 2;
    mu[i] = 2 * (alpha0[i] + alpha1[i] * x1[i] + alpha2 * x2[i]);
  }
}
model {
  beta ~ gamma(1E-2, 1E-2);
  kappa ~ gamma(1E-2, 1E-2);
  m ~ uniform(m_mn, m_mx);
  sigma_i ~ gamma(1E-2, 1E-2);

  target += normal_lpdf(di | mu, sigma_i);
}
generated quantities {
  vector[n_t] I_hat;
  real<lower=0> R0;
  vector[n_t]  Rt;
  vector<lower=0, upper=1>[n_t] PrEx;

  R0 = beta / (r_out + r_iso);

  for (i in 1:n_t) {
    I_hat[i] = fmax(I[i] + normal_rng(mu[i], sigma_i), 0);
    Rt[i] = R0 * (m - A[i + 2] - I_hat[i]) / m;
    PrEx[i] = kappa / (kappa + beta * I_hat[i] / m);
  }
}
