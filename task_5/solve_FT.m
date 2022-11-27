function O = solve_FT(A, B, M, divI)
% the FT does not work if the divergence is computed with
% transformed A, B whti FT and then laplacian kernel, the merged image
% using M will not work when IFFT back --> using divI to get the right
% solution    
    
    lambda = 10^-14;
    kernel = [0 1 0; 1 -4 1; 0 1 0];
    K = fft2(kernel, size(A,1), size(A,2));
    
    % A_F = fft2(A, size(A,1), size(A,2));
    % B_F = fft2(B, size(A,1), size(A,2));         
    % A_F = A_F.*K;
    % B_F = B_F.*K;    
    % A = ifft2(A_F);
    % B = ifft2(B_F);    
    % O_F = fft2(O);
    
    O_F = fft2(divI);
    O_F = conj(K).*O_F./(abs(K).^2 + lambda);
    
    O = real(ifft2(O_F)); 
    imshow(O/255);
    
    % correct the span of the values to range (0,255)
    for i = 1:3
        span = max(O(:,:,i),[],'all') - min(O(:,:,i),[],'all');
        O(:,:,i) = (O(:,:,i)-min(O(:,:,i),[],'all'))/span*255;
    end
...