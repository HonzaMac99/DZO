function [Gx, Gy] = calc_grad(I)

    Gx = zeros(size(I));
    Gy = zeros(size(I));

    for i = 1:size(I,1)
        for j = 1:size(I,2)
            if 1 < j && j < size(I,2) && 1 < i && i < size(I,1)
                Gx(i,j,:) = I(i,j,:) - I(i,j+1,:);   
                Gy(i,j,:) = I(i,j,:) - I(i+1,j,:);  
            end
        end
    end
    %Gx = -Gx;
    %Gy = -Gy;
...