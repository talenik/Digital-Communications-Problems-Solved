function [ CodewordsEstimates, ErrorwordEstimate ] = decodeSyndromeMethod( H, SyndromeTable, Received )
% CodewordsEstimate = decodeSyndromeMethod( H, SyndromeTable, Received )
%	decoding of LBC using syndrome method.
%	The second parameter is the set of received binary words to be decoded,
% stored row-wise in a single matrix.
%	The resulting codewords estimates are stored in the same fashion.


CodewordsEstimates = zeros( size( Received ) ) ;
Syndromes	= computeSyndromes( H, Received ) ;

blockSize = size( Received, 1 ) ;
for cwi = 1 : blockSize
	Syndrome = Syndromes( cwi, : ) ;

	[ tf, loc ]	= ismember( SyndromeTable.Syndromes, Syndrome, 'rows') ;
	loc = find( loc ) ; %make scalar index out of vector loc
	if isempty( loc )
		error(' Received word not found in syndrome table.') ;
	end

	ErrorwordEstimate	= SyndromeTable.Words( loc, : ) ;
	ReceivedWord		= Received( cwi, : ) ;
	CodewordEstimate	= mod( ReceivedWord + ErrorwordEstimate, 2 ) ;
	CodewordsEstimates( cwi, : ) = CodewordEstimate ;
end
