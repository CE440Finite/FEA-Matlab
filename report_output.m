% This script will write the program input and output to a text file called
% 'report.txt'.

fid = fopen('report.txt','w'); %create new file to write data to.

product = ver('matlab');
fprintf(fid,'Project Title: %s\n',name);
fprintf(fid,'User Name: %s\n',getenv('USER'));
fprintf(fid,'Operating System: %s\n',getenv('ARCH'));
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
        n,mprp(n,1),mprp(n,2),mprp(n,4),mprp(n,3));
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






fclose(fid);
