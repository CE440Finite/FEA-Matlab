function r = storer(jb, je, ncjt, ndof, nsc, f, r)
i = 1;

while i <= 2*ncjt
    if i <= ncjt
        i1 = (jb - 1)* ncjt + i;
        n = nsc(i1);
    else
        i1 = (je - 1)* ncjt + (i - ncjt);
        n = nsc(i1);
    end
    if n > ndof
        r(n-ndof) = r(n-ndof)+ f(i);
        i = i + 1;
    else
        i = i + 1;
    end
end
end
