function [dx, dy] = translation_from_phase_corr(im1, im2)
% function [dx, dy] = translation_from_phase_corr(im1, im2)
% using phase correlation, this function computes 
% the vector (dx, dy) by which the second image im2 has to be shifted
% so that it matches the first one (im1)

f1 = fft2(im1); 
f2 = fft2(im2); 

T = conj(f1).*f2./abs(conj(f1).*f2);


im3 = ifft2(T);

im3 = fftshift(im3);

[c_x,c_y] = ffcenter(im3);

max = 0;
max_coord_x = 0;
max_coord_y = 0;
for i = 1:size(im3,1)
    for j = 1:size(im3,2)
        if im3(i,j) > max
            max = im3(i,j);
            max_coord_y = i;
            max_coord_x = j;
        end
    end
end

dy = -(max_coord_y - c_y);
dx = -(max_coord_x - c_x);
...

% (note: you may find function ffcenter.m provided useful)
