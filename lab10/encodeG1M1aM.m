function v = encodeG1M1aM( Hbm, u, z )
% Exercise 10.16
%	LDPC direct encoding algorithm as defined in IEEE Std. 802.16-2017, 
%	Annex G: G.1 Method 1a
%	formulation of the algorithm using matrix multiplications

%Note WiMAX-only: assuming Hbm is already scaled 

[ mb, nb ] = size( Hbm ) ;
kb = nb - mb ;

U = reshape( u, z, kb ) ;
V = zeros( z, mb ) ;

%one column for each block row of the Hbm
Ki = zeros( z, mb ) ;

for i = 1 : mb
	for j = 1 : kb
		Pij = expandShift( Hbm( i, j ), z ) ;
		Ki( :, i )  = Ki( :, i ) + Pij * U( :, j ) ;
	end
end
Ki = mod( Ki, 2 ) ;


%find nonzero permutation x:
ind = find( Hbm( :, kb + 1 ) > -1 ) ;
assert( size( ind, 1 ) == 3 )  ;
px = Hbm( ind( 2 ), kb + 1 ) ;


%inversion allready:
Pxi = cyclicShiftMatrix( z, z - px ) ;

%first parity subblock
V( :, 1 ) =  mod( Pxi * sum( Ki, 2 ), 2 ) ;

%second parity subblock
V( :, 2 ) = mod( Ki( :, 1 ) + expandShift( Hbm( 1, kb + 1 ), z ) * V( :, 1 ), 2 ) ;

%other subblocks
for i = 2 : mb - 1
	T = expandShift( Hbm( i, kb + 1 ), z ) * V( : , 1 ) ;
	V( :, i + 1 ) = V( :, i ) + Ki( :, i ) + T ;
end
V = mod( V, 2 );
v = [ u ; reshape( V, z * mb, 1 ) ] ;

 
