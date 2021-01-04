function [qx] = lunebergLens(rs)
%lunebergLens The equation for the Luneberg Lens in 2D
%
% input:
%       rs: vector of norms of points at which the solution should be
%           calculated

qx = zeros(size(rs));
for i=1:length(rs)
    qx(i) = 1 - (rs(i)/0.45)^2;
end

end

