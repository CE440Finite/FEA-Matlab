% Create the joint load vector for the structure.

p = zeros(ndof,1);
i = 1;

while i <= ndof
    p(i) = 0;
    i = i + 1;
end

i = 1;
while i <= njl
    i1 = jp(i);
    i2 = (i1 - 1)* ncjt;
    j = 1;
    
    while j <= ncjt
        i2 = i2 + 1;
        n = nsc(i2);
        
        if n <= ndof
            p(n) = p(n) + pj(i,j);
            j = j + 1;
        else
        j = j + 1;
        end
    end
    i = i + 1;
end


    
            