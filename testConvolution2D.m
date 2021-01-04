% Tests convolution2D.m as compared to MATLAB's conv2 function.

clear;

N = 16;
h = 1/N;

xs = -0.5:h:0.5-h;
ys = xs;

points = zeros(N,N);

for i=1:N
    for j=1:N
        points(i,j) = norm([xs(i) ys(j)]);
    end
end
points = reshape(points, [N^2 1]);

%%
% convolve two Gaussians
sigma = 1;

fs = gaussian2D(points, sigma);
gs = gaussian2D(points, sigma);
fs = reshape(fs, [N N]);
gs = reshape(gs, [N N]);

% zero-pad
zfs = zeros(4*N,4*N);
gfs = zeros(4*N,4*N);
for i=1:N
    for j=1:N
        zfs(i,j) = fs(i,j);
        gfs(i,j) = gs(i,j);
    end
end

% calculate the FFT of fs
Fs = fft2(zfs);
Fs = fftshift(Fs);

gs = reshape(gs, [N^2 1]);

% computes the convolution of zfs and gfs given Fs=fftshift(fft2(sfz))
myConv = convolution2D(Fs,gs,N);

actualConv = conv2(zfs,gfs);
actualConv = actualConv(1:N, 1:N);
actualConv = reshape(actualConv, [N^2 1]);
disp(max(abs(myConv - actualConv)));

%%
% Convolve x.^3 with itself.
N = 16;
h = 1/N;
rhs = @(x) x.^3;

fs = rhs(points);
gs = rhs(points);
fs = reshape(fs, [N N]);
gs = reshape(gs, [N N]);

zfs = zeros(4*N,4*N);
gfs = zeros(4*N,4*N);
for i=1:N
    for j=1:N
        zfs(i,j) = fs(i,j);
        gfs(i,j) = gs(i,j);
    end
end

Fs = fft2(zfs);
Fs = fftshift(Fs);

gs = reshape(gs, [N^2 1]);
myConv = convolution2D(Fs,gs,N);

actualConv = conv2(zfs,gfs);
actualConv = actualConv(1:N, 1:N);
actualConv = reshape(actualConv, [N^2 1]);

disp(max(abs(myConv - actualConv)));

%%
% Convolve sin(x) with a vector of ones.

fs = sin(points);
gs = ones(size(points));
fs = reshape(fs, [N N]);
gs = reshape(gs, [N N]);

zfs = zeros(4*N,4*N);
zgs = zeros(4*N,4*N);
for i=1:N
    for j=1:N
        zfs(i,j) = fs(i,j);
        zgs(i,j) = gs(i,j);
    end
end

Fs = fft2(zfs);
Fs = fftshift(Fs);
gs = reshape(gs, [N^2 1]);

myConv = convolution2D(Fs,gs,N);

actualConv = conv2(zfs,zgs);
actualConv = actualConv(1:N, 1:N);
actualConv = reshape(actualConv, [N^2 1]);

disp(max(abs(myConv - actualConv)));