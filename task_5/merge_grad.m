function [Gx, Gy] = merge_grad(GxA, GyA, GxB, GyB, M)

    Gx = zeros(size(GxA));
    Gy = zeros(size(GyA));

    msize = size(M);
    for i = 1:msize(1)
        for j = 1:msize(2)
            if M(i, j) == 0
                Gx(i, j) = GxA(i, j);
                Gy(i, j) = GyA(i, j);
            else
                Gx(i, j) = GxB(i, j);
                Gy(i, j) = GyB(i, j);
            end
        end
    end
...