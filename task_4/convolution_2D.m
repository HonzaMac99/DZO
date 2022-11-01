function image_out = convolution_2D(image, kernel)
%CONVOLUTION_2D 2D convolution between an image and kernel
% image:
%   the input grayscale image (2D array)
% kernel:
%   the convolutional kernel (2D array)

%% TODO 1a: implement brute-force convolution using loops
% - implement "DC" padding
%   - for the pixels in areas, where the kernel would look outside of 
%     the original image, use the nearest image pixel (clip the coordinates)
image_out = zeros(size(image));

end
