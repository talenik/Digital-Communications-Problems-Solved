function SignalSpaceSymbols = modulateComplexBPSK( LogicalSymbols, Map, A, rot )

if nargin < 4
	rot = 0 ;
end

if ~isequal( Map, [ 0 1 ] )
	LogicalSymbols = ~LogicalSymbols ;
end

SignalSpaceSymbols = A * modulateBPSK( LogicalSymbols ) * exp( j * rot );

