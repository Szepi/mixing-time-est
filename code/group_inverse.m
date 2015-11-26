% Function:
% [Asharp,stationary] = group_inverse(P)
%
% Input:
% 'P'                row stochastic probability transition matrix
%                    of an ergodic Markov chain
%
% Outputs:
% 'Asharp'           group inverse of I-P
% 'stationary'       unique stationary distribution
%
function [Asharp,stationary] = group_inverse(P)
n = size(P,1);
A = eye(n) - P;
U = A(1:n-1,1:n-1);
d = A(n,1:n-1);
invU = inv(U);
h = d/U;
delta = -sum(h/U);
beta = 1-sum(h);
F = invU - (delta/beta)*eye(n-1);
Asharp = [invU + (1/delta)*(sum(invU,2)*h/U - sum(F,2)*h*F), -(1/beta)*sum(F,2); ...
  (1/beta)*h*F, delta/beta^2];
stationary = [-h,1]/beta;
