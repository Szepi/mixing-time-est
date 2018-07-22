% coverage experiment

rng(0);

d = 3;
gamma_bar = 0.49;
delta = 0.05;
[P,gap] = make_lb_P(d,gamma_bar,d);
[~,stationary] = group_inverse(P);
pimin = min(stationary);

n = 2^10;
num_trials = 1e3;

hatgap = zeros(num_trials,1);
error = zeros(num_trials,1);
relerr = zeros(num_trials,1);
nextprint = 1;
for trial = 1:num_trials
  N = sample_mc_pairs(P,n,1,zeros(d));
  hatP = bsxfun(@rdivide, N, sum(N,2));
  lambda = eig(hatP);
  [~,I] = sort(abs(lambda),'descend');
  hatgap(trial) = lambda(I(1)) - lambda(I(2));
  error(trial) = abs(hatgap(trial) - gap);
  relerr(trial) = abs(hatgap(trial) / gap - 1);
  if trial == nextprint
    fprintf(2,'trial = %d; relerr = %g\n', trial, quantile(relerr(1:trial),1-delta));
    nextprint = nextprint * 2;
  end
end
fprintf(2,'relerr = %g\n', quantile(relerr,1-delta));
