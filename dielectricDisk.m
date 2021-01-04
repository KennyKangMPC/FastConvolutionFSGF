function [qx] = dielectricDisk(rs)
%dielectricDisk The equation for the smoothly filtered flat dielectric disk
%               in 2D
%
%   Input: rs is a vector containing the norm of the points we wish to 
%          evaluate on. E.g., if we evaluate at the point [1,1] then the 
%          input should be norm([1,1]).

qx = zeros(size(rs));
for i=1:length(rs)
    qx(i) = exp(-0.5*(rs(i)/0.25)^8);
end

end

