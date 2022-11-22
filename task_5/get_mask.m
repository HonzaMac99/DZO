function M = get_mask(GxA, GyA, GxB, GyB)

    msize = size(GxA,1:2);
    M = zeros(msize);

    for i = 1:msize(1)
        for j = 1:msize(2)   
            Gxa = sqrt(sum(GxA(i,j,:).^2));
            Gya = sqrt(sum(GyA(i,j,:).^2));
            Gxb = sqrt(sum(GxB(i,j,:).^2));
            Gyb = sqrt(sum(GyB(i,j,:).^2));
            
            grad_len_a = sqrt(Gxa^2 + Gya^2);
            grad_len_b = sqrt(Gxb^2 + Gyb^2);
            if grad_len_a < grad_len_b
                M(i,j) = 255;
            end          
        end
    end
...