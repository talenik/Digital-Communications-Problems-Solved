clc ;
clear ;
format compact ;

%% Example 10.1 - cyclic shift of a length-4 cvolumn vector

R = [ 0 0 0 1 ; 1 0 0 0 ; 0 1 0 0 ; 0 0 1 0 ]
v = [ 1 2 3 4 ]'

wc = R * v
wr = v' * R'

ok = isequal( wc, wr')

%% Exercise 10.1 

% Note: Implement exercises 10.3 to 10.9 firsts and then scroll down for
% solution.

%% Exercise 10.2 

H = [	0 0 1 1 0 0 0 0 0 0 1 0 ; ... 
		1 0 0 0 1 0 0 0 0 0 0 1 ; ...
		0 1 0 0 0 1 0 0 0 1 0 0 ; ...
		0 1 0 0 0 0 1 0 0 0 0 1 ; ...
		0 0 1 0 0 0 0 1 0 1 0 0 ; ...
		1 0 0 0 0 0 0 0 1 0 1 0 ]

z = 3

ib = 2 
jb = 3
P_2_3 = H( ( ib - 1 ) * z + 1 : ib * z, ( jb - 1 ) * z + 1 : jb * z )

ib = 2 
jb = 4
P_ib_jb = H( ( ib - 1 ) * z + 1 : ib * z, ( jb - 1 ) * z + 1 : jb * z )

%% Exercise 10.3 - cyclic shift matrix - right shift

N	= 4 ;
I	= eye( N ) ;
R2	= [ I( :, [ 3 4 ] ) I( :, [ 1 2 ] ) ] 
R3	= [ I( :, [ 4 ] ) I( :, [ 1 : 3 ] ) ] 
v	= [ 1 2 3 4 ]'

v2	= R2 * v
v3	= R3 * v 

R4 = I
v4 = R4 * v

%% Exercise 10.4 - cyclic shift matrix powers - right shift

N	= 5 ;
I	= eye( N ) 
R	= [ I( :, 2 : N ) I( :, 1 ) ]
v	= [ 1 : N ]'

R2 = R * R
R3 = R2 * R
R4 = R3 * R

v2	= R2 * v
v3	= R3 * v
v4	= R4 * v 

R2 = R * R
R3 = R * R2
R4 = R * R3

v2	= R2 * v
v3	= R3 * v
v4	= R4 * v 

%% Exercise 10.5 - cyclic shift matrix - left shift

N	= 4 ;
I	= eye( N ) ;
R	= [ I( :, N ) I( :, 1: N - 1 ) ]
v	= [ 1 : N ]'

v1 = R * v 
v2 = v' * R'

%% Exercise 10.6 - universal cyclic shift of a vector or matrix

% Also Example
N	= 5 ;
v	= [ 1 : N ]

%testing row vectors - shift there and back
for s = 1 : N + 2
	vr	= cyclicShiftRight( v, s ) 
	vb	= cyclicShiftRight( vr, -s )   
	if isequal( vb, v )
		disp('OK') ;
	else
		error('shifting to right and left test failed') ;
	end
end

%testing column vectors - shift there and back
v = v'

for s = 1 : N + 2
	vr	= cyclicShiftRight( v, s ) 
	vb	= cyclicShiftRight( vr, -s )   
	if isequal( vb, v )
		disp('OK') ;
	else
		error('shifting to down and up test failed') ;
	end
end

%testing matrices
M = [ 1 : N ; N + 1 : 2 * N ]
for s = 1 : N + 2
	Mr	= cyclicShiftRight( M, s ) 
	Mb	= cyclicShiftRight( Mr, -s )   
	if isequal( Mb, M )
		disp('OK') ;
	else
		error('shifting to right and left matrix test failed') ;
	end
end

%% Exercise 10.7  - Circular (cyclic) shift matrix
clc ;

%testing column vectors - shift there and back
N	= 5 ;
v	= [ 1 : N ]'

for s = 1 : N
	Rr	= cyclicShiftMatrix( N, s ) 
	vr	= Rr * v 
	Rl	= cyclicShiftMatrix( N, -s )   
	vb	= Rl * vr
	if isequal( vb, v )
		disp('OK') ;
	else
		error('shifting vector up and down test failed') ;
	end
end

%testing matrices- shift there and back
N	= 5 ;
v	= [ 1 : N ; N + 1 : 2 * N ]'

for s = 1 : N
	Rr	= cyclicShiftMatrix( N, s ) 
	vr	= Rr * v 
	Rl	= cyclicShiftMatrix( N, -s )   
	vb	= Rl * vr
	if isequal( vb, v )
		disp('OK') ;
	else
		error('shifting matrix up and down test failed') ;
	end
end

%clc ;
%testing row vectors - shift there and back
N	= 5 ;
v	= [ 1 : N ]

for s = 0 : N + 2
	shift = s
	Rr	= cyclicShiftMatrix( N, s ) 
	vr	= v * Rr'  
	Rl	= cyclicShiftMatrix( N, -s )   
	vb	= vr * Rl' 
	if isequal( vb, v )
		disp('OK') ;
	else
		error('shifting vector up and down test failed') ;
	end
end

%clc ;
%testing matrix from the right - shift there and back
N	= 5 ;
v	= [ 1 : N ; N + 1 : 2 * N ]

for s = 0 : N + 2
	shift = s
	Rr	= cyclicShiftMatrix( N, s ) 
	vr	= v * Rr'  
	Rl	= cyclicShiftMatrix( N, -s )   
	vb	= vr * Rl' 
	if isequal( vb, v )
		disp('OK') ;
	else
		error('shifting vector up and down test failed') ;
	end
end

%% Exercise 10.8 - find cyclic shift value

U = [ 1 : 8 ]

for s = 0 : 10
	V = cyclicShiftRight( U, s )
	r = findCyclicShift( U, V )
end

V( 1 ) = 10 ;
r = findCyclicShift( U, V )

%% Exercise 10.9 Model matrix expansion for WiFi-6

R = [ 1/2 2/3 3/4 5/6 ] 
N = [ 1944 1296 648 ]

for r = R
	for n = N
		code = loadWIFI6_LDPC( r, n )

		Hbm = code.Hbm ;
		z	= code.z ;

		Hs = sparse( LDPCExpandH( Hbm, z ) )	;
		whos Hs
	end
end

displayBinaryMatrix( Hs, z )


%% Exercise 10.1 revisited

Hbm = [	1  0 -1  2  1  0 -1 -1 ; ...
		2 -1  0  1  0  0  0 -1 ; ...
		0  1  0  2  1 -1 -1  0 ]

z = 3

H = LDPCExpandH( Hbm, z )



































