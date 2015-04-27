% Stiffness Matrix
i = 1;
s = zeros(ndof, ndof);
while i <= ndof
    j = 1;
    while j <= ndof
        s(i,j) = 0;
        j = j + 1;
    end
    i = i + 1;
end
im = 1;

while im <= nm
    jb = mprp(im,1);
    je = mprp(im,2);
    i = mprp(im,3);
    e = em(i)
    i = mprp(im,4);
    a = cp(i)
    xb = coord(jb,1);
    yb = coord(jb,2);
    xe = coord(je,1);
    ye = coord(je,2);
    bl = sqrt((xe-xb).^2 + (ye - yb).^2)
    cx = (xe - xb)./bl
    cy = (ye - yb)./bl
    
    % --GLOBAL MEMBER STIFFNESS; from subroutine function file.
    
    gk = mstiffg(e,a,bl,cx,cy,ncjt)
    
    % --STIFFNESS MATRIX
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
                    i1 = (jb - 1)*ncjt + j;
                    n2 = nsc(i1);
                else
                    i1 = (je - 1)*ncjt + (j - ncjt);
                    n2 = nsc(i1);
                end
                
                if n2 <= ndof
                    s(n1,n2) = s(n1,n2) + gk(i,j)
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
    im = im + 1;
end
s
