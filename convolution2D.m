function [vec] = convolution2D(Gs,b, N)
%convolution2D Zero pads b to 4 times it's size and calculates 
%              ifft(Gs.*fft(b)) in two dimensions
%
%   input:
%         Gs: Assumed to be G_0^L or G_k^L, the spectral representation of
%             a Green's function
%          b: Vector of size NxN
%          N: number of grid points in one dimension

ss = reshape(b, [N N]);

tmp = zeros(4*N,4*N);

% need to zero-pad b (renamed ss)
for i=1:N
    for j=1:N
        tmp(i, j) = ss(i,j);
    end
end

Bfft = fftshift(fft2(tmp));
GBfft = Gs.*Bfft;
GBifft = ifft2(ifftshift(GBfft));

% Undo zero padding to get proper size.
for i=1:N
    for j=1:N
        ss(i,j) = GBifft(i, j);
    end
end

vec = reshape(ss, [N*N,1]);

end

