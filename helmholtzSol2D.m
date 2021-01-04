function [sol] = helmholtzSol2D(rs, k, sigma)
%helmholtzSol2D Calculates the solution of the Helmholtz equation at the
%                points rs with constants k and sigma in 2D.
%
% input: rs: vector of norms of points at which the solution should be
%            calculated
%         k: constant k (see equation)
%     sigma: constant sigma (see equation)

sol = zeros(size(rs));

for i=1:length(rs)
    r = rs(i);
    
    if r==0 % singularity
        r = 1e-16;
    end
    
    f1 = @(y) besselj(0, k*y) .* exp(-(y.^2)/(2*(sigma^2)));
    f2 = @(y) besselh(0, k*r) .* exp(-(y.^2)/(2*(sigma^2)));
    sol(i) = besselh(0, k*r)/(4*(sigma^2)) .* integral(f1, 0, r) + ...
             besselj(0, k*r)/(4*(sigma^2)) .* integral(f2, r, inf);
end

end

