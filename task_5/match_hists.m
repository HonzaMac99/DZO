function img_matched = match_hists(img, img_target, intensity_levels)
    if ~exist('intensity_levels', 'var')
        intensity_levels = 256;
    end
    
    % get both CDFs
    cdf_A = compute_cdf(img);
    cdf_B = compute_cdf(img_target);
    
    % create histogram matching lookup table
    matching_lut = zeros(intensity_levels, 1);
    for i = 1:intensity_levels
        cdf_Ai = cdf_A(i);
        j = 1;
        while j < intensity_levels && cdf_Ai > cdf_B(j)
            j = j + 1;
        end
        matching_lut(i) = j;
    end
    
    % match the histograms    
    img_matched = img;  
    for i = 1:numel(img)
        intensity = round(img(i)*(intensity_levels-1)) + 1;
        match_intensity = matching_lut(intensity);
        img_matched(i) = (match_intensity - 1)/(intensity_levels-1);
    end
end
