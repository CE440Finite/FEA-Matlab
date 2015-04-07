hold on 
for n=1:length(mprp)
	x = [coord(mtab(n,1),1),coord(mtab(n,1),2)];
	y = [coord(mtab(n,2),1),coord(mtab(n,2),2)];	
	plot(x,y)
end
hold off 
