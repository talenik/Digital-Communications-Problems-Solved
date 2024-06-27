function Data = generateAllBinaryWords( k )
% GenerateAllInfoWords( k ) 
%	generate matrix of all GF(2) vectors of width k bits 
%	in natural order - starting with all zeros vector, 
%	ending with all ones vector.
%	Each column of the resulting matrix is one binary vector 
%	assuming MSB is the first bit in word.

Dint = [ 0 : ( 2 ^ k ) - 1 ]' ;

Data = deToBi( Dint, k ) ;

