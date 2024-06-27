function index = bits2Index( bits )
% converts a binary vector of two bits to an integer scalar index 
%	
assert( length( bits ) == 2 ) ;

index = 2 * bits( 1 ) + bits( 2 ) ;