function cir =  isCirculant( M )
% Exercise 10.11 test if matrix is circulant
%	assumes each row is a circulant shift of the previous by one position 


	[ r, c ] = size( M ) ;
	if r ~= c 
		cir = false ;
		return ;
	end
	R1R = cyclicShiftRight( M( 1,: ), 1 ) ;
	R1L = cyclicShiftRight( M( 1,: ), -1 ) ;

	if isequal( M( 2, : ), R1R )
		s = 1 ;
	elseif isequal( M( 2, : ), R1L )
		s = -1 ;
	else
		cir = false ;
		return ;
	end
	
	RR = M( 1, : ) ;
	for i = 2 : r
		RR = cyclicShiftRight( RR, s ) ;
		if ~isequal( RR, M( i, : ) ) 
			cir = false ;
			return ;
		end
	end
	cir = true ;
end
