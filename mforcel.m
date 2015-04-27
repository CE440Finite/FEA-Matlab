function q = mforcel(ncjt, bk, u, q)
i = 1;
while i <= 2*ncjt
    q(i) = 0;
    i = i + 1;
end
i = 1;

while i <= 2*ncjt
    j = 1;
    while j <= 2*ncjt
        q(i) = q(i) + bk(i,j)* u(j);
        j = j + 1;
    end
    i = i + 1;
end    
end
