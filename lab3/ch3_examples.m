% These are the exmaples and exercises 
% present directly in the chapter text.
% The intention is to calculate them manually on paper
% and use this file for verification.
% The lab exercises are found in a separate file lab3.m
% and should be implemented before/together with this file.

%% Example 1: systematic -vs- nosnystematic forms

% H in non-systematic form
H = [	0 0 0 1 1 1 1 ; ...
		0 1 1 0 0 1 1 ; ...
		1 0 1 0 1 0 1 ]

%permutation:
p = [ 3 5 6 7 4 2 1 ]

% H in systematic form using MATLAB indexing:
Hs = H( :, p )

% create a permutation matrix out of an identity matrix:
I7 = eye( 7 ) ;
I7P = I7( p, : )

% H in systematic form using eq. 15
Hs = mod( I7P * H', 2)'

% parity submatrix of Hs
P = Hs( :, 1 : 4 )

% G matrix in systematic form
G = [ eye( 4 ), P' ]

%orthogonality check:
mod( G * H', 2 )
mod( G * Hs', 2 )

%% Example 2: 

%a) [ 7,4,3 ] code
n = 7
dmin = 3

tcor = floor( ( dmin - 1 ) / 2 )

lines = 0 ;
for t = 0 : tcor
	lines = lines + nchoosek( n, t ) ;
end
STlines = lines

%b) [16,6,7] code
n = 16
dmin = 7

tcor = floor( ( dmin - 1 ) / 2 )

lines = 0 ;
for t = 0 : tcor
	lines = lines + nchoosek( n, t ) ;
end
STlines = lines

%% Exercise 1: Verify matrix rank

G = [ 1 1 0 0 0 1 0 ; ...
      0 1 1 1 0 1 0 ; ...
      0 0 0 1 1 1 0 ; ...
      0 1 0 1 0 0 1 ]

r1  = rank( G )
Gs1 = mod( rref( G ), 2 )

[ H Gs2 ]		= HammingCodeHG( 3 )

%matrices do not have to be equal
isequal( Gs1, Gs2 )

%these two matrices have to be orthogonal
areOrthogonal( Gs2, H )

%these two need not
areOrthogonal( G, H )

[ Spectrum1, dmin1 ] = findCodeSpectrum( Gs1 )
[ Spectrum2, dmin2 ] = findCodeSpectrum( Gs2 )

%% Exercise 2: transmittion over a chanel

r = 3
[ n k ]	= HammingCodeNK( r )
[ H G ]	= HammingCodeHG( r )
[ Spectrum, dmin ] = findCodeSpectrum( G ) ;
SyndromeTable = findSyndromeTable( H, dmin )

Message = [	1 0 0 1 ; ... % H
			0 1 0 1 ; ... % I
			0 0 0 0 ; ... %
			1 0 1 0 ; ... % D
			0 0 1 1 ; ... % A
			1 1 1 1 ; ... % .
			0 0 0 1 ]	  % E

Codewords = mod( Message * G, 2 )
Errors = [	0 0 0 0 0 0 1 ; ... % e1
			0 0 0 0 0 0 0 ; ... % e2
			0 1 0 0 0 0 0 ; ... % e3
			0 1 0 0 0 0 1 ; ... % e4
			0 0 0 0 0 1 0 ; ... % e5
			0 0 1 0 0 0 0 ; ... % e6
			1 0 0 0 0 0 0 ]		% e7

Received = mod( Codewords + Errors, 2 )

CodewordsEstimate = decodeSyndromeMethod( H, SyndromeTable, Received ) ;
MessageEstimate = CodewordsEstimate( :, 1 : k )

%% Example 3: words at given distance

c  = [ 1 0 0 1 1 0 0 ]
c3 = [ 0 0 0 1 1 1 1 ] 
c4 = [ 1 1 1 0 0 0 0 ]  

dHam( c, [ c3 ; c4 ] )

R = [	0 0 0 1 1 0 0 ; ... % r1a
		1 1 0 1 1 0 0 ; ... % r1b
		0 0 0 1 1 0 1 ; ... % r2a
		1 1 1 1 1 0 0 ; ... % r2b
		0 0 0 1 1 1 1 ; ... % r3a
		1 1 1 0 1 0 0 ; ... % r3b 
		0 0 1 1 1 1 1 ; ... % r4a 
		1 1 1 0 0 0 0 ] ... % r4b 

dHam( c, R )

r2b = [ 1 1 1 1 1 0 0 ]
dHam( r2b, [ c ; c4 ] )

c3ap = [ 0 1 1 1 1 0 0 ]
dHam( r2b , [ c ; c4 ; c3ap ] )

