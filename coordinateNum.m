%% Joint Coordinate Numbers
ncjt = 2;
nsc = zeros(1,ncjt*nj)';  %dimension and allocate coordinate number vector
i = 1; j = 0;k = ndof; 

while i <= nj   % main loop
    icount = 0;
    i1 = 1;
    while i1 <= ns %check each joint, starting at 1
        if msup(i1,1) == i   %check that joint is in the restriant list
            icount = 1;
            i2 = 1;
            while i2 <= ncjt
                i3 = (i-1)*ncjt + i2;
                if msup(i1,i2 + 1) == 1     % check that the dofs have restraints
                    k = k + 1;
                    nsc(i3) = k;
                    i2 = i2 + 1;
                else
                    j = j + 1;
                    nsc(i3) = j;
                    i2 = i2 + 1;
                end
            end
            i1 = i1 + 1;
        else
            i1 = i1 + 1;
        end
    end
    if icount == 0 % when i1 exceeds 3 move to this loop and continue checking.
        i2 = 1;
        while i2 <= ncjt    
            i3 = (i-1)*ncjt + i2;
            j = j + 1;
            nsc(i3) = j;
            i2 = i2 + 1;
        end
        i = i + 1;  %increment i so values can be added to NSC()
    else
        i = i + 1;  
    end
    
end
        

