function [img_cdf] = compute_cdf(img, intensity_levels)
%COMPUTE_CDF Summary of this function goes here
%   Detailed explanation goes here
    if ~exist('img', 'var')
        img = get_image('gantrycrane.png');
    end
    
    if ~exist('intensity_levels', 'var')
        intensity_levels = 256;
    end
    
    img_hist = compute_hist(img, intensity_levels);
    img_cdf = cumsum(img_hist);
    img_cdf = img_cdf / img_cdf(end);
    
%     bin_centers = linspace(0, 1, intensity_levels); 
%     plot(bin_centers, img_cdf);
%     title('CDF');
%     xlabel('intensity');
    
end

