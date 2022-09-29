function [img_cdf] = compute_cdf(img, intensity_levels)
%COMPUTE_CDF Summary of this function goes here
%   Detailed explanation goes here
    if ~exist('intensity_levels', 'var')
        intensity_levels = 256;
    end
    
    % TODO - replace the line below with computation of the image CDF:
    img_cdf = linspace(0, 1, intensity_levels);  % <= to be replaced
    
end

