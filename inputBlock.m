%% Computer Program for Analysis of Plane Trusses -- INPUT BLOCK
%% Project Name
name = input('Enter a project name: ','s');
disp(' ')
%% Request Joint Coordinates [x] and [y]
disp('Input must be enclosed in the bracket [] with each entry separated by a space.')
disp('Consistent units are required as this program will not convert units.')
disp('  ')

nj = input('Enter the total number of joints in the truss: ');
xcoord = input('Enter, in increasing order, the X-coordinate of each joint: ');
ycoord = input('Enter, in increasing order, the Y-coordinate of each joint: ');
coord = [xcoord' ycoord']; %Create COORD Matrix, [NJ x 2]

if size(coord,1) ~= nj
    error('Number of joints is not consistent with the number of coordinates entered.')
end

%% Request Joint Restraint Type and Joint Number
disp('....................................................................')
disp('Restraint conditions are: 0 = FREE; 1= RESTRAINED');
disp(' ')
ns = input('How many joints are supported?: ');
jn = input('Enter the joint numbers for the supported joints: ');
xsup = input('Enter the restraint condition for each joint in the X-direction: ');
ysup = input('Enter the restraint condition for each joint in the Y-direction: ');
msup = [jn' xsup' ysup'];

%% Material Property
disp('....................................................................')
em = input('Enter the modulus of elasticity for all materials: ')';
id1 = [1:1:length(em)]';

%% Cross-Sectional Property Data
disp('....................................................................')
disp(' ')
cp = input('Enter the cross sectional area for the members: ')';
id2 = [1:1:length(cp)]';

%% Member Data
disp('....................................................................')
modulusTable = table(id1, em,'VariableNames',{'ID','Modulus'})
crossecTable = table(id2,cp,'VariableNames',{'ID','Area'})
disp('Using the ID from the modulus and cross section tables, enter ')
disp('the values corresponding to each member in the following format.')
disp('[START JOINT # , END JOINT #, MODULUS ID, CROSS SECTION ID]')
disp('....................................................................')


%% Member Property Matrix
nm = input('How many members are contained in the truss? ');
disp('Enter the member information as described above: ')
mprp = zeros(nm,4);
for i = 1:nm
    mprp(i,:) = input('Enter the information for Member');
end

% Recreate MPRP Matrix by substituting material values.

% Modulus Conversion Loop
for i = 1:length(em)
    idxm = find(mprp(:,3) == i);
    mprp(idxm,3) = em(i);
end

% Cross Section Conversion Loop
for i = 1:length(cp)
    idxc = find(mprp(:,4) == i);
    mprp(idxc,4) = cp(i)*10;    %*10 to remove the possibility that the index = area
end
mprp(:,4) = mprp(:,4)./10;      %Correct for multiplication by 10.

disp('....................................................................')

%% Joint Load Data
jp = input('Enter the joints where loads are applied: ')';
pjx = input('Enter the loads that are applied in the X-direction: ')';
pjy = input('Enter the loads that are applied in the Y-direction: ')';

pj = [pjx pjy];
