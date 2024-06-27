function dh = dHam( word, Words )
% dham - Hamming distance between a vector and a set of vectors 
%	dHam( word, Words)
%		word - a row vector
%		Words - a matrix of row vectors
%
%	return value: a column vector of Hamming distances

[ w, n ] = size( Words ) ;

wr = repmat( word, w, 1 ) ;
wd = mod( wr + Words, 2 ) ;
dh = sum( wd, 2 ) ;