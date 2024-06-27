function P = submatrix( M, z, ib, jb )
%submatrix( M, z, ib, jb ) returns an element of a block-matrix at index ( ib, jb )
%	the element is a square submatrix of size z x z of block-matrix M
	[ r, c ] = size( M ) ;
	if mod( r, z ) ~= 0 || mod( c, z ) ~= 0
		error('size of M not divisible by z') ;
	end

	P = M( ( ib - 1 ) * z + 1 : ib * z, ( jb - 1 ) * z + 1 : jb * z ) ;
end