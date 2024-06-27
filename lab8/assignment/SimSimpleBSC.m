%% Exercise 8.1.1 
%   Simulating simple BSC channel transmission and error rate evaluation.
%	The simulation processes several data words at the same time, thus
%	simulating a block- or frame- oriented digital transmission.
%	Run this simulation with larger values of k and blockSize (the words variable) 
%	and observe the decreasing difference between theoretical and actual BER.

k			= 8 ;
n			= k ;
words		= 10 ;		% after implementation increase to 100, 1000, ...
pb			= 0.3 ;		% theoretical (desired) BER

%% Exercise 8.1.1a  - Uniform binary source:
%	Write a function that generates random binary matrix with uniform
%	distribution - that is ones must occur with the same probability as zeros.

UserData	= binarySource( k, words ) ;
CodedData	= UserData ;
TXData		= CodedData ;

%% Exercise 8.1.1b  - BSC channel model
%	Write a function that generates random binary matrix.
%	The number of ones in this matrix must follow the probability specified
%	by parameter pb.

Errors		= binaryErrorMatrix( pb, n, words ) ;

%test error generator quality
PbTest		= size( find( Errors == 1 ) , 1 ) / prod( size( Errors ) ) ;

RXData		= mod( CodedData + Errors, 2 ) ;

%receiver
EstimatedData = RXData ;

%% Exercise 8.1.1c  - Evaluate BER - Bit Error Ratio
%	Write a function that computes Hamming distance of two matrices.
nErrors		= computeHammingDistance( EstimatedData, UserData ) ;

bits		= prod( size( UserData ) ) ;
BER			= nErrors / bits ;

BERvsPb			= abs( BER - pb ) ;
BERrelativeErr	= BERvsPb / pb ;

disp( [ 'Bits processed: ' num2str( bits ) ', Desired BER: ' num2str( pb ) ] ) ;
disp( [ 'Actual BER: ' num2str( BER ) ', difference: ' num2str( BERvsPb ) ] ) ;
disp( [ 'Relative BER error [%]: ' num2str( BERrelativeErr * 100 )] ) ;

sanityCheck = isequal( PbTest, BER ) ;





