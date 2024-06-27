%Linear Block Codes - Hamming codes
% Prescribed conventions for matrices orientation:
%	G is a GF(2) valued matrix of size k x n
%	H is a GF(2) valued matrix of size (n - k) x n
%	all matrices contain GF(2) values,
% but are stored as Matlab floating point double matrices.

% We do the lab exercises here, the chapter examples are in a separate
% file: ch3_examples.m, implement these exercises before testing Examples.

format compact ;
path( '../lab1', path ) ;
%you need to implement the deToBi() function first

%% Exercise 3.1.1: Hamming code parameters

% set this to 3 or 4 ONLY,
% larger values will take too much memory (2^k vectors to process):
r = 3
[ n k ]		= HammingCodeNK( r )

%% Exercise 3.1.2: Hamming code G and H matrices

[ H G ]		= HammingCodeHG( r )

%% Exercise 3.1.3: Matrix orthogonality test

ort			= areOrthogonal( G, H )

% This should call a function implemented in Lab 1,
% make sure it's in path.

Datawords	= generateAllBinaryWords( k )

%% Exercise 3.1.4: find all codewords

Codewords	= findAllCodewords( G )

%% Exercise 3.1.5: compute all syndromes

Syndromes	= computeSyndromes( H, Codewords ) ;
% This is a sanity check: all codewords should result in zero syndromes.
if ~isequal( Syndromes, zeros( size( Syndromes ) ) )
	error( 'Codewords not orthogonal with H matrix' ) ;
end

%% Exercise 3.1.6: find and plot code spectrum

% Also find the theoretical limits for number tdet of detectable an tcor of correctable errors.
[ Spectrum, dmin ] = findCodeSpectrum( G )

tdet = dmin - 1
tcor = floor( ( dmin - 1 ) / 2 )

%uncomment this for a GUI stem plot
stem( [ 0 : 1 : size( Spectrum, 2 ) ], [ 1 Spectrum ] )
xlabel('wH(c)','HorizontalAlignment','right') ;
ylabel('#c','VerticalAlignment','top') ;

set( gcf,'color','w') ;

%% Exercise 3.1.7:
%	Write a function that finds all GF(2) vectors of length n,
%	with exactly k nonzero entries. Store all these vectors row-wise in single output matrix.
Combinations = findGF2Combinations( n, tdet )

%% Exercise 3.1.8: find all possible error vectors
ErrorVectors = findAllErrorVectors( n, tcor )

%% Exercise 3.1.9: generate syndrome table structure
SyndromeTable = findSyndromeTable( H, dmin )

%% Exercise 3.1.10: syndrome method decoding

CodewordsEstimate = decodeSyndromeMethod( H, SyndromeTable, Codewords ) ;

codeWordsDecodedOK = isequal( Codewords, CodewordsEstimate )

%% Exercise 3.1.11: test syndrome method decoding with predictable errors

EV2 = repmat( ErrorVectors, 2 , 1 ) ;
ReceivedWordsWithErrors  = mod( Codewords + EV2 , 2 )

CE2 = decodeSyndromeMethod( H, SyndromeTable, ReceivedWordsWithErrors ) ;
receivedWordsDecodedOK = isequal( Codewords, CE2 )

%% Exercise 3.1.12: test received words distances

R = ReceivedWordsWithErrors( 2, : )

dHam( R, Codewords )	




