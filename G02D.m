function [G] = G02D(L, N)
%G02D Generates G_0^L(s) for a fixed L in two dimensions. N is the number 
%     of grid points in one dimension.

n = 4*N;
G = zeros(n,n);
range = (2*pi/4)*((-2*N):1:(2*N-1));

for i=1:n
    for j=1:n
        s = norm([range(i) range(j)]);

        if s==0 % singularity
            s=1e-16; 
        end

        J0 = besselj(0,L*s);
        J1 = besselj(1,L*s);
        G(i,j) = (1-J0)/(s^2) - (L*log(L)*J1)/s;
    end
end

end

