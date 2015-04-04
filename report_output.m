% This script will write the program input and output to a text file called
% 'report.txt'.

fid = fopen('report.txt','w'); %create new file to write data to.


fprintf(fid,'Project Title: %s\n','Problem 1');
fprintf(fid,'User Name: %s\n',getenv('USER'));
fprintf(fid,'Operating System: %s\n',getenv('ARCH'));
fprintf(fid,'Date & Time: %s\n\n',datestr(now));
fprintf(fid,'\n\n');

fprintf(fid,'** Program Input **\n\n');
fprintf(fid,'Number of Joints: %u\n',nj);
fprintf(fid,'Number of Members: %u\n',length(mprp));
fprintf(fid,'Number of Defined Modulus of Elasticity : %u\n',length(em));
fprintf(fid,'Number of Defined Cross Sections: %u\n\n',length(cp));

fprintf(fid,'Joint      X-Coordinate       Y-Coordinate\n');
fprintf(fid,'_____      ____________       ____________\n\n');
for n = 1:length(coord)
    fprintf(fid,'%u          %.3e          %.3e\n',n,coord(n,1),coord(n,2));
end
fprintf(fid,'\n');

fprintf(fid,'Joint      X-Restraint       Y-Restraint\n');
fprintf(fid,'_____      ___________       ___________\n');
for n = 1:length(msup)
    fprintf(fid,'%u               %u                %u\n',msup(n,1),msup(n,2),msup(n,3));
end  
fprintf(fid,'\n');

fprintf(fid,'1 = restrained, 0 = not restrained\n');




fclose(fid);
