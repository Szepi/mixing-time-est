% constructs one of the markov chains from the lower bound in the paper
%
function [P,gap] = make_lb_P(d,gamma_bar,i)

big_epsilon = 2*(d-1)*gamma_bar/d;
small_epsilon = (d/2-1)*big_epsilon/(d-1);

P = zeros(d);
for j=1:d
  if j == i
    P(j,:) = small_epsilon/(d-1);
    P(j,j) = 1-small_epsilon;
  else
    P(j,:) = big_epsilon/(d-1);
    P(j,j) = 1-big_epsilon;
  end
end
l = sort(abs(eig(P)),'descend');
gap = l(1) - l(2);