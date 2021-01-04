function [G] = Gk2D(k, L, N)
%Gk2D Generates G_k^L(s) for a fixed L and k in two dimensions. N is the 
%     number of grid points in one dimension.
n = 4*N;
G = zeros(n,n);
range = (2*pi/4)*((-2*N):1:(2*N-1));

for i=1:n
    for j=1:n
        s = norm([range(i) range(j)]);

        if s==abs(k) % singularity
            s = k + 1e-16; 
        end
        
        J0 = besselj(0,L*s);
        J1 = besselj(1,L*s);
        H0 = besselh(0,1,L*k);
        H1 = besselh(1,1,L*k);

        numerator = 1 +  ((1i*pi)/2)*L*s*J1*H0 - ...
                         ((1i*pi)/2)*L*k*J0*H1;
        result = numerator/(s^2-k^2);

        G(i,j) = result;

    end
end

end

