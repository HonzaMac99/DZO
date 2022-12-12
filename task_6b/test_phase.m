im1 = double(imread('./A.png'))/255.0;
%im2 = double(imread('./A_t_80_-15.png'))/255.0;

% translate: 
tx = 50; 
ty = -15; 
[x, y] = meshgrid(1:N, 1:M); 
[x_, y_] = translation(x, y, -tx, -ty);
im3 = interp2(im1, x_, y_, 'linear', 0);


[dx, dy] = phase_corr(im1, im3)
