function [ A, B, T, C, D, E ] = partitionH( H, z )

[ m, n ] = size( H ) ;
k		= n - m ;

%partition  the matrix according to Annex G.6 Method 2
%first select two block-rows
R1		= H( 1:m - z, : ) ;
R2		= H( ( m - z + 1 ):end, : ) ;

%partition  the matrix according to Annex G.6 Method 2
A		= R1( :, 1 : k ) ;
B		= R1( :, k + 1 : k + z ) ;
T	 	= R1( :, k + z + 1 : end ) ;

C		= R2( :, 1 : k ) ;
D		= R2( :, k + 1 : k + z ) ;
E		= R2( :, k + z + 1 : end ) ;

assert( size( B, 1 ) == m - z )
assert( size( B, 2 ) == z )
assert( size( D, 1 ) == z )
assert( size( D, 2 ) == z )
assert( size( E, 1 ) == z )
assert( size( E, 2 ) == m - z )

%test T submatrix special structure

T1 = eye( m - z ) ;
F1 = zeros( z, m - z ) ;
T2 = [ T1 ; F1 ] + [ F1 ; T1 ] ;
T2 = T2( 1 : m - z , : ) ;
if ~isequal( T2, T )
	error( 'T submatrix doesnt have required structure') ;
end