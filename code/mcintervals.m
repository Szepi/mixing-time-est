function [pimin_hat, gap_hat, b_hat, w_hat, P_hat, pi_hat, Asharp, lambda_hats, P_lb, P_ub, B_hat, kappa_hat, rho_hat] = mcintervals(N, d, delta)

n = sum(N(:));

Nvisit = sum(N,2);
P_hat = bsxfun(@rdivide, N + 1/d, Nvisit + 1);

tau = fzero(@(t) 2*d^2*(1 + ceil(max(log(2*n/t)/log(1.1),0)))*exp(-t) - delta, [1,100]);

P_ub = zeros(d);
P_lb = zeros(d);

for i=1:d
  for j=1:d
    P_lb(i,j) = fzero(@(p) P_hat(i,j) - p - (sqrt(2.2*tau*Nvisit(i)/(Nvisit(i)+1)^2*p*(1-p)) + (4/3)*tau/(Nvisit(i)+1) + abs(1/d-p)/(Nvisit(i)+1)), [0,1]);
    P_ub(i,j) = fzero(@(p) p - P_hat(i,j) - (sqrt(2.2*tau*Nvisit(i)/(Nvisit(i)+1)^2*p*(1-p)) + (4/3)*tau/(Nvisit(i)+1) + abs(1/d-p)/(Nvisit(i)+1)), [0,1]);
  end
end
B_hat = max(P_ub - P_hat, P_hat - P_lb);

[Asharp,pi_hat] = group_inverse(P_hat);
pimin_hat = min(pi_hat);

kappa_hat = 0.5 * max(diag(Asharp) - min(Asharp)');
b_hat = kappa_hat * max(B_hat(:));
rho_hat = 0.5 * max([b_hat ./ pi_hat, b_hat ./ max(pi_hat - b_hat,0)]);
% w_hat = 2*rho_hat + rho_hat^2 + (1+2*rho_hat+rho_hat^2)*norm(diag(sqrt(pi_hat))*B_hat*diag(1./sqrt(pi_hat)),'fro');
w_hat = 2*rho_hat + rho_hat^2 + (1+2*rho_hat+rho_hat^2)*norm(diag(sqrt(pi_hat))*B_hat*diag(1./sqrt(pi_hat)));

L_hat = diag(sqrt(pi_hat))*P_hat*diag(sqrt(1./pi_hat));
lambda_hats = eig(0.5*(L_hat+L_hat'));
abs_lambda_hats = sort(abs(lambda_hats), 'descend');
gap_hat = 1 - abs_lambda_hats(2);
