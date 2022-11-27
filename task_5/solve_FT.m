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
    
    O = zeros(size(A));
    shift = -1;
    lshift = max(shift, 0);
    rshift = -max(-shift, 0);
    
    for i = 1:size(O,1)
        for j = 1:size(O,2)
            %if 1 < i && 1 < j
            if lshift < i && i < size(O,1) + rshift && ...
               lshift < j && j < size(O,2) + rshift
                if M(i-shift,j-shift) == 0
                    O(i,j,:) = A(i+1,j+1,:);
                else
                    O(i,j,:) = B(i+1,j+1,:);
                end
            end
        end
    end
    
  
    % imshow((O-divI)/255 + 0.5);
    
    % O_F = fft2(O);
    O_F = fft2(divI);
    O_F = conj(K).*O_F./(abs(K).^2 + lambda);
    
    O = real(ifft2(O_F)); 
    imshow(O/255);
    
    span_R = max(O(:,:,1),[],'all') - min(O(:,:,1),[],'all');
    span_G = max(O(:,:,2),[],'all') - min(O(:,:,2),[],'all');
    span_B = max(O(:,:,3),[],'all') - min(O(:,:,3),[],'all');
    O(:,:,1) = (O(:,:,1)-min(O(:,:,1),[],'all'))/span_R*255;
    O(:,:,2) = (O(:,:,2)-min(O(:,:,2),[],'all'))/span_G*255;
    O(:,:,3) = (O(:,:,3)-min(O(:,:,3),[],'all'))/span_B*255;
...