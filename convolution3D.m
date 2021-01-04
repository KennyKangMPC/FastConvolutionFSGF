function [vec] = convolution3D(Gs,b, N)
%convolution2D Zero pads b to 4 times it's size and calculates 
%              ifft(Gs.*fft(b)) in three dimensions
%
%   input:
%         Gs: Assumed to be G_0^L or G_k^L, the spectral representation of
%             a Green's function
%          b: Vector of size NxNxN
%          N: number of grid points in one dimension

ss = reshape(b, [N N N]);

tmp = zeros(4*N,4*N, 4*N);

% need to zero-pad b (renamed ss)
for i=1:N
    for j=1:N
        for k=1:N
            tmp(i, j, k) = ss(i, j, k);
        end
    end
end

Bfft = fftshift(fftn(tmp));
GBfft = Gs.*Bfft;
GBifft = ifftn(ifftshift(GBfft));

% undo zero padding to get proper size
for i=1:N
    for j=1:N
        for k=1:N
        ss(i,j,k) = GBifft(i, j, k);
        end
    end
end

vec = reshape(ss, [N^3 1]);

end

