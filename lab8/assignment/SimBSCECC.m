%% Exercise 8.1.2: 
%	Simulating simple BSC channel transmission with Hamming code for ECC.
%	The simulation processes several data and code words at the same time,
%	thus simulating a block- or frame- oriented digital transmission.
%	Run this simulation with larger values of k and blockSize (the words variable) 
%	and observe the decreasing difference between theoretical pb and actual BER.
%	In the sections below, gradually uncomment prepared sections one by
%	one. Don't skip sections.

path( path, '../../lab1') ;
path( path, '../../lab3') ;
format compact ;

r			= 3 
[ n, k 		= HammingCodeNK( r ) 
words		= 1000 

pb			= 0.002 	% if error probability is small, ECC improves BER
%pb			= 0.3		% if error probability is large, ECC worsens BER

%do some preparations:
[ H, G ]	= HammingCodeHG( r ) 
[ Spectrum, dmin ] = findCodeSpectrum( G ) 
tcor		= floor( ( dmin - 1 ) / 2 ) 
SynTable	= findSyndromeTable( H, dmin ) 

%%  Exercise 8.1.2a - Binary source and channel model:
%	Modify the simulation code to include Hamming code encoding procedure 
%	in the transmitter.

% UserData	= binarySource( k, words ) ;
% CodedData	= UserData ;
% TXData	= CodedData ;
% 
% % BSC channel
% Errors		= binaryErrorMatrix( pb, n, words ) ;
% 
% %test error generator quality
% PbTest		= size( find( Errors == 1 ) , 1 )/ prod( size( Errors ) ) ;
% 
% %received data entering RX
% RXData		= mod( CodedData + Errors, 2 ) ;

%% Exercise 8.1.2b - Receiver with Hamming code syndrome decoding
% Modify the simulation code to include syndrome method decoding procedure
% in the receiver. Also write a wrapper function blockDecodeSyndromeMethod, 
% that allows for using the existing row-vector oriented DecodeSyndromeMethod 
% function in a column block-oriented simulation.     
% Also fix the conceptual error in the following code snippet:

% CodewordsEstimate	= RXData 
% EstimatedData 	= CodewordsEstimate	

%% Exercise 8.1.2c - BSC channel
% Modify the simulation code to include error ratio evaluation with
% and withouth the ECC decoding. What is the fundamental weakness of
% evaluating error ratio this way ?

% nErrorsBefore	= 
% nErrorsAfter	= 
% 
% bitsBefore	= 
% BERBefore		= 
% 
% bitsAfter		= 
% BERAfter		= 

%% Exercise 8.1.2d - uncorrectable errors
% Modify the simulation code to include analysis of multiple errors, that
% cannot be decoded by the specified code. Find how many error words cannot

% be corrected.
% ueCount		= 
% UncorrectableErrorwords = 

%% Exercise 8.1.2e - decoded induced errors
% The uncorrectable error words result in inducing further errors in the
% decoding process. Modify the simulation and write a function, that 
% finds the number of errors induced by the receiver ECC decoder.

% ErrorsAfter		= 
% ieCount			= findInducedErrors( Errors, ErrorsAfter ) ;
% 
% %% display results
% 
% disp( [ 'Data bits processed: ' num2str( bitsAfter ) ... 
% 		', BER withouth ECC: ' num2str( BERBefore ) ...
% 		', BER with ECC: ' num2str( BERAfter ) ] ) ;
% 	
% disp( [	'Uncorrectable error words:' num2str( ueCount ) ...
% 		', Decoder induced errors in whole block:' num2str( ieCount ) ] ) ;
	
	