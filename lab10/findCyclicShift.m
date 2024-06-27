function s = findCyclicShift( U, V )
% Exercise 10.8:
% s = findCyclicShift( U, V ) performs a test whether or not the vector 
%   v is a cyclically shifted vector u. If it is, the return value gives 
%   the number of positions by which we need to shift u to the right in 
%   order to get v. Value -1 to indicate that v is not a cyclic shift of u.	

	lu = length( U ) ;
	lv = length( V ) ;
	
	if lu ~= lv 
		s = -1 ;
		return
	end
	
	for s = 0 : lu - 1 
		if isequal( cyclicShiftRight( U, s ), V )
			return
		end
	end
	s = -1 ;
end

