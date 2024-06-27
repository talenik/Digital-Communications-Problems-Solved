function MA = addBlockRow( M, R, z, ib )
% Exercise 10.14: special GF(2) matrix inversion
% add a single block-row of size z actual rows to a specific block-index

	[ rm, cm ] = size( M ) ;
	if mod( rm, z ) ~= 0 || mod( cm, z ) ~= 0
		error('size of M not divisible by z') ;
	end

	[ rr, cr ] = size( R ) ;
	if rr ~= z || mod( cr, z ) ~= 0
		error('size of R not divisible by z') ;
	end
	
	if cm ~= cr
		error('incompatible matrix sizes') ;
	end

	MA = M ;

	RM = getBlockRow( M, z, ib ) ;
	RR = RM + R ;

	MA( ( ib - 1 ) * z + 1 : ib * z, : ) = RR ;