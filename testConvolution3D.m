% Tests convolution3D.m as compared to MATLAB's convn function.

clear;

N = 16;
h = 1/N;

xs = -0.5:h:0.5-h;
ys = xs;
zs = xs;

points = zeros(N,N,N);

for i=1:N
    for j=1:N
        for k=1:N
            points(i,j,k) = norm([xs(i) ys(j) zs(k)]);
        end
    end
end
points = reshape(points, [N^3 1]);

%%
% convolve two Gaussians
sigma = 1;

fs = gaussian3D(sigma, points);
gs = gaussian3D(sigma, points);
fs = reshape(fs, [N N N]);
gs = reshape(gs, [N N N]);

zfs = zeros(4*N, 4*N, 4*N);
zgs = zeros(4*N, 4*N, 4*N);
for i=1:N
    for j=1:N
        for k=1:N
            zfs(i,j,k) = fs(i,j,k);
            zgs(i,j,k) = gs(i,j,k);
        end
    end
end

Fs = fftn(zfs);
Fs = fftshift(Fs);

gs = reshape(gs, [N^3 1]);
myConv = convolution3D(Fs,gs,N);
myConv = reshape(myConv, [N N N]);

actualConv = convn(zfs,zgs);
actualConv = actualConv(1:N, 1:N, 1:N);

disp(max(max(max(abs(myConv - actualConv)))));

%%
% Convolve x.^3 with itself.

rhs = @(x) x.^3;

fs = rhs(points);
gs = rhs(points);
fs = reshape(fs, [N N N]);
gs = reshape(gs, [N N N]);

zfs = zeros(4*N,4*N,4*N);
zgs = zeros(4*N,4*N,4*N);
for i=1:N
    for j=1:N
        for k=1:N
            zfs(i,j,k) = fs(i,j,k);
            zgs(i,j,k) = gs(i,j,k);
        end
    end
end

Fs = fftn(zfs);
Fs = fftshift(Fs);

gs = reshape(gs, [N^3 1]);
myConv = convolution3D(Fs,gs,N);
myConv = reshape(myConv, [N N N]);

actualConv = convn(zfs,zgs);
actualConv = actualConv(1:N, 1:N, 1:N);

disp(max(max(max(abs(myConv - actualConv)))));

%%
% Convolve sin(x) with a vector of ones.

fs = sin(points);
gs = ones(size(points));
fs = reshape(fs, [N N N]);
gs = reshape(gs, [N N N]);

zfs = zeros(4*N,4*N,4*N);
zgs = zeros(4*N,4*N,4*N);
for i=1:N
    for j=1:N
        for k=1:N
            zfs(i,j,k) = fs(i,j,k);
            zgs(i,j,k) = gs(i,j,k);
        end
    end
end

Fs = fftn(zfs);
Fs = fftshift(Fs);

gs = reshape(gs, [N^3 1]);
myConv = convolution3D(Fs,gs,N);
myConv = reshape(myConv, [N N N]);

actualConv = convn(zfs,zgs);
actualConv = actualConv(1:N, 1:N, 1:N);

disp(max(max(max(abs(myConv - actualConv)))));