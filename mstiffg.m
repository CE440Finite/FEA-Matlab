function gk = mstiffg(e,a,bl,cx,cy,ncjt)
gk = zeros(2*ncjt, 2*ncjt);
z = (e*a)/bl;
z1 = z*(cx.^2);
z2 = z*(cy.^2);
z3 = z*cx*cy;


gk(1,1) = z1;
gk(2,1) = z3;
gk(3,1) = -z1;
gk(4,1) = -z3;
gk(1,2) = z3;
gk(2,2) = z2;
gk(3,2) = -z3;
gk(4,2) = -z2;
gk(1,3) = -z1;
gk(2,3) = -z3;
gk(3,3) = z1;
gk(4,3) = z3;
gk(1,4) = -z3;
gk(2,4) = -z2;
gk(3,4) = z3;
gk(4,4) = z2;
end
