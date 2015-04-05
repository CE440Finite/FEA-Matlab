function r = storer(jb,je, ncjt, ndof, nsc,f)
i = 1;

while i <= 2*ncjt
    while i <= ncjt
        i1 = (jb - 1)* ncjt + i;
        n = nsc(i1);
    end
    i1 = (je - 1)* ncjt + (i - ncjt);
    n = nsc(i1);
    
    while n > ndof
        r(n-ndof) = r(n-ndof)+ f(i);
        i = i + 1;
    end
    i = i + 1;
end

disp(r)
end
