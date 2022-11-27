function [divI] = calc_div(Gx, Gy)
    
    divI = zeros(size(Gx));

    for i = 1:size(Gx,1)
        for j = 1:size(Gx,2)        
            if 1 < j && j < size(Gx,2) && 1 < i && i < size(Gx,1)          
                div_x = Gx(i,j-1,:) - Gx(i,j,:);
                div_y = Gy(i-1,j,:) - Gy(i,j,:);
                divI(i,j,:) = div_x + div_y;
            end
        end
    end
   
...