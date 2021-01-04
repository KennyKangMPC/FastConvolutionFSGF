% Solves the 2D Poisson equation with gaussian source. Note that lines
% 27-31 contain the solution: either the analytic solution or the modified
% solution.

clear;
Ns = [10,20,30,40,50];

err = zeros(size(Ns));

for idx=1:length(Ns)
    N = Ns(idx);
    L = 1.5;
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
    
    % modified solution
    sol = poissonSol2D(points, sigma) - 0.0352;
    
    % unmofidied solution
    %sol = poissonSol2D(points, sigma);
    
    rho = gaussian2D(points, sigma);
    Gs = G02D(L, N);
    A = convolution2D(Gs, rho, N);
    
    [err(idx), I] = max(abs(A - sol));    
end
plot(Ns, log(err));
disp(err);
title('Convergence of Poisson''s equation in 2D');
xlabel('Number of points')
ylabel('log of Maximum error')
ax = gca;
ax.FontSize = 14;