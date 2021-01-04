function [rhos] = gaussian3D(sigma,rs)
%gaussian3D Calculates the 3D gaussian.
%
% input:
%       rs: A vector containing the norms of points. E.g., if you want the
%           Gaussian at [1,1,1] then the input should be norm([1,1,1])
%       sigma: the constant sigma used in the Gaussian equation

rhos = zeros(size(rs));

for i=1:length(rs)
    r = rs(i);
    numerator = exp(-(r^2)/(2*(sigma^2)));
    denominator = ((sigma^3)*((2*pi)^(3/2)));
    rhos(i) = numerator/denominator;
end

