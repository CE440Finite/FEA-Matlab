function v = mdispg(jb, je, ncjt, ndof, nsc, p, v)
i = 1;
while i <= 2*ncjt
    v(i) = 0;
    i = i + 1;
end

j = (jb - 1)* ncjt;
i = 1;

while i <= ncjt
    j = j + 1;
    n = nsc(j);
    if n <= ndof
        v(i) = p(n);
        i = i + 1;
    else
        i = i + 1;
    end
end
j = (je - 1)*ncjt;
i = ncjt + 1;

while i <= 2*ncjt
    j = j + 1;
    n = nsc(j);
    if n <= ndof
        v(i) = p(n);
        i = i + 1;
    else
        i = i + 1;
    end
end

end