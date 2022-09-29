function img_matched = match_hists(img, img_target, intensity_levels)
    if ~exist('intensity_levels', 'var')
        intensity_levels = 256;
    end
    
    % get both CDFs
    % TODO
    
    % create histogram matching lookup table
    matching_lut = zeros(intensity_levels, 1);
    % TODO
    
    % match the histograms    
    img_matched = img;  % TODO: replace with a histogram matching algorithm

end
