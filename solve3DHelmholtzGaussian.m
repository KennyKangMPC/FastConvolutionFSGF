% Solves the 3D Helmholtz equation with Gaussian source.
clear;
Ns = [10,20,30,40,50,60,70,80,90,100];
err = zeros(size(Ns));

for idx=1:length(Ns)
    N = Ns(idx);
    L = 1.8;
    k = 2;
    sigma = 0.05;
    
    h = 1/N;
    xs = -0.5:h:0.5-h;
    ys = xs;
    zs = xs;
    
    points = zeros(N, N, N);
    for i=1:N
        for j=1:N
            for z=1:N
                points(i,j,z) = norm([xs(i) ys(j) zs(z)]);
            end
        end
    end
    points = reshape(points, [N^3 1]);
    
    sol = helmholtzSol3D(points, k, sigma);
    
    
    rho = gaussian3D(sigma, points);
    Gs = Gk3D(k, L, N);
    A = convolution3D(Gs, rho, N);
    
    err(idx) = max(abs(A - sol));
end
plot(Ns, log(err));
title('Convergence of Helmholtz equation in 3D');
xlabel('Number of points')
ylabel('log of absolute error')
ax = gca;
ax.FontSize = 14;
disp(err);

