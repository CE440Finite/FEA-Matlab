function s = stores(jb,je,ncjt,ndof,nsc,gk)
s = zeros(ndof, ndof);
i = 1;
while i <= 2*ncjt
    if i <= ncjt
        i1 = (jb - 1)* ncjt + i;
        n1 = nsc(i1);
    else
        i1 = (je - 1)*ncjt + (i - ncjt);
        n1 = nsc(i1);
    end
    
    if n1 <= ndof
        j = 1;
        while j <= 2*ncjt
            if j <= ncjt
                i1 = (jb - 1)*ncjt + 1;
                n2 = nsc(i1);
            else
                i1 = (je - 1)*ncjt + (j - ncjt);
                n2 = nsc(i1);
            end
            
            if n2 <= ndof
                s(n1,n2) = s(n1,n2) + gk(i,j);
                j = j + 1;
            else
                j = j + 1;
            end
        end
        i = i + 1;
    else
        i = i + 1;
    end
end
end
