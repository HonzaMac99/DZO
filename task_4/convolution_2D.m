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

ker_size_x = size(kernel, 1);
ker_size_y = size(kernel, 2);

for i = 1:size(image,1) % moves along y axis
    for j = 1:size(image,2) % moves along x axis
        image_sec = zeros(size(kernel));
        ker_start_x = j-round(ker_x/2);
        ker_start_y = i-round(ker_y/2);
        for k = 1:ker_size_y % moves along y axis
            for l = 1:ker_size_x % moves along x axis
                ker_x = ker_start_x + l;
                ker_y = ker_start_y + k;
                if (ker_x < 1 && ker_y < 1)
                    image_sec(k,l) = image(1, 1);
                elseif (ker_x > end && ker_y < 1)
                    image_sec(k,l) = image(
                end
            end
        end
    image_out(i,j) = sum(sum(image_sec.*kernel));
    end
end
