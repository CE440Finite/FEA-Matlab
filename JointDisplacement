Count1 = 1;
while Count1 <= NDOF
	Z1 = S(Count1,Count1);
	Count2 = 1;
	while Count2 <= NDOF
		S(Count1,Count2) = S(Count1,Count2)/Z1;
		Count2 =Count2+1
	end
	P(Count1) = P(Count1)/Z1;
	Count3 = 1;
	while Count3 <=NDOF
		if Count3 == Count1
			Count3 = Count3 + 1;
		else
			Z = S(Count3, Count 1);
			Count4 = 1;
			while Count4<= NDOF
				S(Count3,Count4) = S(Count3,Count4) - S(Count1,Count4)*Z;
				Count4 = Count4 +=1;
			end
			P(Count3) = P(Count3) - P(Count1)*Z;
			Count3 = Count3 + 1;
		end
	end
	Count1 = Count1 = Count 1+1;
end
//Print P
