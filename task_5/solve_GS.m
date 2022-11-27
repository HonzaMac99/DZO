function O = solve_GS(A, B, M, divI)

    O = zeros(size(A));
    
    % create bounding box
    min_x = size(A,2);
    max_x = 0;
    min_y = size(A,1);
    max_y = 0;
    
    for i = 1:size(M,1)
        for j = 1:size(M,2)
            if M(i,j) > 0
                if j < min_x
                    min_x = j;
                end
                if j > max_x
                    max_x = j;
                end               
                if i < min_y
                    min_y = i;
                end
                if i > max_y 
                    max_y = i;
                end
            end
        end
    end
    
    O = A;
    iterations = 25;
    for a = 1:iterations  
        for i = 1:size(O,1)
            for j = 1:size(O,2)
                if min_x < j && j < max_x && min_y < i && i < max_y
                    O(i,j,:) = O(i+1,j,:) + O(i-1,j,:) + O(i,j+1,:) + O(i,j-1,:) - divI(i,j,:);
                    O(i,j,:) = O(i,j,:)/4;
                    %O(i,j,:) = divI(i,j,:);
                end
            end
        end
        %imshow(O/255);
    end
...