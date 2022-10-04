array_A = linspace(1, 100, 10)
array_B = linspace(1, 256, 10)
array_C = zeros(10, 1);

for i = 1:numel(array_A)
    elem = array_A(i);
    j = 1;
    while j < 256 && elem < array_B(j)
        j = j + 1;
        array_C(i) = j;
    end
    %array_C(i) = j;
end
array_C
