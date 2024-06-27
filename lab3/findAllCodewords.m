function Codewords = findAllCodewords( G, Datawords )
% Codewords = FindAllCodewords( G, Datawords )
%	finds all codewords for a given LBC generator matrix G.
%	The second argument is optional, and specifies
%	the dataword set in a matrix, with datawords stored row-wise. 
%	If the second parameter is present, FindAllCodewords( G, Datawords )
%	just encodes these using the matrix G. 
%	In both cases the resulting codewords are stored as rows of a single output matrix.

if nargin == 1
	[ k n ] = size(G) ;
	k = min( k, n ) ;
	Datawords = generateAllBinaryWords( k ) ;
end 

Codewords = mod( Datawords * G, 2 ) ;