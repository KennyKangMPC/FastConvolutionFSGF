function [result] = solveLunebergLensFun(N)
%solveLunebergLensFun Solves the Lippmann-Schwinger integral equation for
%                     a given N where q(x) is the Luneberg Lens in 2D. Uses
%                     GMRES and the techniques in "Fast convolution with
%                     free-space Green's function".
L = 1.5;
k = 2;

points = zeros(N, N);
wPoints = zeros(N, N);

h = 1/N;
xs = -0.5:h:0.5-h;
ys = xs;

for i=1:N
    for j=1:N
        points(i,j) = norm([xs(i) ys(j)]);
        wPoints(i,j) = norm(xs(i));
    end
end

points = reshape(points, [N^2 1]);

wave = exp(k*1i*wPoints);
wave = reshape(wave, [N*N 1]);

qs = lunebergLens(points);

RHS = -(k^2).*qs.*wave;

Gs = Gk2D(k,L,N);
LHS = @(sigma) -sigma + (k^2).*qs.*convolution2D(Gs, sigma, N);

result = gmres(LHS, RHS, 100);   

end

