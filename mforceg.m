function f = mforceg(ncjt,t,q)
i = 1;

while i <= 2*ncjt
    f(i) = 0;
    i = i + 1;
end
i = 1;

while i <= 2*ncjt
    j = 1;
    while j <= 2*ncjt
        f(i) = f(i) + t(i,j)*q(j);
        j = j + 1;
    end
    i = i + 1;
end
disp(f)
end
