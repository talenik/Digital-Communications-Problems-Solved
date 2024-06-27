function CodewordEstimates = blockDecodeSyndromeMethod( H, SyndromeTable, Received )
%Wrapper function, that allows for using
% the existing row-vector oriented DecodeSyndromeMethod function in 
% a column block-oriented simulation.

%DecodeSyndromeMethod is buggy - returns -1 sometimes - so we fix it:
CodewordEstimates = abs( decodeSyndromeMethod( H, SyndromeTable, Received')' ) ;

%or per partes:

[ n blockSize ]		= size( Received ) ;
CodewordEstimates2	= zeros( n, blockSize ) ;

for c = 1:1:blockSize
	CodewordEstimates2( :, c ) = (decodeSyndromeMethod( H, SyndromeTable, Received( :, c )' ))' ;
end

CodewordEstimates2 =  mod( CodewordEstimates2, 2 ) ;

if ~isequal( CodewordEstimates, CodewordEstimates2 )
	error("decoding error")
end