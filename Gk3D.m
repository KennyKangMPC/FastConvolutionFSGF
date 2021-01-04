function [G] = Gk3D(k, L, N)
%Gk3D Generates G_k^L(s) for a fixed L and k in three dimensions. N is the 
%     number of grid points in one dimension.

n = 4*N;
G = zeros(n,n,n);
range = (2*pi/4)*((-2*N):1:(2*N-1));


for i=1:n
    for j=1:n
        for z=1:n
            s = norm([range(i) range(j) range(z)]);
            
            if s==abs(k) % singularity
                s = k+1e-16;
            elseif s==0 % singularity
                s = 1e-16;
            end
            
            G(i,j,z) = (-1 + exp(1i*L*k)*(cos(L*s) - i*(k/s)*sin(L*s)))/...
                ((k-s)*(k+s));
        end
    end
end
end

