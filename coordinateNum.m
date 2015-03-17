%% Joint Coordinate Numbers, Sec 4.2

nsc = zeros(1,ncjt*nj);  %dimension and allocate coordinate number vector
i = 1; j = 0; k = ndof;

while i <= nj   % main loop
    icount = 0;
    i1 = 1;
    while i1 <= ns
        if msup(i1,1) ==1
            icount = 1;
            i2 = 1;
        else
            i1 = i1 + 1;
            break
        end
        % end for now tt
end
