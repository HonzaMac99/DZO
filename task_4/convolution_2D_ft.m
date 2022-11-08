function image_out = convolution_2D_ft(image, kernel)
%CONVOLUTION_2D_FT 2D convolution using Fourier Transform
% image:
%   the input grayscale image (2D array)
% kernel:
%   the convolutional kernel (2D array)

%% TODO 2: implement convolution using Fourier transform

image_y = size(image, 1);
image_x = size(image, 2);

X1 = fft2(image);
K = fft2(kernel, image_y, image_x);
X2 = X1.*K;
image_out = ifft2(X2);

end
