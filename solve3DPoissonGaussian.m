% Solves Poisson's equation in 3D with gaussian source.
clear;
Ns = [10,20,30,40,50];
err = zeros(size(Ns));

for idx=1:length(Ns)
    N = Ns(idx);
    L = 1.8;
    sigma = 0.05;
    
    h = 1/N;
    xs = -0.5:h:0.5-h;
    ys = xs;
    zs = xs;
    
    points = zeros(N, N, N);
    for i=1:N
        for j=1:N
            for k=1:N
                points(i,j,k) = norm([xs(i) ys(j) zs(k)]);
            end
        end
    end
    points = reshape(points, [N^3 1]);
    
    sol = poissonSol3D(points, sigma);
    
    rho = gaussian3D(sigma, points);
    Gs = G03D(L, N);
    A = convolution3D(Gs, rho, N);
    
    err(idx) = max(abs(A - sol));    
end
plot(Ns, log(err), 's-');
title('Convergence of Poisson''s equation in 3D');
xlabel('Number of points')
ylabel('log of absolute error')
ax = gca;
ax.FontSize = 14;
disp(err);