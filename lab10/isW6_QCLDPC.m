function [ ok, Hbm ] = isW6_QCLDPC( H, z )

	[ M, N ] = size( H ) ;
	
	if mod( M, z ) ~= 0 || mod( N, z ) ~= 0
		error('matrix size not divisible by z') ;
	end
	
	Mb = M / z ;
	Nb = N / z ; 
	Hbm = zeros( Mb, Nb ) ;
	
	I = eye( z ) ;
	O = zeros( z ) ;
	
	ok = true ;

	for r = 1 : Mb
		for c = 1 : Nb
			P = submatrix( H, z, r, c ) ;
			if isequal( P, I )
				v = 0 ;
			elseif isequal( P, O )
				v = -1 ;
			elseif isCirculant( P )
				%calculate the cyclic shift from identity matrix
				idx = find( P( 1, : ) ) ;
				s = z - idx + 1 ;
				if length( idx ) ~= 1
					ok = false ;
					v = NaN ;
				else
					v = s ;
				end
			else
				ok = false ;
				v = NaN ;
			end
	
			Hbm( r, c ) = v ;
		end
	end

end

