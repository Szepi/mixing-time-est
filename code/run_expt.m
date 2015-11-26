rng(0);

d = 4;
gamma_bar = 0.4;
delta = 0.05;
[P,gap] = make_lb_P(d,gamma_bar,d);

n_vals = 2.^(15:20);
T = length(n_vals);
n = n_vals(1);

pimin_lb = zeros(T,1);
pimin_ub = zeros(T,1);
gap_lb = zeros(T,1);
gap_ub = zeros(T,1);

N = zeros(d);
x = 1;
for i=1:T
  fprintf('n=%d\n', n_vals(i));
  [N,x] = sample_mc_pairs(P,n,x,N);
  [pimin_lb(i), pimin_ub(i), gap_lb(i), gap_ub(i)] = mcintervals(N, d, delta);
  if i < T
    n = n_vals(i+1) - n_vals(i);
  end
end

subplot(1,2,1);
plot(n_vals, gap_ub, n_vals, gap_lb);
xlabel('n');
legend('\gamma_* ub', '\gamma_* lb');

subplot(1,2,2);
plot(n_vals, pimin_ub, n_vals, pimin_lb);
xlabel('n');
legend('\pi_* ub', '\pi_* lb');
