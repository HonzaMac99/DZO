function [dx, dy] = translation_from_phase_corr(im1, im2)
% function [dx, dy] = translation_from_phase_corr(im1, im2)
% using phase correlation, this function computes 
% the vector (dx, dy) by which the second image im2 has to be shifted
% so that it matches the first one (im1)

f1 = fft2(im1); 
f2 = fft2(im2); 

...

% (note: you may find function ffcenter.m provided useful)
