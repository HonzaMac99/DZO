function O = solve_FT(A, B, M, divI)

%     lambda = 10^-14;
%     kernel = [0 1 0; 1 -4 1; 0 1 0];
%     A_F = fft2(A(:,:,1));
%     K = fft2(kernel, size(A,1), size(A,2)); 
%     fftshift(K);
%     A_F = A_F.*K;
%     A_div = real(ifft2(A_F));
%     A_F = fft2(A_div);
%     A_F = conj(K).*A_F./(abs(K).^2 + lambda);
%     A_new = real(ifft2(A_F)); 
%     % why it is not the same here?
%     imshow(A(:,:,1)/255);
%     imshow(A_new/255);
     
    
    lambda = 10^-14;
    kernel = [0 1 0; 1 -4 1; 0 1 0];
    
    A_F = fft2(A, size(A,1), size(A,2));
    B_F = fft2(B, size(A,1), size(A,2));
    K = fft2(kernel, size(A,1), size(A,2));    
    
    
    A_F = A_F.*K;
    B_F = B_F.*K;
    
    A = ifft2(A_F);
    B = ifft2(B_F);
    
    
    % correct the shift and mask remnants of O to the correct divI
    O = zeros(size(A));
    shift = [-1,1];
    lshift = max(shift, 0);
    rshift = -max(-shift, 0);
    for i = 1:size(O,1)
        for j = 1:size(O,2)
            if lshift(1) < i && i < size(O,1) + rshift(1) && ...
               lshift(2) < j && j < size(O,2) + rshift(2)
                if M(i-shift(1),j-shift(2)) == 0
                    O(i,j,:) = A(i+1,j+1,:);
                else
                    O(i,j,:) = B(i+1,j+1,:);
                end
            end
        end
    end  
    imshow(O/255 + 0.5);
    imshow((O-divI)/255 + 0.5);
    
    
    O_F = fft2(O);
    % O_F = fft2(divI);
    O_F = conj(K).*O_F./(abs(K).^2 + lambda);
    
    O = real(ifft2(O_F)); 
    imshow(O/255);
    
    % correct the span of the values to range (0,255)
    for i = 1:3
        span = max(O(:,:,i),[],'all') - min(O(:,:,i),[],'all');
        O(:,:,i) = (O(:,:,1)-min(O(:,:,i),[],'all'))/span*255;
    end
...