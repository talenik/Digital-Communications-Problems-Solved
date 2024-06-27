function SignalSpaceSymbols = modulate4QAM( LogicalSymbols, A )

if nargin < 2
	Ac = sqrt( 2 ) / 2 ;
else
	Ac = sqrt( A ^ 2 ) / 2 ;
end

[ r, c ] = size( LogicalSymbols ) ;

assert( mod( r, 2 ) == 0 ) ;

nc = r * c / 2 ;
LS = reshape( LogicalSymbols, 2, nc ) ;



MAP = Ac * [ -1-j, 1-j, -1+j, 1+j ] ;

SS = zeros( 1, nc ) ;
for i = 1 : nc
	index	= bits2Index( LS( :, i ) ) ;
	SS( i ) = MAP( index + 1 ) ;
end

SignalSpaceSymbols = reshape( SS, r / 2, c ) ;