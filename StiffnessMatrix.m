%Stiffiness matrix generation 
S=zeros(ndof,ndof); %initialize the stiffness matrix.ndof the degree 
                    %of freedom will be defined here 
   for i=1:nm
   jb=coord(i,:); % this portion will be consistent with the variable
                  %in input block
   je=coord(i+1,:);
   a=cp(i);
   em=em(i);
   
    for i=1:nj
   xb=coord(i,1);
   yb=coord(i,2);
   xe=coord(i+1,1);
   ye=coord(i+1,2);
   cosx=(xe-xb)/(sqrt((ye-yb)^2+(xe-xb)^2));
   sinx=(ye-yb)/(sqrt((ye-yb)^2+(xe-xb)^2));
    end
ind(1)=nsc((jb(1)-1)*ncjt+1);
ind(2)=nsc((jb(2)-1)*ncjt+2);
ind(3)=nsc((je(1)-1)*ncjt+1);
ind(4)=nsc((je(2)-1)*ncjt+2);

%global stiffness  
 for ik=1:4
     if ind(ik)<=ndof;
         for jk=1:4;
             if ind(jk)<=ndof;
               S(ind(ik),ind(jk))=S(ind(ik),ind(jk)+K(ik,jk));
             end
         end
     end
 end
   end;
         
