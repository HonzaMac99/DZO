
%%% read input images -> OK

A = double(imread('data/mona_lisa.png'));
B = double(imread('data/ginevra_benci.png'));

% A = double(imread('data/car_low.png'));
% B = double(imread('data/car_high.png'));

%%% compute gradients -> OK

[GxA, GyA] = calc_grad(A);
[GxB, GyB] = calc_grad(B);

% imshow(GxA/255+0.5);
% imshow(GyA/255+0.5);

%%% read/generate mask -> OK

M = double(imread('data/mona_mask.png'));
%M = get_mask(GxA, GyA, GxB, GyB);

% imshow(M/255);

%%% merge gradients -> OK

[Gx, Gy] = merge_grad(GxA, GyA, GxB, GyB, M);

%%% compute divergence -> OK

divI = calc_div(Gx, Gy);
%imshow(sum(divI,3)/255 + 0.5);

% divI = calc_div_img(A);
% imshow(divI(:,:,1)/255 + 0.5);

%%% compute naive merge -> OK

O = merge_image(A, B, M);
%imshow(O/255);

%%% save naive merge -> OK

imwrite(O/255,'0_before.png');

%%% solve using Gauss-Seidel / Poisson -> OK

% reduce the computations: create a bounding box over the mask 
% O = solve_GS(A, B, M, divI);
% imshow(O/255);


%%% solve using FT -> OK

% use lambda very small like 10^-14
% after wiener take only real values
% use fftshift on the laplace kernel in the F domain
% so that it will be in the pos of [0, 0] of the img

O = solve_FT(A, B, M, divI);
% for i = 1:3
%     O(:,:,i) = match_hists(O(:,:,i)/255, A(:,:,i)/255)*255;
% end
imshow(O/255);


%%% save output image -> OK

imwrite(O/255,'1_after.png');
