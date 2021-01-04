function [sol] = poissonSol3D(rs, sigma)
%poissonSol3D Calculates the solution of the Helmholtz equation at the
%             points rs with constant sigma in 3D.
%
% input: rs: vector of norms of points at which the solution should be
%            calculated
%     sigma: constant sigma (see equation)


sol = zeros(size(rs));

for i=1:length(rs)
    r = rs(i);
    
    if r==0 % singularity
        r = 1e-16;
    end
    
    sol(i) = (1/(4*pi*r))*erf(r/(sqrt(2)*sigma));
end
end


