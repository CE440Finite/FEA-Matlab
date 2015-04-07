
for n=1:length(mprp)
    str = num2str(n);
	startjoint = mtab(n,1);
	sjoint = [coord(startjoint,:)]
	endjoint = mtab(n,2);
	ejoint = [coord(endjoint,:)];
    
    crds = vertcat(sjoint,ejoint);
    plot(crds(:,1),crds(:,2));
    text(sjoint(1),sjoint(2),str);
    hold on  
end
hold off
