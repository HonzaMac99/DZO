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
    
    kernel = ones(ker_size_y, ker_size_x)/(ker_size_y*ker_size_x);

end

% 3x3 Sobel filter
function kernel = sobel(direction)
    switch direction
        case 'x'
            kernel = [1 0 -1; 2 0 -2; 1 0 -1];
        case 'y'
            kernel = [1 2 1; 0 0 0; -1 -2 -1];
            
        otherwise
            error('Unknown direction parameter, use x or y')
    end
end

% Square Gaussian filter with given size and standard deviation
function kernel = gauss(ker_size, gauss_stddev)
    
    % gauss_stddev = sigma^2
    centre_y = ceil(ker_size/2);
    centre_x = ceil(ker_size/2);
    
    kernel = zeros(ker_size, ker_size);
    for i = 1:ker_size
        for j = 1:ker_size
            y = i - centre_y;
            x = j - centre_x;
            %kernel(i, j) = exp(-(x^2 + y^2)/(2*gauss_stddev));
            kernel(i, j) = 1/(2*pi*gauss_stddev)*exp(-(x^2 + y^2)/(2*gauss_stddev));
        end
    end

    kernel = kernel ./ sum(sum(kernel));
end

% Gauss Derivation in the given direction
function kernel = dgauss(ker_size, gauss_stddev, der_var)

    % gauss_stddev = sigma^2  
    centre_y = ceil(ker_size/2);
    centre_x = ceil(ker_size/2);

    switch der_var
        case 'x'
            % - filter highlighting intensity changes in the x direction
            kernel = zeros(ker_size, ker_size);
            for i = 1:ker_size
                for j = 1:ker_size
                    y = i - centre_y;
                    x = j - centre_x;
                    kernel(i, j) = exp(-(x^2 + y^2)/(2*gauss_stddev))*x/gauss_stddev;
                end
            end


        case 'y'
            % - filter highlighting intensity changes in the y direction
            kernel = zeros(ker_size, ker_size);
            for i = 1:ker_size
                for j = 1:ker_size
                    y = i - centre_y;
                    x = j - centre_x;
                    kernel(i, j) = exp(-(x^2 + y^2)/(2*gauss_stddev))*y/gauss_stddev;
                end
            end

        otherwise
            error('Unknown derivation variable parameter, use x or y')     
    end
    %creates a lot of computational error
    %kernel = kernel ./ sum(sum(kernel));
end

% Laplacian of Gaussian (LoG)
function kernel = lgauss(ker_size, gauss_stddev)

    % gauss_stddev = sigma^2  
    centre_y = ceil(ker_size/2);
    centre_x = ceil(ker_size/2);
    
    kernel = zeros(ker_size, ker_size);
    for i = 1:ker_size
        for j = 1:ker_size
            y = i - centre_y;
            x = j - centre_x;
            e = exp(-(x^2 + y^2)/(2*gauss_stddev));
            kernel(i, j) = e*((x^2 + y^2)/gauss_stddev -2)/gauss_stddev;
        end
    end
    %creates a lot of computational error
    %kernel = kernel ./ abs(sum(sum(kernel)));
end

%% 3: Implement simple separable kernels (average, sobel, gauss)
function [kernel_x, kernel_y] = average_sep(ker_size_x, ker_size_y)
    % - return kernel_x (row vector) and kernel_y (column vector)
    % - kernel_y * kernel_x should produce the resulting 2D kernel

    kernel_y = ones(ker_size_y, 1)/ker_size_y;
    kernel_x = ones(1, ker_size_x)/ker_size_x;

end

% Separable 3x3 Sobel filter
function [kernel_x, kernel_y] = sobel_sep(direction)
    switch direction
        case 'x'
            % - filter highlighting intensity changes in the x direction
            kernel_x = [1 0 -1];
            kernel_y = [1; 2; 1];

        case 'y'
            % - filter highlighting intensity changes in the y direction
            kernel_x = [1 2 1];
            kernel_y = [1; 0; -1];

        otherwise
            error('Unknown direction parameter, use x or y')
    end
end

% Separable Gauss filter
function [kernel_x, kernel_y] = gauss_sep(ker_size, gauss_stddev)

    % gauss_stddev = sigma^2
    center = ceil(ker_size/2);   
    kernel_x = zeros(1, ker_size);
    kernel_y = zeros(ker_size, 1);

    for i = 1:ker_size
        pos = i - center;
        kernel_x(i) = 1/sqrt(2*pi*gauss_stddev)*exp(-(pos^2)/(2*gauss_stddev));
        kernel_y(i) = 1/sqrt(2*pi*gauss_stddev)*exp(-(pos^2)/(2*gauss_stddev));
    end
 
    kernel_x = kernel_x ./ sum(sum(kernel_x));
    kernel_y = kernel_y ./ sum(sum(kernel_y));
end