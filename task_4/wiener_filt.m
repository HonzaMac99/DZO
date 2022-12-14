function image_out = wiener_filt(image, kernel, lambda)
%WIENER_FILT Wiener filtration
% image:
%   the input (blurred) grayscale image (2D array)
% kernel:
%   the convolutional kernel (2D array) which is causing the blur
% lambda:
%   parameter preventing the division by zero

% TODO 4: implement Wiener filter
% - transform both the image and the kernel into frequency domain, apply
%   the formula for the estimation of the unblured image and transform
%   the result back to the spatial domain

X1 = fft2(image);
K = fft2(kernel, size(image,1), size(image, 2));
%K_complement = real(K) - imag(K)*1i;
K_complement = conj(K);

X2 = K_complement.*X1./(abs(K).^2 + lambda);
image_out = ifft2(X2);

image_out = abs(image_out);

end

