% Solves the Lippmann-Schwinger equation with q(x) being the smoothly
% filtered dielectric disk.

clear;

fN = 1024; % number of points on the fine grid
Ns = [8,16,32,64, 128, 256]; % number of points on the coarse grid(s)

diffs = zeros(size(Ns));
errs = zeros(size(Ns));
for i=1:length(Ns)
    diffs(i) = fN/Ns(i);
end

fAns = solveDielectricDiskFun(fN);
fAns = reshape(fAns, [fN fN]);

for i=1:length(Ns)
    N = Ns(i);
    cAns = solveDielectricDiskFun(N);
    cAns = reshape(cAns, [N N]);
    errs(i) = maxError(fAns, cAns, diffs(i));
end

disp(errs); % copy these into plot/plotLSExamples.m
plot(log(Ns), log(errs), '*-');
