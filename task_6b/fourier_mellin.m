function [s_estimated, phi_estimated] = fourier_mellin(im1, im2, H) 

f1 = fft2(im1); 
f2 = fft2(im2); 

m1 = fftshift(abs(f1)); 
m2 = fftshift(abs(f2)); 

% figure();
% m1_spectrum = log(m1 + 1);
% imagesc(m1_spectrum); colormap gray; axis equal;
% title('m1')
% 
% figure();
% m2_spectrum = log(m2 + 1);
% imagesc(m2_spectrum); colormap gray; axis equal;
% title('m2')

[cx, cy] = ffcenter(m1); 

[m1_t, t, phi, delta_t, delta_phi] = log_polar(m1, cx, cy, H); 
[m2_t, t, phi, delta_t, delta_phi] = log_polar(m2, cx, cy, H); 

% figure();
% imagesc(m1_t); colormap gray; axis equal;
% title('m1_t')
%
% figure();
% imagesc(m2_t); colormap gray; axis equal;
% title('m2_t')

[s_estimated, phi_estimated] = phase_corr(m1_t, m2_t)
s_estimated = 1 + s_estimated*delta_t;    % ref: 1.25
phi_estimated = phi_estimated*delta_phi;  % ref: -45/180*pi = -0.7854
...
