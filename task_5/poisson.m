
%%% read input images

A = double(imread('data/mona_lisa.png'));
B = double(imread('data/ginevra_benci.png'));

% A = double(imread('data/car_low.png'));
% B = double(imread('data/car_high.png'));

%%% compute gradients

[GxA, GyA] = calc_grad(A);
[GxB, GyB] = calc_grad(B);

%%% read/generate mask

M = double(imread('data/mona_mask.png'));

% M = get_mask(GxA, GyA, GxB, GyB);

%%% merge gradients

[Gx, Gy] = merge_grad(GxA, GyA, GxB, GyB, M);

%%% compute divergence

divI = calc_div(Gx, Gy);

%%% compute naive merge

O = merge_image(A, B, M);

%%% save naive merge

imwrite(O/255,'0_before.png');

%%% solve using Gauss-Seidel / Poisson

O = solve_GS(A, B, M, divI);

% O = solve_FT(A, B, M, divI);

%%% save output image

imwrite(O/255,'1_after.png');
