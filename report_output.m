% This script will write the program input and output to a text file called
% 'report.txt'.

fid = fopen('report.txt','w'); %create new file to write data to.


fprintf(fid,'Project Title: %s\n','Problem 1');
fprintf(fid,'User Name: %s\n',getenv('USER'));
fprintf(fid,'Operating System: %s\n',getenv('ARCH'));
fprintf(fid,'Date & Time: %s\n\n',datestr(now));
fprintf(fid,'\n\n');
fprintf(fid,'** Program Input **');




fclose(fid)
