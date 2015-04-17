% This script will write the program input and output to a text file called
% 'report_projectName.txt' 

% -- INPUT
fname = strcat('report_',name,'.txt');
fid = fopen(fname,'w'); %create new file to write data to.
product = ver('matlab');
fprintf(fid,'Project Title: %s\n',name);
t = isunix;
if t == 1
    fprintf(fid,'User Name: %s\n',getenv('USER'));
    fprintf(fid,'Operating System: %s\n',getenv('ARCH'));
else
    [~,username] = dos('ECHO %USERNAME%');
    fprintf(fid,'User Name: %s\n',username);
    fprintf(fid,'Operating System: %s\n',system_dependent('getos'));
end
fprintf(fid,'Matlab Version: %s\t%s\n',product.Version,product.Release);
fprintf(fid,'Date & Time: %s\n\n',datestr(now));
fprintf(fid,'\n\n');
fprintf(fid,'-------------\n');
fprintf(fid,'Program Input\n');
fprintf(fid,'-------------\n\n');

fprintf(fid,'Number of Joints: %u\n',nj);
fprintf(fid,'Number of Members: %u\n',length(mprp));
fprintf(fid,'Number of Defined Modulus of Elasticity : %u\n',length(em));
fprintf(fid,'Number of Defined Cross Sections: %u\n\n',length(cp));

fprintf(fid,'Joint Coordinates\n');
fprintf(fid,'=================\n');

fprintf(fid,'Joint      X-Coordinate       Y-Coordinate\n');
fprintf(fid,'_____      ____________       ____________\n\n');
for n = 1:length(coord)
    fprintf(fid,'%u          %.3e          %.3e\n',n,coord(n,1),coord(n,2));
end
fprintf(fid,'\n');

fprintf(fid,'Joint Restraint\n');
fprintf(fid,'=================\n');

fprintf(fid,'Joint      X-Restraint       Y-Restraint\n');
fprintf(fid,'_____      ___________       ___________\n');
for n = 1:length(msup)
    fprintf(fid,'%u               %u                %u\n',msup(n,1),msup(n,2),msup(n,3));
end  
fprintf(fid,'\n');

fprintf(fid,'1 = restrained, 0 = not restrained\n\n');

fprintf(fid,'Defined Modulus of Elasticity\n');
fprintf(fid,'=============================\n\n');
fprintf(fid,'No.      Modulus of Elasticity\n');
fprintf(fid,'__       _____________________\n\n');
for n = 1:length(em)
    fprintf(fid,'%u             %.3e\n',n,em(n));
end
fprintf(fid,'\n');
fprintf(fid,'Defined Cross Sectional Area\n');
fprintf(fid,'============================\n\n');
fprintf(fid,'No.      Cross Sectional Area\n');
fprintf(fid,'__       ____________________\n\n');
for n = 1:length(cp)
    fprintf(fid,'%u             %.3e\n',n,cp(n));
end
fprintf(fid,'\n');

fprintf(fid,'Member Data\n');
fprintf(fid,'===========\n\n');
fprintf(fid,'Member No.     Start Joint No.     End Joint No.   Cross Section   Modulus of Elasticity\n');
fprintf(fid,'_________      _______________     ____________    _____________   _____________________\n\n');
for n = 1:length(mprp)
    fprintf(fid,'%3u                    %u                 %u          %.3e           %.3e\n',... 
        n,mtab(n,1),mtab(n,2),mtab(n,4),mtab(n,3));
end
fprintf(fid,'\n');
fprintf(fid,'Joint Loads\n');
fprintf(fid,'===========\n\n');
fprintf(fid,'Joint No.      X-Load         Y-Load\n');
fprintf(fid,'________       ________      ________\n\n');

for n = 1:length(jp)
    fprintf(fid,'%3u            %.2e      %.2e\n',jp(n),pj(n,1),pj(n,2));
end
fprintf(fid,'\n\n');

% -- OUTPUT
stressC = cell(nm,1);
for i = 1:nm
    if sign(aforce(i))== -1
        stressC{i} = {'Tension'};
    else
        stressC{i} = {'Compression'};
    end
end
fprintf(fid,'-------------\n');
fprintf(fid,'Program Output\n');
fprintf(fid,'-------------\n\n');

fprintf(fid,'Member Axial Force\n');
fprintf(fid,'==================\n\n');

fprintf(fid,'Member No.      Axial Force        Compression/Tension\n');
fprintf(fid,'_________       ___________        ___________________\n\n');
for i = 1:nm
    fprintf(fid,'%4u              %5.2e         %s\n', i, aforce(i),stressC{i}{1});
end
fprintf(fid,'\n\n');

fclose(fid);

%% STRUCTURE PLOT
% INITIAL SHAPE
for n=1:length(mprp)
    str = num2str(n);
    startjoint = mtab(n,1);
    sjoint = coord(startjoint,:);
    endjoint = mtab(n,2);
    ejoint = coord(endjoint,:);
    
    crds = vertcat(sjoint,ejoint);
    plot(crds(:,1),crds(:,2),'k-');
    hold on
end
j = 1;
for i = jp'
    quiver(coord(i,1),coord(i,2),pj(j,1),pj(j,2),0.3, 'Color','red','LineWidth', ...
        2, 'MaxHeadSize',.7)
    hold on
    j = j + 1;
end