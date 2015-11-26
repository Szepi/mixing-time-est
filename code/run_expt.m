rng(0);

d = 5;
gamma_bar = 0.25;
delta = 0.1;
[P,gap] = make_lb_P(d,gamma_bar,d);

n=2^18;
N = zeros(d);
x = 1;
for epoch=1:1
  [N,x] = sample_mc_pairs(P,n,x,N);
end

[pimin_hat, gap_hat, b_hat, w_hat, P_hat, pi_hat, Asharp, lambda_hats, P_lb, P_ub, B_hat, kappa_hat, rho_hat] = mcintervals(N, d, delta)
