dispvecloc = 1;  %place in displacement vector
xtrans = zeros(nj,1); % stores translations for joint
ytrans = zeros(nj,1);  % stores translations for joint
xsupchk = 1; % variable needed for cheking restraint conditions later in loop
ysupchk = 1; % variable needed for cheking restraint conditions later in loop
for n = 1:nj %checks all joints
	exist = 0; % variable for determing is a joint is restrained 
	for k = 1:ns %checks against all restrained joint
		if nj(n) == ns(k) %if a joint is restrained
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
		if ysupchk == 0; if y is free
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
end
% should note that this onlt works if the joints are put in in order i.e restrained joints are put in, in increasing values. 





		
	