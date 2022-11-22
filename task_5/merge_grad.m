function [Gx, Gy] = merge_grad(GxA, GyA, GxB, GyB, M)

    Gx = zeros(size(GxA,1:2));
    Gy = zeros(size(GyA,1:2));

    msize = size(M);
    for i = 1:msize(1)
        for j = 1:msize(2)
            if M(i,j) == 0
                Gx(i,j) = sqrt(sum(GxA(i,j,:).^2));
                Gy(i,j) = sqrt(sum(GyA(i,j,:).^2));
            else
                Gx(i,j) = sqrt(sum(GxB(i,j,:).^2));
                Gy(i,j) = sqrt(sum(GyB(i,j,:).^2));
            end
        end
    end
...