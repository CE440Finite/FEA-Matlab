function bk = mstiffl(e,a,bl,ncjt)
i = 1;

while i <= 2*ncjt
    j = 1;
    while j <= 2*ncjt
        bk(i,j) = 0;
        j = j + 1;
    end
    i = i + 1;
end

z = (e*a)/bl;
bk(1,1) = z;
bk(1,3) = -z;
bk(3,1) = -z;
bk(3,3) = z;

disp(bk)

end
