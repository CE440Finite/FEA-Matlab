%Stiffiness matrix generation
NDOF% the degree of freedom will be define here
IND=[3 4 1 2];% index assigned for the degree of freedom at joints of the truss
for i=1:NDOF(4);% this i will have the  four values of assigned member end degree
                % of freedom
if IND(i)<=NDOF;
    for j=1:4;
        if ind(j)<=NDOF;
            S(ind(i),ind(j))=S(ind(i),ind(j)+K(i,j));
        end;
    end;
end;
end
