function [nr, ndof] = degreesFreedom(ncjt, msup, ns, nj)

i = 1; nr = 0; ncjt = 2;		%set the number of restraints (nr) = 0, for trusses ncjt = 2
		
while i <= ns		%msup matrix has dimensions (ns,3) where ns = number of supported joints, iterations occurs vertically
    i1 = 2;		%iteration excludes first row of msup and works on msup(:,2:3)
    while i1 <= ncjt + 1	%check columns 2 and 3, iteration occurs horizontally
        if msup(i,i1) == 1	%check that he degree of freedom is restrained
            nr = nr + 1;		%increase nr by one
            i1 = i1 + 1;		%increase i1 to check next column
        else
            i1 = i1 + 1;		%if condition is zero, increment i1 and continue with the parent loop
            continue
        end
    end
    i = i + 1;			%move to next row and repear process
end
ndof = ncjt*nj-nr;
end
        
