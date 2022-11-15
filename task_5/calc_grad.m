function [Gx, Gy] = calc_grad(I)

    Gx = zeros(size(I));
    Gy = zeros(size(I));

    imsize = size(I);
    for i = 1:imsize(1)
        for j = 1:imsize(2)
            if j < imsize(2) && i < imsize(1)
                Gx(i, j) = I(i, j) - I(i, j+1);
                Gy(i, j) = I(i, j) - I(i+1, j);
            elseif j == imsize(2) && i < imsize(1)
                Gx(i, j) = 0;
                Gy(i, j) = I(i, j) - I(i+1, j);
            elseif i == imsize(1) && j < imsize(2)
                Gx(i, j) = I(i, j) - I(i, j+1);
                Gy(i, j) = 0;       
            end
        end
    end
...