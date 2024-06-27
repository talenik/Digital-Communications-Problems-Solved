clc ;
clear ; 
format compact ;
path( [ '..' filesep 'lab3' ], path ) ;

% Exercise 10.21 - actual waterfall curve simulation
%settings-------------------------------------------

%code params
N			= 648 ;	 % valid : [ 648, 1296, 1944 ]
R			= 1 / 2  % valid: [ 1/2 2/3 3/4 5/6 ]

%decoder params
nIter		= 8

%simulation params
EbNo		= [ 2 : 0.5 : 10 ]
BlockSize	= 1 ;
bMul		= 10 ;
Nblocks		= bMul * [ 1 : 1 : size( EbNo, 2 ) ]
%end o settings-------------------------------------

nCodewords	= Nblocks * BlockSize ;
bits		= nCodewords * N ;			% number of bits processed

code		= loadWIFI6_LDPC( R, N ) 
K			= code.K ;
H			= LDPCExpandH( code.Hbm, code.z ) ;

ERR			= zeros( 1, size( EbNo, 2 ) ) ;		% absolute number of errors
BER			= zeros( 1, size( EbNo, 2 ) ) ;		% bit error ratio after LDPC decoding

ERRnoDec 	= zeros( 1, size( EbNo, 2 ) ) ;		% bit error ratio before LDPC decoding
BERnoDec 	= zeros( 1, size( EbNo, 2 ) ) ;		% bit error ratio before LDPC decoding

for x = 1:1:size( EbNo, 2 )
	% BPSK transmitter -------------------------
	Dataword	= binarySource( K, BlockSize ) ;
	Codeword	= encodeLDPCmatrix( Dataword, H )' ;	% all zero codewords for now
	TxBlock		= -2 * Codeword + 1 ;					% BPSK modulated 0 -> +1
	
	% calculating AWGN channel parameters
	ebno	= EbNo( x ) ;
	snr     = 10 ^ ( ebno / 10 ) ;
	varCh	= 1 / ( 2 * snr * code.R ) ;	% account for coderate in noise variance
	sigma	= sqrt( varCh ) ;
	
	for t = 1 : 1 : Nblocks( x )
		
		Noise	= sigma * randn( size( TxBlock ) ) ;
		RxBlock	= TxBlock + Noise ;

		% receiver with LLR calculation
		Zn0		= detectorSamplesLLR( RxBlock , varCh ) ;
		
		HD				= decodeLDPC( H, Zn0, nIter ) ;
		ERR( 1, x )		= ERR( 1, x ) + dHam( Codeword, HD ) ;
		
		HD				= hardDecision( Zn0 );	
		ERRnoDec( x )	= ERRnoDec( x ) + dHam( Codeword, HD ) ;
		
	end
	
	disp([ ' Eb/No: ' num2str( EbNo( x ) ) ', Errors: ' num2str( ERR( x ) ) ', Bits: ' num2str( bits( x ) ) ]) ;
end

BER			= ERR ./ bits ;
BERnoDec 	= ERRnoDec ./ bits ; 

figure() ;
semilogy( EbNo, [ BER ; BERnoDec ] ) ;
grid on ;

EbNo
BER
BERnoDec
