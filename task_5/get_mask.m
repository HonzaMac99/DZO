function M = get_mask(GxA, GyA, GxB, GyB)

    M = zeros(size(GxA));

    msize = size(M);
    for i = 1:msize(1)
        for j = 1:msize(2)
            grad_len_a = sqrt(GxA(i,j)^2 + GyA(i,j)^2);
            grad_len_b = sqrt(GxB(i,j)^2 + GyB(i,j)^2);
            if grad_len_a < grad_len_b
                M(i,j,:) = 255;
            end
        end
    end
...