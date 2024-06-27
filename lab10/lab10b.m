clc ;
clear ; 
format compact ;

%% Exercise 10.10: Paired submatrices extraction

code = loadWIFI6_LDPC( 5/6, 648 )

Hbm = code.Hbm 
z	= code.z ;
H	= LDPCExpandH( Hbm, z ) ;
[ M, N ] = size( H )
[ Mb, Nb ] = size( Hbm )
Kb = Nb - Mb ;

EP1 = submatrix( H, z, 1, Kb + 1 ) ;
EP2 = submatrix( H, z, Mb, Kb + 1 ) ;

whos EP1 EP2 H

pairedOk = isequal( EP1, EP2 )

%% Exercise 10.11 - circulant struncture of of H submatrices

%run the previous Exercise first

for r = 1 : Mb
	for c = 1 : Nb
		Prc = submatrix( H, z, r, c ) ;
		circOK = isCirculant( Prc ) ;
		if ~circOK
			error('submatrix not circulant') ;
		end
	end
end

fprintf('isCirculant test OK\n') ;

%% Exercise 10.12 - reconstructing Hbm from H

%run the previous cell first

[ ok, Hbm2 ] = isW6_QCLDPC( H, z )
ok = isequal( Hbm, Hbm2 )
Hbad = H ;
Hbad( 1,1 ) = 1 ;
Hbad( z + 1, z + 1 ) = 1 ;
[ ok, Hbm3 ] = isW6_QCLDPC( Hbad, z )

%% Exercise 10.13 - H matrix partitioning

%Note: run the cell with Exercise 10.10 first
[ A, B, T, C, D, E ] = partitionH( H, z ) ;
whos H A B T C D E

figure( 1 ) ;
displayBinaryMatrix( H, z ) ;
figure( 2 ) ;
subplot( 2, 3, 1 ) ;
displayBinaryMatrix( A, z ) ;
subplot( 2, 3, 2 ) ;
displayBinaryMatrix( B, z ) ;
subplot( 2, 3, 3 ) ;
displayBinaryMatrix( T, z ) ;
subplot( 2, 3, 4 ) ;
displayBinaryMatrix( C, z ) ;
subplot( 2, 3, 5 ) ;
displayBinaryMatrix( D, z ) ;
subplot( 2, 3, 6 ) ;
displayBinaryMatrix( E, z ) ;

%% Exercise 10.14 - Special double-diagonal block matrix GF(2) inversion

R = [ 1/2 2/3 3/4 5/6 ] 
N = [ 1944 1296 648 ]

for r = R
	for n = N
		code = loadWIFI6_LDPC( r, n )
		Hbm = code.Hbm ;
		z	= code.z ;

		H	=  LDPCExpandH( Hbm, z ) ;
		[ A, B, T, C, D, E ] = partitionH( H, z ) ;
		Ti = invGF2dd( T, z ) ;
		%displayBinaryMatrix( Ti, z ) ;
		ok = isequal( mod( T * Ti, 2 ), eye( size( T, 1 ) ) ) ;
		ok2 = isequal( Ti, mod( inv( T ), 2 ) ) ;
		if ~ok || ~ok2
			error('GF2 matrix inversion failed') ;
		else
			fprintf("GF(2) inversion OK for R:%d,n:%d\n", r, n ) ;
		end
		
	end
end

%% Exercise 10.15a - LDPC direct encoding - matrix style

% First try a small matrix from Exercise 10.1:
clear ;

z	= 3

Hbm = [  1  0 -1  2  1  0 -1 -1 ; ...
		 2 -1  0  1  0  0  0 -1 ; ...
		-1  2  1  0 -1 -1  0  0 ; ...
		 0  1  0  2  1 -1 -1  0 ] 

H	= LDPCExpandH( Hbm, z )

[ m, n ] = size( H ) 
k = n - m 

i = randi( [0 1], k, 1 )  ;
[ A, B, T, C, D, E ] = partitionH( H, z ) 
c = encodeLDPCmatrix( i, H, z ) ;

ok = isequal( mod( H * c, 2 ), zeros( m , 1 ) ) 
whos
it = i'
ct = c'

%% Exercise 10.15b - actual WiFi-6 QC-LDPC codes

% Try actual Wi-Fi 6 matrices:
R = [ 1/2 2/3 3/4 5/6 ] 
N = [ 1944 1296 648 ]

for r = R
	for n = N
		code = loadWIFI6_LDPC( r, n ) ;
		Hbm = code.Hbm ;
		z	= code.z ;
		H	=  LDPCExpandH( Hbm, z ) ;
		[ m, n ] = size( H ) ;
		k = n - m ;

		i = randi( [0 1], k, 1 ) ;
		c = encodeLDPCmatrix( i, H, z ) ;

		ok = isequal( mod( H * c, 2 ), zeros( m , 1 ) ) ;
		if ok
			fprintf("QC_LDPC direc encoding OK for R:%d,n:%d\n", r, n ) ;
		else
			error('Encoding failed') ;
		end
	end
end

%% Exercise 10.16 - low level implementation of direct Wi-Fi 6 QC-LDPC encoder 

R = [ 1/2 2/3 3/4 5/6 ] 
N = [ 1944 1296 648 ]

for r = R
	for n = N
		code = loadWIFI6_LDPC( r, n ) ;
		Hbm = code.Hbm ;
		k	= code.K ;
		z	= code.z ;
		H	=  LDPCExpandH( Hbm, z ) ;

		i	= randi( [0 1], k, 1 ) ;
		
		c1	= encodeLDPCmatrix( i, H, z ) ;
		c2	= encodeG1M1aM( Hbm, i, z ) ;
		c3	= encodeG1M1aR( Hbm, i, z ) ;

		ok1 = isequal( c2, c3 ) 
		ok2 = isequal( c1, c2 ) 
		if ~ok1 || ~ok2
			error('encoders results differ - FAIL') ;
		else
			fprintf("QC_LDPC direct encoding OK for R:%d,n:%d\n", r, n ) ;
		end

		if nnz(mod( H * c1, 2 ) ) > 0 
			error('orthogonality test FAIL') ;
		end
	end
end



