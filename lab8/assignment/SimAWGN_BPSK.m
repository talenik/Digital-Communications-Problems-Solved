% Exercise 8.1.3: Waterfall curve simulation for AWGN channel.

clear ;
format compact ;

path( path, '../../lab1') ;
path( path, '../../lab5') ;

%settings-------------------------------------------
% simulation parameters
EbNo		= [ 0 : 1 : 9 ] ;	%values in dB

% one block trasnmission at a time
N 			= 100 ;
words		= 1 ;

%many block transmission must be simulated 
bMul 		= 100 ;
Nblocks		= bMul * [1:1:size(EbNo,2)] ;
%end o settings-------------------------------------
ERR 		= zeros( 1, size( EbNo, 2 ) ) ;

%BPSK transmitter -------------------------
startt = tic ;

Codewords 	= binarySource( N, words ) ; 	

%% Exercise 8.1.3a: Real-valued BPSK modulator
% Implement a function that performs all digital BPSK modulation. The
% output should be signal space complex (or real if possible) symbols.
% Use the following mapping: 0 -> -1, 1 -> +1.
TxBlock		= modulateBPSK( Codewords ) ;

for x=1:1:size( EbNo,2 )
	%% Exercise 8.1.3b: channel noise power in various forms
	% Modify this simulation to use different representations of channel
	% noise power.
	ebno	= EbNo( x ) 
	snr     = 
	varCh	= 
	sigma	= 
	
	for t=1:1:Nblocks(x)
		Noise	= sigma * randn(size(TxBlock)) ;
		
		%BPSK receiver-------------------------
		RxBlock	= TxBlock + Noise ;
		%% Exercise 8.1.3c: Implement a real-values BPSK detector function
		CodewordsEstimate = detectBPSK( RxBlock ) ;
		
		%error statistics calculation
		ERR( x ) = ERR( x ) + biterr( CodewordsEstimate, Codewords ) ;
	end
end

nCodewords	= Nblocks * words ;
bits		= nCodewords * N ;
BER			= ERR ./bits ;

%% Exercise 8.1.3d: Theoretical and simulational results comparison
%	Modify this simulation to include a theoretical Pb value for the given 
%	Eb/No vector to be plotted together with the simulation results.

ebno		= 10 .^ ( EbNo ./ 10 ) ;
%using complementary error function
Pb			=	

% plot waterfall function
% semilogy( EbNo, [ BER ; Pb2 ] ) ;
% grid on ;

myplot( EbNo, [ BER ; Pb ], 'Eb/N0 [dB]', 'BER' ,'semi' ) ;



