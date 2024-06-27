clc ;
clear ;
format compact ;
path( [ '..' filesep 'lab3' ], path ) ;

%% Exercise 10.17 - find N(m) and M(n) sets

H = [ 1 1 1 0 0 1 1 0 0 1 ; ...
	  1 0 0 0 1 1 0 1 1 0 ; ...
	  0 0 1 1 1 0 1 0 0 1 ; ...
	  0 1 0 0 0 1 0 0 0 1 ; ...
	  0 0 0 1 0 0 0 0 1 0 ]

%do NOT use logical indexing:
% i1 = H( 1, : ) == 1
% i2 = H( 2, : ) == 1
% 
% i1 = find( H( 1, : ) == 1 )
% i2 = find( H( 2, : ) )

[ r, c ] = size( H ) ;

for i = 1 : r
	Ii = find( H( i, : ) )
end
for j = 1 : c
	Ii = find( H( :, j ) )
end


%% Example 10.8 - decoding debugging

H = [ 	1 0 1 0 1 0 1 ; ...
		1 0 1 1 0 1 0 ; ...
		0 1 1 0 0 1 1 ]

n =  size( H, 2 )  
  
%B = randi([0 1], 1, n )  
B = [ 1 0 1 1 0 1 0 ]
T = 1 - 2 * B		% BPSK 0 > +1 , 1 > -1
N = [ -0.8223 -0.0942 0.3362 -0.9047 -0.2883 0.3501 -1.8359 ]

Z = T + N			% NOT LLR LOL

R = decodeLDPC( H, Z, 5, 1 )

s = mod( H * R', 2 )

ok = isequal( s, zeros(size(H,1), 1 ) )





% %% For debugging, try it first with smaller matrices.
% 
% format compact ;
% H	= [	1 0 0 1 0 0 0 1 0 1 ; ...
% 		0 0 1 0 1 0 1 0 1 0 ]
% 
% Zn0 = [ 1 -2 3 -4 5 7 6 -1 -2 -3 ] 
% 
% decode( H, Zn0, 2, 1 ) ;%% A more complex example
% 
% %% another
% 
% A = [ 1 1 1 0 0 1 1 0 0 1 ; ...
% 	  1 0 1 0 1 1 0 1 1 0 ; ...
% 	  0 0 1 1 1 0 1 0 1 1 ; ...
% 	  0 1 0 1 1 1 0 1 0 1 ; ...
% 	  1 1 0 1 0 0 1 1 1 0 ]
% 
% N = size( A, 2 )  
% 
% %B = randi([0 1], 1, N )  
% B = [ 1     0     1     0     0     1     0     0     0     0 ]
% 
% T = 1 - 2 * B		% BPSK
% 
% %N = randn(1, N) 	% AWGN
% N = [ -1.0761    0.2418   -0.1956   -1.0997   -0.7329   -1.9518    1.4898    0.1078   -0.5983   -0.4049 ]
% 
% Z = T + N			% NOT LLR LOL
% 
% R = decode( A, Z, 4, 1 )
% 
% s = mod( A * R', 2 )
% 
% ok = isequal( s, zeros(size(A,1),1 ) )
% 
% 
% %% TODO tidy these up:
% %% first cell
% 
% % [ 12,7 ] code
% H = [ ...
% 	0 0 1 1 0 0 0 0 0 0 1 0 ; ...
% 	1 0 0 0 0 1 0 0 0 0 0 1 ; ...
% 	0 1 0 0 1 0 0 0 0 1 0 0 ; ...
% 	0 1 0 0 0 0 1 0 0 0 0 1 ; ...
% 	0 0 1 0 0 0 0 1 0 1 0 0 ]
% 
% Hr = mod( rref( H ), 2 ) 
% 
% G = [ Hr( :, 6 : end )' eye( 7 ) ]
% 
% mod( G * H', 2 )
% mod( G * Hr', 2 )
% 
% n = size( G, 2 )
% k = size( G, 1 )
% m = n - k 
% 
% i = [ 1 0 0 1 0 1 1 ]
% c = mod( i * G, 2 )
% s = mod( c * H', 2 )
% 
% %% first run a simple-valued decoder
% 
% Zn0 = [ 1 -2 3 -4 5 7 6 -1 -2 -3 2 -1 ]
% 
% decode( H, Zn0, 2, 1 ) ;
% 
% 
% %% second more realistic test
% clc ;
% 
% T = 1 - 2 * c		% BPSK 1 > -1, 0 > + 1
% 
% N = randn( 1, n ) 	% AWGN
% 
% Z = T + N			% NOT LLR LOL
% 
% R = decode( H, Z, 6, 1 )
% 
% ok = mod( H * R', 2 )'