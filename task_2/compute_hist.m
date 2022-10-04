function [img_hist] = compute_hist(img, intensity_levels)
%COMPUTE_HIST Summary of this function goes here
%   Detailed explanation goes here
    if ~exist('intensity_levels', 'var')
        intensity_levels = 256;
    end
    
    img_hist = zeros(intensity_levels, 1);
    
    for i = 1:numel(img)
        % mapping of <0,1> to <1,intensity_levels> scale
        intensity = round(img(i)*(intensity_levels-1)) + 1;
        img_hist(intensity) = img_hist(intensity) + 1;
    end      
    
%     bin_centers = linspace(0, 1, intensity_levels); 
%     bar(bin_centers, h);
%     title('histogram');
%     xlabel('intensity');
%     ylabel('frequency');
end

