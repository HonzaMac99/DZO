function eq_img = hist_equalization(img)
    intensity_levels = 256;
    img_size = size(img);
 
    
    % compute the image CDF
    img_cdf = compute_cdf(img, intensity_levels);

    % equalize the image
    eq_img = zeros(img_size);
    for i = 1:numel(img)
        intensity = round(img(i)*(intensity_levels-1)) + 1;
        eq_img(i) = img_cdf(intensity);
    end
end