function [sol] = helmholtzSol3D(rs, k, sigma)
%helmholtzSol3D Calculates the solution of the Helmholtz equation at the
%                points rs with constants k and sigma in 3D. Requires the
%                use of the Faddeeva package:
%                https://www.mathworks.com/matlabcentral/fileexchange/38787-faddeeva-package-complex-error-functions
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
    
    erfVal = Faddeeva_erf( (2*(sigma^2)*1i*k - 2*r)/(2*sqrt(2*(sigma^2))) );
    sol(i) = (1/(4*pi*r))*exp(-(sigma^2)*(k^2)/2) * (...
              real(exp(-1i*k*r)* erfVal) - 1i*sin(k*r) );
end

end

