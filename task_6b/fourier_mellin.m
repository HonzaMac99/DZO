function [s_estimated, phi_estimated] = fourier_mellin(im1, im2, H) 

f1 = fft2(im1); 
f2 = fft2(im2); 

m1 = abs(f1); 
m2 = abs(f2); 

[cx, cy] = ffcenter(m1); 

[m1_t, t, phi, delta_t, delta_phi] = log_polar(fftshift(m1), cx, cy, H); 
[m2_t, t, phi, delta_t, delta_phi] = log_polar(fftshift(m2), cx, cy, H); 

...
