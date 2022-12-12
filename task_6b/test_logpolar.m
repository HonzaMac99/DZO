im = mean(double(imread('ph.jpg'))/255.0, 3);
cx = 257; cy = 257; H = 250;
[im_transformed, t, phi, delta_t, delta_phi] = log_polar(im, cx, cy, H);
%figure();
%imagesc(im); colormap gray; axis equal;
figure();
imagesc(im_transformed); colormap gray; axis equal
disp([min(t(:)), max(t(:)), min(phi(:)), max(phi(:))])
delta_t, delta_phi
