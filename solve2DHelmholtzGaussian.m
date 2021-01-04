% Solves the 2D Helmholtz equation with gaussian source.
clear;
Ns = [10,20,30,40,50];

err = zeros(size(Ns));

for idx=1:length(Ns)
    N = Ns(idx);
    L = 1.5;
    k = 2;
    sigma = 0.05;
    
    h = 1/N;
    xs = -0.5:h:0.5-h;
    ys = xs;
    
    points = zeros(N, N);
    for i=1:N
        for j=1:N
            points(i,j) = norm([xs(i) ys(j)]);
        end
    end
    points = reshape(points, [N^2 1]);
    
    sol = helmholtzSol2D(points, k, sigma);
    
    
    rho = gaussian2D(points, sigma);
    Gs = Gk2D(k, L, N);
    A = convolution2D(Gs, rho, N);
    
    err(idx) = max(abs(A - sol));    
end
plot(Ns, log(err));
title('Convergence of the Helmholtz equation in 2D');
xlabel('Number of points')
ylabel('log of Maximum error')
ax = gca;
ax.FontSize = 14;
disp(err);