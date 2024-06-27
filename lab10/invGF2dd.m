function MI = invGF2dd( M, z )
% Exercise 10.14: special GF(2) matrix inversion
% inverst the special structure - double diagonal binary matrix
	[ r, c ] = size( M ) ;
	if r ~= c
		error('M not square') ;
	end
	if mod( r, z ) ~= 0 || mod( c, z ) ~= 0
		error('size of M not divisible by z') ;
	end

	rb = divmod( r, z ) ;

	T = [ M eye( r ) ] ;
	
	for ib = 2 : rb 
		R = getBlockRow( T, z, ib - 1 ) ;
		T = mod( addBlockRow( T, R, z, ib ), 2 ) ;
	end
	MI = T( :, c + 1 : end ) ;