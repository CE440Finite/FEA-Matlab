
for n=1:length(mprp)
    str = num2str(n);
    startjoint = mtab(n,1);
    sjoint = [coord(startjoint,:)];
    endjoint = mtab(n,2);
    ejoint = [coord(endjoint,:)];
    
    crds = vertcat(sjoint,ejoint);
    plot(crds(:,1),crds(:,2));
    
    
    member = num2str(n);
    words = 'Member ';
    membernumber = strcat(words, member);
    xdisplace = ejoint(1)-sjoint(1);
    ydisplace = ejoint(2)-sjoint(2);
    xmemtext = sjoint(1) + xdisplace/2;
    ymemtext = sjoint(2) + ydisplace/2;
    text(xmemtext,ymemtext,membernumber)
    joint1 = num2str(startjoint);
    joint2 = num2str(endjoint);
    words2 = 'Joint';
    jointnum1 = strcat(words2, joint1);
    jointnum2 = strcat(words2, joint2);
    text(sjoint(1),sjoint(2),jointnum1)
    text(ejoint(1),ejoint(2),jointnum2)
    hold on
end
hold off
