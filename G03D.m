function [G] = G03D(L, N)
%G03D Generates G_0^L(s) for a fixed L in three dimensions. N is the number 
%     of grid points in one dimension.

n = 4*N;

G = zeros(n,n,n);
range = (2*pi/4)*((-2*N):1:(2*N-1));

for i=1:n
    for j=1:n
        for k=1:n
            s = norm([range(i) range(j) range(k)]);
            if s==0 % singularity
                s = 1e-16;
            end
            G(i,j,k) = 2*(sin(L*s/2)/s).^2;
        end
    end
end
end

