function SignalSpaceSymbols = modulateQPSK( LogicalSymbols, A )

[ r, c ] = size( LogicalSymbols ) ;

assert( mod( r, 2 ) == 0 ) ;

nc = r * c / 2 ;
LS = reshape( LogicalSymbols, 2, nc ) ;

%actual constellation points in IQ plane
MAP = [ -1 j -j 1 ] ;

SS = zeros( 1, nc ) ;
for i = 1 : nc
	index	= bits2Index( LS( :, i ) ) ;
	SS( i ) = MAP( index + 1 ) ;
end

SignalSpaceSymbols = A * reshape( SS, r / 2, c ) ;