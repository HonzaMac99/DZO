function [im_transformed, t, phi, delta_t, delta_phi] = log_polar(im, cx, cy, H)
% function log_polar(im, H)
% cx, cy = center of transformation 
% H = radius (max distance from center of im) for which
% transformation should be computed

delta_t = 1/H;
delta_phi = 1/H;
N = log(H);

[t, phi] = meshgrid(0:delta_t:N, delta_phi:delta_phi:2*pi); 

x_ = exp(t).*cos(phi) + cx;
y_ = exp(t).*sin(phi) + cy;

    
im_transformed = interp2(im, x_, y_, 'linear', 0); 


