function [wave] = pWave2D(xs, k, N)
%pWave2D Equation for a plane wave in 2D
%
% input:
%       xs: a Nx2 matrix containing the points to be evaluated. xs(:,1) is
%       the x-coordinate and xs(:,2) is the y-coordinate

wave = zeros(N, 1);
for i=1:N
    wave(i) = exp(1i*k*xs(i,1))*exp(1i*k*xs(i,2));
end

end

