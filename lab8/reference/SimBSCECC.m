%% Exercise 8.1.2: 
%	Simulating simple BSC channel transmission with Hamming code for ECC.
%	The simulation processes several data and code words at the same time,
%	thus simulating a block- or frame- oriented digital transmission.
%	Run this simulation with larger values of k and blockSize and observe
%	the decreasing difference between theoretical and actual BER.
path( path, '../../lab1') ;
path( path, '../../lab3') ;
format compact ;

r			= 3 
[ n, k ]	= HammingCodeNK( r ) 
words		= 1000 

pb			= 0.002 	% if error probability is small, ECC improves BER
%pb			= 0.3 		% if error probability is large, ECC worsens BER

%do some preparations:
[ H, G ]	= HammingCodeHG( r ) 
[ Spectrum, dmin ] = findCodeSpectrum( G ) 
tcor		= floor( ( dmin - 1 ) / 2 ) 
SynTable	= findSyndromeTable( H, dmin ) 

%% Exercise 8.1.2a - Binary source and channel model:
%	Modify the simulation code to include Hamming code encoding procedure 
%	in the transmitter.
UserData	= binarySource( k, words ) ;
CodedData	= mod( G' * UserData, 2 ) ;
TXData		= CodedData ;

% BSC channel
Errors		= binaryErrorMatrix( pb, n, words ) ;

%test error generator quality
PbTest		= size( find( Errors == 1 ) , 1 )/ prod( size( Errors ) ) ;

RXData		= mod( CodedData + Errors, 2 ) ;

%% Exercise 8.1.2b - Receiver with Hamming code syndrome decoding
% Modify the simulation code to include syndrome method decoding procedure
% in the receiver. Also write a wrapper function, that allows for using
% the existing row-vector oriented DecodeSyndromeMethod function in 
% a column block-oriented simulation.
CodewordsEstimate	= blockDecodeSyndromeMethod( H, SynTable, RXData ) ;
EstimatedData		= CodewordsEstimate( 1:k, : ) ;

%% Exercise 8.1.2c - BSC channel
% Modify the simulation code to include error ratio evaluation before with
% and withouth the ECC decoding. What is the fundamental weakness of
% evaluating error ratio this way ?

% Answer - We do not take into account the decrease in symbol energy when
% using ECC and the resulting uncoded BER increase.
nErrorsBefore		= computeHammingDistance( RXData, TXData ) ;
nErrorsAfter		= computeHammingDistance( EstimatedData, UserData ) ; 

bitsBefore	= prod( size( TXData ) ) ;
BERBefore	= nErrorsBefore / bitsBefore ;

bitsAfter	= prod( size( UserData ) ) ;
BERAfter	= nErrorsAfter / bitsAfter ;

%% Exercise 8.1.2d - uncorrectable errors
% Modify the simulation code to include analysis of multiple errors, that
% cannot be decoded by the specified code. Find how many error words cannot
% be corrected.
ueIndices	= sum( Errors ) > tcor ;
ueCount		= sum( ueIndices ) ;
UncorrectableErrorwords = Errors( :, ueIndices ) ;

%% Exercise 8.1.2e - decoded induced errors
% The uncorrectable error words result in inducing further errors in the
% decoding process. Write a function, that finds the number of errors
% induced by the receiver ECC decoder.

ErrorsAfter		= abs( CodewordsEstimate - CodedData ) ;
ErrorsAfter2	= double( xor( CodewordsEstimate, CodedData ) ) ;
assert( all( ErrorsAfter == ErrorsAfter2, 'all' ) )

ieCount			= findInducedErrors( Errors, ErrorsAfter ) ;

%% display results

disp( [ 'Data bits processed: ' num2str( bitsAfter ) ... 
		', BER withouth ECC: ' num2str( BERBefore ) ...
		', BER with ECC: ' num2str( BERAfter ) ] ) ;
	
disp( [	'Uncorrectable error words:' num2str( ueCount ) ...
		', Decoder induced errors in whole block:' num2str( ieCount ) ] ) ;
	
if words == 11
	UserData
	TXData
	Errors
	RXData
	CodewordsEstimate
	EstimatedData
	ueIndices
	ErrorsAfter
	UncorrectableErrorwords
end
	
	