function R = getBlockRow( M, z, ib )
% Exercise 10.14: special GF(2) matrix inversion
% extract a single block-row of size z actual rows from a matrix

	[ r, c ] = size( M ) ;
	if mod( r, z ) ~= 0 || mod( c, z ) ~= 0
		error('size of M not divisible by z') ;
	end

	R = M( ( ib - 1 ) * z + 1 : ib * z, : ) ;

