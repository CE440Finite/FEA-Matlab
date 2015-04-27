function t = mtrans(cx,cy,ncjt,t)
i = 1;
while i <= 2*ncjt
    j = 1;
    while j <= 2*ncjt
        t(i,j) = 0;
        j = j + 1;
    end
    i = i + 1;
end
t(1,1) = cx;
t(1,2) = cy;
t(3,3) = cx;
t(3,4) = cy;
t(2,1) = -cy;
t(2,2) = cx;
t(4,3) = -cy;
t(4,4) = cx;

end