function syndromeTable = findSyndromeTable( H, dmin ) 
% findSyndromeTable( H, dmin ) 
%	finds syndrome table useful for syndrome decoding.
%	Resulting SyndromeTable is a structure of two matrices:
%		syndromeTable.Words		- contains all possible error words.
%		syndromeTable.Syndromes - contains corresponding syndromes.
%	this table can be used for mapping error words to syndromes and vice versa.

tcor = floor( ( dmin - 1 ) / 2 ) ;
[ m, n ] = size( H ) ;
k = n - m ;

syndromeTable.Words		= findAllErrorVectors( n, tcor ) ;
syndromeTable.Syndromes = computeSyndromes( H, syndromeTable.Words ) ;
