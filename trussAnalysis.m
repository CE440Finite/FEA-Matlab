% This program determines the member forces, global reactions, local
% displacements, and global displacements of a plane truss.

%% INPUT
% Ask user for a project name, to be displayed in output file.
ncjt = 2;
name = input('Enter a project name: ','s');

% Ask for joint coordinates.
disp('........................................................................................')
disp('Input must be enclosed in the bracket [] with each entry separated by a space or comma.')
disp('Consistent units are required as this program will not convert units.')
disp('........................................................................................')

nj = input('Enter the total number of joints in the truss: ');
xcoord = input('Enter, in increasing order, the X-coordinate of each joint: ');
ycoord = input('Enter, in increasing order, the Y-coordinate of each joint: ');
coord = [xcoord' ycoord'];

if size(coord,1) ~= nj
    error('Number of joints is not consistent with the number of coordinates entered.')
end

% Ask for joint restraints and restraint types.
disp('.....................................................................')
disp('Restraint conditions are: 0 = FREE; 1= RESTRAINED');
disp('.....................................................................')
ns = input('How many joints are supported?: ');
jn = input('Enter the joint numbers for the supported joints: ');
xsup = input('Enter the restraint condition for each joint in the X-direction: ');
ysup = input('Enter the restraint condition for each joint in the Y-direction: ');
msup = [jn' xsup' ysup'];

% Ask for material property.
disp('.....................................................................')
em = input('Enter the modulus of elasticity for all materials: ')';
id1 = [1:1:length(em)]';

% Ask for material cross sections.
disp('....................................................................')
cp = input('Enter the cross sectional area for the members: ')';
id2 = [1:1:length(cp)]';

% Display data for next input.
disp('....................................................................')
modulusTable = table(id1, em,'VariableNames',{'ID','Modulus'})
crossecTable = table(id2,cp,'VariableNames',{'ID','Area'})
disp('Using the ID from the modulus and cross section tables, enter ')
disp('the values corresponding to each member in the following format.')
disp('[START JOINT # , END JOINT #, MODULUS ID, CROSS SECTION ID]')
disp('....................................................................')

% Define each member.
nm = input('How many members are contained in the truss? ');
disp('Enter the member information as described above: ')
mprp = zeros(nm,4);
for i = 1:nm
    mbr = i; mbr = num2str(mbr);
    fprintf('Enter the Information for Member %s',mbr)
    mprp(i,:) = input(': ');
end

% Optional Conversion.
mtab = mprp;
% Modulus Conversion Loop.
for i = 1:length(em)
    idxm = find(mtab(:,3) == i);
    mtab(idxm,3) = em(i);
end

% Cross Section Conversion Loop.
for i = 1:length(cp)
    idxc = find(mtab(:,4) == i);
    mtab(idxc,4) = cp(i)*10;
end
mtab(:,4) = mtab(:,4)./10;
disp('....................................................................')

% Ask for joint loads.
jp = input('Enter the joints where loads are applied: ')';
pjx = input('Enter the loads that are applied in the X-direction: ')';
pjy = input('Enter the loads that are applied in the Y-direction: ')';

pj = [pjx pjy];
disp('....................................................................')

%% Number of Degrees of Freedom

% READ FROM FUNCTION FILE degreesFreedom.m
[nr, ndof] = degreesFreedom(ncjt, msup, ns, nj);

%% Structure Coordinate Numbers

%READ FROM FUNCTION FILE coordinateNum.m
nsc = coordinateNum(ncjt, nj,ns, ndof, msup);

%% Structure Stiffness Matrix
i = 1;
s = zeros(ndof, ndof);
while i <= ndof
    j = 1;
    while j <= ndof
        s(i,j) = 0;
        j = j + 1;
    end
    i = i + 1;
end
im = 1;

while im <= nm
    jb = mprp(im,1);
    je = mprp(im,2);
    i = mprp(im,3);
    e = em(i);
    i = mprp(im,4);
    a = cp(i);
    xb = coord(jb,1);
    yb = coord(jb,2);
    xe = coord(je,1);
    ye = coord(je,2);
    bl = sqrt((xe-xb).^2 + (ye - yb).^2);
    cx = (xe - xb)./bl;
    cy = (ye - yb)./bl;
    
    % --GLOBAL MEMBER STIFFNESS; from subroutine function file.
    
    gk = mstiffg(e,a,bl,cx,cy,ncjt);
    
    % --STIFFNESS MATRIX
    i = 1;
    while i <= 2*ncjt
        if i <= ncjt
            i1 = (jb - 1)* ncjt + i;
            n1 = nsc(i1);
        else
            i1 = (je - 1)*ncjt + (i - ncjt);
            n1 = nsc(i1);
        end
        
        if n1 <= ndof
            j = 1;
            while j <= 2*ncjt
                if j <= ncjt
                    i1 = (jb - 1)*ncjt + j;
                    n2 = nsc(i1);
                else
                    i1 = (je - 1)*ncjt + (j - ncjt);
                    n2 = nsc(i1);
                end
                
                if n2 <= ndof
                    s(n1,n2) = s(n1,n2) + gk(i,j);
                    j = j + 1;
                else
                    j = j + 1;
                end
            end
            i = i + 1;
        else
            i = i + 1;
        end
    end
    im = im + 1;
end
%% Joint Loads
%READ FROM FUNCTION FILE jointload.m

p = jointload(ndof,jp,pj,nsc,ncjt);


%%  Joint Displacement
% READ FROM FUNCTION FILE JointDisplacement.m
[s, p] = JointDisplacement(ndof,s,p);

%% Member Force and Joint Reactions
bk = zeros(2*ncjt, 2*ncjt);
t = zeros(2*ncjt, 2*ncjt);
v = zeros(2*ncjt, 1);
u = zeros(2*ncjt, 1);
q = zeros(2*ncjt, 1);
f = zeros(2*ncjt, 1);
r = zeros(nr, 1);
aforce = zeros(nm,1);

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
    
    % -- MDISPG
    i = 1;
    while i <= 2*ncjt
        v(i) = 0;
        i = i + 1;
    end
    j = (jb - 1)* ncjt;
    i = 1;
    
    while i <= ncjt
        j = j + 1;
        n = nsc(j);
        if n <= ndof
            v(i) = p(n);
            i = i + 1;
        else
            i = i + 1;
        end
    end
    j = (je - 1)*ncjt;
    i = ncjt + 1;
    
    while i <= 2*ncjt
        j = j + 1;
        n = nsc(j);
        if n <= ndof
            v(i) = p(n);
            i = i + 1;
        else
            i = i + 1;
        end
    end
    
    
    % -- MTRANS
    i = 1;
    while i <= 2*ncjt
        j = 1;
        while j <= 2*ncjt
            t(i,j) = 0;
            j = j + 1;
        end
        i = i + 1;
    end
    t(1,1) = cx;
    t(1,2) = cy;
    t(3,3) = cx;
    t(3,4) = cy;
    t(2,1) = -cy;
    t(2,2) = cx;
    t(4,3) = -cy;
    t(4,4) = cx;
    
    % -- MDISPL
    i = 1;
    while i <= 2*ncjt
        u(i) = 0;
        i = i + 1;
    end
    i = 1;
    
    while i <= 2*ncjt
        j = 1;
        while j <= 2*ncjt
            u(i) = u(i) + t(i,j) * v(j);
            j = j + 1;
        end
        i = i + 1;
    end
    
    % -- MSTIFFL
    i = 1;
    while i <= 2*ncjt
        j = 1;
        while j <= 2*ncjt
            bk(i,j) = 0;
            j = j + 1;
        end
        i = i + 1;
    end
    
    z = (e*a)./bl;
    bk(1,1) = z;
    bk(1,3) = -z;
    bk(3,1) = -z;
    bk(3,3) = z;
    
    % -- MFORCEL
    i = 1;
    while i <= 2*ncjt
        q(i) = 0;
        i = i + 1;
    end
    i = 1;
    
    while i <= 2*ncjt
        j = 1;
        while j <= 2*ncjt
            q(i) = q(i) + bk(i,j)* u(j);
            j = j + 1;
        end
        i = i + 1;
    end
    aforce(im) = q(1);

         
    
    % -- MFORCEG
    i = 1;
    
    while i <= 2*ncjt
        f(i) = 0;
        i = i + 1;
    end
    i = 1;
    while i <= 2*ncjt
        j = 1;
        while j <= 2*ncjt
            f(i) = f(i) + t(i,j)*q(j);
            j = j + 1;
        end
        i = i + 1;
    end
    
    % -- STORER
    
    i = 1;
    
    while i <= 2*ncjt
        if i <= ncjt
            i1 = (jb - 1)* ncjt + i;
            n = nsc(i1);
        else
            i1 = (je - 1)* ncjt + (i - ncjt);
            n = nsc(i1);
        end
        if n > ndof
            r(n-ndof) = r(n-ndof)+ f(i);
            i = i + 1;
        else
            i = i + 1;
        end
    end
    
    im = im + 1;
end
%%
dispvecloc = 1;  %place in displacement vector
xtrans = zeros(nj,1); % stores translations for joint
ytrans = zeros(nj,1);  % stores translations for joint
xsupchk = 1; % variable needed for cheking restraint conditions later in loop
ysupchk = 1; % variable needed for cheking restraint conditions later in loop
for n = 1:nj %checks all joints
	exist = 0; % variable for determing is a joint is restrained 
	for k = 1:ns %checks against all restrained joint
		if n == msup(k) %if a joint is restrained
			exist =  exist +1; %indicate it is restrained
			xsupchk = msup(k,2); %restrain conditions of x for joint
			ysupchk = msup(k,3); %restrain conditions of y for joint
		else 
			exist = exist; %for loop does not terminate,need to insure conditionstay
		end
	end
	if exist >= 1 % if joint is restrained
		if xsupchk == 0; %if x is free
			xtrans(n) = p(dispvecloc); % then x is displaced by 
			dispvecloc = dispvecloc + 1; %change location is P vector for next loop
		end
		if ysupchk == 0; %if y is free
			ytrans(n) = p(dispvecloc); % then y is displaced by 
			dispvecloc = dispvecloc + 1; %change location is P vector for next loop
		end
	else % if joint is not restrained 
		xtrans(n) = p(dispvecloc); % x displace 
		dispvecloc = dispvecloc + 1; % shift over in P
		ytrans(n) = p(dispvecloc); % Y displace
		dispvecloc = dispvecloc + 1; % shift over in P for next loop
	end
end

rvecloc = 1;  
xreac = zeros(ns,1); 
yreac = zeros(ns,1);  
xsupchk = 1; 
ysupchk = 1;
for n = 1:ns
    xsupchk = msup(n,2); 
	ysupchk = msup(n,3);
    if xsupchk == 1
      xreac(n) = r(rvecloc);
      rvecloc = rvecloc +1;
    end
    if ysupchk == 1
        yreac(n) = r(rvecloc);
        rvecloc = rvecloc +1;
    end
end

%% REPORT
% -- Execute .m file
report_output
disp('Note:')
dir = pwd;
outfile = strcat('Report file has been created and saved in: ',pwd,'/',fname);
disp(outfile)
imgfile = strcat('Truss image has been created and saved in: ',pwd,'/',name,'.tif');
disp(imgfile)






