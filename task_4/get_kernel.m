function [kernel_cb] = get_kernel(kernel_type, parameter)
%GET_KERNEL Returns a function generating the requested kernel
    
    switch kernel_type  % choose what to do next based on the requested kernel
        case 'identity'
            kernel_cb = @identity;
        case 'average'
            kernel_cb = @average;
        case 'sobel'
            kernel_cb = @sobel;
        case 'gauss'
            kernel_cb = @gauss;
        case 'dgauss'
            kernel_cb = @dgauss;
        case 'lgauss'
            kernel_cb = @lgauss;
        case 'average_sep'
            kernel_cb = @average_sep;
        case 'sobel_sep'
            kernel_cb = @sobel_sep;
        case 'gauss_sep'
            kernel_cb = @gauss_sep;
        otherwise
            error('Unknown kernel: %s', kernel_type)
    end
end

%% Example kernel (identity)
function kernel = identity(ker_size)
    kernel = zeros(ker_size);
    
    if mod(ker_size, 2) == 0
        kernel(ker_size/2, ker_size/2) = 1;
    else
        kernel(ceil(ker_size/2), ceil(ker_size/2)) = 1;
    end
end

%% 1b: Implement simple kernels (average, sobel, gauss, dgauss, lgauss)

% Averaging filter (all samples have the same value and sum to 1)
function kernel = average(ker_size_x, ker_size_y)
    % TODO
    kernel = zeros(ker_size_y, ker_size_x);

end

% 3x3 Sobel filter
function kernel = sobel(direction)
    switch direction
        case 'x'
            % - filter highlighting intensity changes in the x direction
            % TODO
            kernel = zeros(3, 3);

        case 'y'
            % - filter highlighting intensity changes in the y direction
            % TODO
            kernel = zeros(3, 3);
            
        otherwise
            error('Unknown direction parameter, use x or y')
    end
end

% Square Gaussian filter with given size and standard deviation
function kernel = gauss(ker_size, gauss_stddev)
    % TODO
    kernel = zeros(ker_size, ker_size);

    kernel = kernel ./ sum(sum(kernel));
end

% Gauss Derivation in the given direction
function kernel = dgauss(ker_size, gauss_stddev, der_var)
    
    switch der_var
        case 'x'
            % - filter highlighting intensity changes in the x direction
            % TODO
            kernel = zeros(ker_size, ker_size);

        case 'y'
            % - filter highlighting intensity changes in the y direction
            % TODO
            kernel = zeros(ker_size, ker_size);

        otherwise
            error('Unknown derivation variable parameter, use x or y')     
    end
    
    %kernel = kernel ./ sum(sum(kernel));
end

% Laplacian of Gaussian (LoG)
function kernel = lgauss(ker_size, gauss_stddev)
    % TODO
    kernel = zeros(ker_size, ker_size);
    
    %kernel = kernel ./ abs(sum(sum(kernel)));
end

%% 3: Implement simple separable kernels (average, sobel, gauss)
function [kernel_x, kernel_y] = average_sep(ker_size_x, ker_size_y)
    % - return kernel_x (row vector) and kernel_y (column vector)
    % - kernel_y * kernel_x should produce the resulting 2D kernel
    % TODO
    kernel_x = zeros(1, ker_size_x);
    kernel_y = zeros(ker_size_y, 1);

end

% Separable 3x3 Sobel filter
function [kernel_x, kernel_y] = sobel_sep(direction)
    switch direction
        case 'x'
            % - filter highlighting intensity changes in the x direction
            % TODO
            kernel_x = zeros(1, 3);
            kernel_y = zeros(3, 1);

        case 'y'
            % - filter highlighting intensity changes in the y direction
            % TODO
            kernel_x = zeros(1, 3);
            kernel_y = zeros(3, 1);

        otherwise
            error('Unknown direction parameter, use x or y')
    end
end

% Separable Gauss filter
function [kernel_x, kernel_y] = gauss_sep(ker_size, gauss_stddev)
    % TODO
    kernel_x = zeros(1, ker_size);
    kernel_y = zeros(ker_size, 1);

    kernel_x = kernel_x ./ sum(sum(kernel_x));
    kernel_y = kernel_y ./ sum(sum(kernel_y));
end