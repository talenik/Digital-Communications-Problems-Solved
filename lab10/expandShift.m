function P = expandShift( s, z )

	if s == -1
		P = zeros( z ) ;
	elseif s == 0
		P = eye( z ) ;
	elseif s > 0 
		P = cyclicShiftMatrix( z, s ) ;
	else
		error('shift error') ;
	end