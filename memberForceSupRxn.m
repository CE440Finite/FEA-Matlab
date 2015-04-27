%% Determination of Member Forces and Support Reactions
bk = zeros(2*ncjt, 2*ncjt);
t = zeros(2*ncjt, 2*ncjt);
v = zeros(2*ncjt, 1);
u = zeros(2*ncjt, 1);
q = zeros(2*ncjt, 1);
f = zeros(2*ncjt, 1);
r = zeros(nr, 1);

i = 1;
while i <= nr
    r(i) = 0;
    i = i + 1;
end
im = 1; 

while im <= nm
    jb = mprp(im, 1);
    je = mprp(im, 2);
    i = mprp(im, 3);
    e = em(i);
    i = mprp(im, 4);
    a = cp(i);
    xb = coord(jb, 1);
    yb = coord(jb, 2);
    xe = coord(je, 1);
    ye = coord(je, 2);
    bl = sqrt((xe - xb).^2 + (ye - yb).^2);
    cx = (xe - xb)./bl;
    cy = (ye - yb)./bl;
    
    v = mdispg(jb,je,ncjt,ndof,nsc,p,v);
    t = mtrans(cx,cy,ncjt,t);
    u = mdispl(ncjt,v,t,u);
    bk = mstiffl(e,a,bl,ncjt,bk);
    q = mforcel(ncjt,bk,u,q);
    f = mforceg(ncjt,t,q,f);
    r = storer(jb,je,ncjt,ndof,nsc,f,r);

    im = im + 1;
end
