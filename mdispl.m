function u = mdispl(ncjt, v, t, u)
i = 1;
while i <= 2*ncjt
    u(i) = 0;
    i = i + 1;
end
i = 1;

while i <= 2*ncjt
    j = 1;
    while j <= 2*ncjt
        u(i) = u(i) + t(i,j) * v(j);
        j = j + 1;
    end
    i = i + 1;
end
end