function [rhos] = gaussian2D(rs, sigma)
%gaussian2D Calculates the 2D gaussian.
%
% input:
%       rs: A vector containing the norms of points. E.g., if you want the
%           Gaussian at [1,1] then the input should be norm([1,1])
%       sigma: the constant sigma used in the Gaussian equation

rhos = zeros(size(rs));

for i=1:length(rs)
    r = rs(i);
    numerator = exp(-(r^2)/(2*(sigma^2)));
    denominator = (2*pi*(sigma^2));
    rhos(i) = numerator/denominator;
end

