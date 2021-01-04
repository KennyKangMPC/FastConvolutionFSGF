% Plots the solutions to the Lippmann-Schwinger tests
clear;
fineN = 1024;
Ns = [8, 16,32,64,128,256];

% Errors from the script solveDielectricDisk.m                    
dielectricDiskErrors = [0.011450846122062   0.004073130184295 ...
                        0.001044597178034   0.000261030919260 ...
                        0.000064596871671   0.000015393332957];
                    
% Errors from the script solveLunebergLens.m                    
lunebergLensErrors = [0.510014563188244   0.247416897833692 ...
                      0.119663450200507   0.057232479892734 ...
                      0.026513819818902   0.011313184699144];
                  
loglog(Ns, dielectricDiskErrors, 'o-');
hold on
loglog(Ns, lunebergLensErrors, 'v-');
hold off
legend({'Dielectric disk', 'Luneberg lens'});
title(['Log-log plot of relative error vs. grid spacing']);
xlabel(['Number of points']);
ylabel(['Maximum error']);
ax = gca;
ax.FontSize = 14;