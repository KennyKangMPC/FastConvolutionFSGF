function [e] = maxRelError(A,B, diff)
%maxRelError: Determine the maximum relative error between A and B where B 
% is sampled on a subset of the grid of A. both are square matrices. diff 
% is the multiple that A is larger than B
N = size(B,1);
idxs = ((1:N) - 1)*diff + 1;

ErrorMatrix = abs(A(idxs, idxs) - B);
ErrorMatrix = ErrorMatrix./abs(A(idxs,idxs));
e = max(ErrorMatrix, [], 'all');

end

