% count number of transitions of each type in a random sample path of
% length n from a markov chain with transition matrix P starting at state
% x0
%
% returns these counts in N and the final state in x0
%
function [N,x0] = sample_mc_pairs(P,n,x0,N)

d = size(P,1);
if nargin < 4
  N = zeros(d);
end
for t=1:n
  x = randsample(d,1,true,P(x0,:));
  N(x0,x) = N(x0,x) + 1;
  x0 = x;
end