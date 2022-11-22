function [divI] = calc_div(Gx, Gy)

    % convert gradients for 3 RGB to gradients of their norm
    gx = zeros(size(Gx,1:2));
    gy = zeros(size(Gy,1:2));

    for i = 1:size(Gx,1)
        for j = 1:size(Gx,2)
            gx(i,j) = sqrt(sum(Gx(i,j,:).^2));
            gy(i,j) = sqrt(sum(Gy(i,j,:).^2));
        end
    end
    
    divI = zeros(size(gx));

    for i = 1:size(Gx,1)
        for j = 1:size(Gx,2)        
            if j < size(Gx,2) && i < size(Gx,1)          
                div_x = gx(i,j) - gx(i,j+1);
                div_y = gy(i,j) - gy(i,j+1);
                divI(i,j) = div_x + div_y;
            elseif j == size(Gx,2) && i < size(Gx,1)
                divI(i,j) = gx(i,j) + gy(i,j) - gy(i+1,j);
            elseif i == size(Gx,1) && j < size(Gx,2)
                divI(i,j) = gx(i,j) - gx(i,j+1) + gy(i,j);     
            end
        end
    end
...