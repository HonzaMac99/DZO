function [img_hist] = compute_hist(img, intensity_levels)
%COMPUTE_HIST Summary of this function goes here
%   Detailed explanation goes here
    if ~exist('intensity_levels', 'var')
        intensity_levels = 256;
    end
    
    img_hist = zeros(intensity_levels, 1);
    
    % TODO: implement histogram computation
    
end

