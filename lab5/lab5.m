%% Exercise 5.1.1 & 5.1.2: Test BPSK modulation:

format compact ;
%You need to implements these labs first:
path( '../lab1', path ) ;
path( '../lab3', path ) ;

[ ~, Bits ] = HammingCodeHG( 3 )

% Exercise 5.1.1 
BPSKprot = modulateBPSK( Bits )

% Exercise 5.1.2 
BPSKCprot = modulateComplexBPSK( Bits, [ 0 1 ], 1, pi / 4 )
BPSKIprot = modulateComplexBPSK( Bits, [ 0 1 ], 1, pi / 2 )

mag1 = abs( BPSKprot)	;
mag2 = abs( BPSKCprot )	;
mag3 = abs( BPSKIprot )	;

ok = isequal( mag1, mag2 )
ok = isequal( mag1, mag3 )



%% Exercise 5.1.3 & 5.1.4: Test QPSK modulation:

% Exercise 5.1.3a
bits2Index( [ 0 0 ] )	%shoud be 0
bits2Index( [ 0 1 ] )	%shoud be 1
bits2Index( [ 1 0 ] )	%shoud be 2
bits2Index( [ 1 1 ] )	%shoud be 3

B = [	0 0 1 ; ...
		0 1 0 ; ...
		1 1 0 ; ...
		1 0 1 ]


QPSK	= modulateQPSK( B, 1 )	% Exercise 5.1.3
QAM		= modulate4QAM( B )		% Exercise 5.1.4
QAM2	= modulate4QAM( B, 2 )

ok1 = isequal( abs( QPSK ), ones( size( QAM ) ) )
ok2 = isequal( abs( QAM ),  ones( size( QAM ) ) )
ok2 = isequal( abs( QAM2 ), sqrt(2) * ones( size( QAM ) ) )