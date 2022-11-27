function [divI] = calc_div_img(I)

    divI = zeros(size(I));

    for i = 1:size(I,1)
        for j = 1:size(I,2)        
            if 1 < j && j < size(I,2) && 1 < i && i < size(I,1)          
                div_x = I(i,j-1) - 2*I(i,j) + I(i,j+1);
                div_y = I(i-1,j) - 2*I(i,j) + I(i+1,j);
            elseif j == 1 && i == 1
                div_x = 0 - 2*I(i,j) + I(i,j+1);
                div_y = 0 - 2*I(i,j) + I(i+1,j);
            elseif j == 1 && 1 < i && i < size(I,1)
                div_x = 0 - 2*I(i,j) + I(i,j+1);
                div_y = I(i-1,j) - 2*I(i,j) + I(i+1,j);
            elseif 1 < j && j < size(I,2) && i == 1
                div_x = I(i,j-1) - 2*I(i,j) + I(i,j+1);
                div_y = 0 - 2*I(i,j) + I(i+1,j);               
            elseif j == size(I,2) && i == 1
                div_x = I(i,j-1) - 2*I(i,j) + 0;
                div_y = 0 - 2*I(i,j) + I(i+1,j);
            elseif j == 1 && i == size(I,1)
                div_x = 0 - 2*I(i,j) + I(i,j+1);
                div_y = I(i-1,j) - 2*I(i,j) + 0;
            elseif j == size(I,2) && 1 < i && i < size(I,1)
                div_x = I(i,j-1) - 2*I(i,j) + 0;
                div_y = I(i-1,j) - 2*I(i,j) + I(i+1,j);
            elseif 1 < j && j < size(I,2) && i == size(I,1)
                div_x = I(i,j-1) - 2*I(i,j) + I(i,j+1);
                div_y = I(i-1,j) - 2*I(i,j) + 0;
            elseif j == size(I,2) && i == size(I,1)
                div_x = I(i,j-1) - 2*I(i,j) + 0;
                div_y = I(i-1,j) - 2*I(i,j) + 0;
            end
            divI(i,j) = div_x + div_y;
        end
    end
   
...