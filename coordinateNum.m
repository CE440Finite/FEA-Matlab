%% Joint Coordinate Numbers, Sec 4.2

nsc = zeros(1,ncjt*nj);  %dimension and allocate coordinate number vector
i = 1; j = 0; k = ndof;

while i <= nj   % main loop
    icount = 0;
    i1 = 1;
    while i1 <= ns %check each joint, starting at 1
        if msup(i1,1) ==1   %check that joint is restrained
            icount = 1;
            i2 = 1;
        else
            i1 = i1 + 1;
            break
        end
        if i2 < ncjt
            i3 = (i-1)*ncjt + i2;
        else
            break
        end
        if msup(i1, i2 + 1) == 1 %check that there is a restraint, cond = 1.
            k = k + 1;
            nsc(i3) = k;
            i2 = i2 + 1
        else
            j = j + 1;
            nsc(i3) = j;
        end
    end
            
            
            
end
