
%im = mean(double(imread('A.png'))/255.0, 3);
im = mean(double(imread('ph.jpg'))/255.0, 3);

[M, N] = size(im); 

tx = 50; 
ty = -15; 
s = 1.25; 
phi_rot = 45/180*pi; 
[cx, cy] = ffcenter(im); 


% scale, rotate, translate: 
[x, y] = meshgrid(1:N, 1:M); 
[x_, y_] = translation(x, y, -tx, -ty);
[x_, y_] = scaling(x_, y_, 1/s, cx, cy);
[x_, y_] = rotation(x_, y_, -phi_rot, cx, cy);
im_rst = interp2(im, x_, y_, 'linear', 0);

% figure();
% imagesc(im); colormap gray; axis equal; title('original image')
% figure();
% imagesc(im_rst); colormap gray; axis equal; title('new image')

%imwrite(A_rst, 'A_rst.png');
%imwrite(im_rst, 'ph_rst.png');


% fourier-mellin 
[cx, cy] = ffcenter(im_rst);
margin = 20;
H = size(im, 2) - cx - margin; 

[s_estimated, phi_estimated] = fourier_mellin(im, im_rst, H) 


% undo rotation and scale: 
[x, y] = meshgrid(1:N, 1:M); 
[x_, y_] = rotation(x, y, -phi_estimated, cx, cy);
[x_, y_] = scaling(x_, y_, s_estimated, cx, cy);
scale_rot_undone = interp2(im_rst, x_, y_, 'linear', 0);

figure();
imagesc(scale_rot_undone); colormap gray; axis equal;
title('new image / scale, rotation undone')


% also estimate translation: 
[sx, sy] = phase_corr(im, scale_rot_undone);
[x_, y_] = translation(x, y, -sx, -sy);
all_undone = interp2(scale_rot_undone, x_, y_, 'linear', 0);

figure();
imagesc(all_undone); colormap gray; axis equal;
title('new_img / scale, rotation, translation undone')
figure();
imagesc(im - all_undone); axis equal
title('difference w.r.t. im1')


