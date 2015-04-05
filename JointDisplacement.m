% Calculation of joint displacements by Gauss- Jordan Elimination.

i = 1;
while i <= ndof
    z1 = s(i,i);
    j = 1;
    while j <= ndof
        s(i,j) = s(i,j)/Z1;
        j =j+1;
    end
    p(i) = p(i)/z1;
    k = 1;
    while k <= ndof
        if k == i
            k = k + 1;
        else
            z = s(k, i);
            m = 1;
            while m <= ndof
                s(k,m) = s(k,m) - s(i,m)*z;
                m = m + 1;
            end
            p(k) = p(k) - p(i)*z;
            k = k + 1;
        end
    end
    i = i + 1;
end
