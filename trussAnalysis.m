% This program determines the member forces, global reactions, local
% displacements, and global displacements of a plane truss.

%% INPUT
% Ask user for a project name, to be displayed in output file.
ncjt = 2;
name = input('Enter a project name: ','s');
disp(' ')

% Ask for joint coordinates.
disp('Input must be enclosed in the bracket [] with each entry separated by a space.')
disp('Consistent units are required as this program will not convert units.')
disp('  ')

nj = input('Enter the total number of joints in the truss: ');
xcoord = input('Enter, in increasing order, the X-coordinate of each joint: ');
ycoord = input('Enter, in increasing order, the Y-coordinate of each joint: ');
coord = [xcoord' ycoord'];

if size(coord,1) ~= nj
    error('Number of joints is not consistent with the number of coordinates entered.')
end

% Ask for joint restraints and restraint types.
disp('....................................................................')
disp('Restraint conditions are: 0 = FREE; 1= RESTRAINED');
disp(' ')
ns = input('How many joints are supported?: ');
jn = input('Enter the joint numbers for the supported joints: ');
xsup = input('Enter the restraint condition for each joint in the X-direction: ');
ysup = input('Enter the restraint condition for each joint in the Y-direction: ');
msup = [jn' xsup' ysup'];

% Ask for material property.
disp('....................................................................')
em = input('Enter the modulus of elasticity for all materials: ')';
id1 = [1:1:length(em)]';

% Ask for material cross sections.
disp('....................................................................')
disp(' ')
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

%%




