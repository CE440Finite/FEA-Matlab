function p=jointload(ndof,jp,pj,nsc,ncjt)
 
njl = length(jp);
p=zeros(ndof,1);    %Creates P (Load Vector)
i=1;
 
while i<=ndof
    p(i)=0;
    i=i+1;
end
i=1;
        while i<=njl
            I1=jp(i);   %Reads the value of the ith row in JP
            I2=(I1-1)*ncjt; % Computes I2 in order to find the x component of the joint I
            j=1;
            
            while j<=ncjt
                I2=I2+1;    %Increasing the I2 by 1 In order to find the y component of the joint I
                N=nsc(I2);  %Goes to row I2 of the NSC vector and assigns the value to N
                
                if N<=ndof
                    p(N)=p(N)+pj(i,j);  % Assigns values to the P vector
                    j=j+1;
                else
                    j=j+1;
                end
            end
            i=i+1;
        end       
