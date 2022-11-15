function O = merge_image(A, B, M)

    O = zeros(size(M));

    msize = size(M);
    for i = 1:msize(1)
        for j = 1:msize(2)
            if M(i, j) == 0
                O(i, j) = A(i, j);
            else
                O(i, j) = B(i, j);
            end
        end
    end
...