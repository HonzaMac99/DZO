function O = merge_image(A, B, M)

    msize = size(M);
    O = zeros(size(A));
    
    for i = 1:msize(1)
        for j = 1:msize(2)
            if M(i,j) == 0
                O(i,j,:) = A(i,j,:);
            else
                O(i,j,:) = B(i,j,:);
            end
        end
    end
...