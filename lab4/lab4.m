format compact ;
clear ;

%% Exercise 4.1.1: Matrix comparison with tolerance
n = 8 ;

A = magic( n ) 
I = int32( A ) 
N = 1e-10 * randn( n ) ;
ts = sum( sum( abs( N ) ) ) 
B = A + N 
T = 1e-8 

e1 = equals( A, I )	
e2 = equals( A, B )
e3 = equals( A, B, T )

[ e4, h4, d4 ] = equals( A, B )
[ e5, h5, d5 ] = equals( A, B, T )

%practical usage: T = 1e-8 
T = 1e-8 
[ e, ~, d ] = equals( A, B, T ) ;
if e
	disp( [ 'Close enough. D: ' num2str( d ) ] ) ;
else
	disp( [ 'Out of tolerance. D: ' num2str( d ) ] ) ;
end

%practical usage: T = 1e-10 
T = 1e-10 
[ e, ~, d ] = equals( A, B, T ) ;
if e
	disp( [ 'Close enough. D: ' num2str( d ) ] ) ;
else
	disp( [ 'Out of tolerance. D: ' num2str( d ) ] ) ;
end

%% Exercise 4.1.2: Unitary Fourier transform matrix
N	= 8 ;
tol = 1e-8 ;

W	= ftm( N )

x	= rand( N, 1 ) + i * rand( N ,1 );
f	= ( 1 / sqrt( N ) ) ;
X1	= f * fft( x ) ;
X2	= W * x ;

e1 = equals( X1, X2 )					%false because floating point imprecise
[ et1, ~, d1 ] = equals( X1, X2, tol )	%true because close enough

%check for symmetries:
[ e, ~, d ] = equals( W, W', tol )		%DFT matrix is NOT Hermitian
[ e, ~, d ] = equals( W, W.', tol )		%DFT matrix is symmetric

%let's try a transposed formulation
X3	= x' * W' ;		% a row-vector		%carefull: Hermitian transpose of W
X4  = X3' ;			% a column vector
[ et2, ~, d2 ] = equals( X1, X3, tol )

e2 = equals( X1, X3 )
e3 = equals( X2, X3 )
e4 = equals( X2, X4 )

[ et3, ~, d3 ] = equals( X2, X3, tol )
[ et4, ~, d4 ] = equals( X2, X4, tol )

whos X1 X2 X3 X4

%% Exercise 4.1.3: Plot complex signals

s = ( 2 * pi ) / N ;
t = [ 0 : s : 2 * pi ] ;	%a subtle error here

fsin	= sin( t ) ;
fcos	= cos( t ) ;
FSIN	= fft( fsin ) ;
FCOS	= fft( fcos ) ;

plotComplex( 1, 'stem', fsin, t ) ;
plotComplex( 2, 'stem', fcos, t ) ;
plotComplex( 3, 'stem', FSIN ) ;
plotComplex( 4, 'stem', FCOS ) ;

t2		= t( 1 : end - 1 ) ;
fsin2	= sin( t2 ) ;
FSIN2	= fft( fsin2 ) ;

% figure( 5 ) ;
% subplot( 2, 2, 1 ) ;
% stem( t, fsin ) ;
% subplot( 2, 2, 2 ) ;
% stem( t2, fsin2 ) ;
% subplot( 2, 2, 3 ) ;
% stem( t, real( FSIN ) ) ;
% subplot( 2, 2, 4 ) ;
% stem( t2, real( FSIN2 ) ) ;
% set( gcf,'color','w') ;



%% Exercise 4.1.4: better Fourier analysis

%E4b:
tol		= 1e-10 ; 

N		= 8			% aka sps
f0		= 1		
T		= 1 / f0  
ts		= T / N 		%sample time

%wrong time axis sampling: +1 error: 
%t		= [ 0 : ts : T ] ;
%correct time axis sampling:
t		= [ 0 : ts : T - ts ] ;				% Exercise 4.1.4b

fsinf0	= sin( 2 * pi * f0 * t ) ;
fcosf0	= cos( 2 * pi * f0 * t ) ;

FSINf0	= bft( fsinf0, N, false, tol ) ;	% Exercise 4.1.4a
FCOSf0	= bft( fcosf0, N, false, tol ) ;
%proper frequency bin indices
fi = [ [ - N / 2 : 1 : -1 ] 0 [ 1 : 1 : ( N / 2 ) - 1 ] ] ;

figure( 1 ) ;
subplot( 2, 2, 1 ) ;
stem( t, fsinf0 ) ;
subplot( 2, 2, 2 ) ;
stem( fi, imag( FSINf0 ) ) ;

subplot( 2, 2, 3 ) ;
stem( t, fcosf0 ) ;
subplot( 2, 2, 4 ) ;
stem( fi,  FCOSf0 ) ;
set( gcf,'color','w') ;

% figure( 2 ) ;
% subplot( 1, 2, 1 ) ;
% plot( t, fsinf0 ) ;
% subplot( 1, 2, 2 ) ;
% plot( t, fcosf0 ) ;
% set( gcf,'color','w') ;

% Figure 4.21:
figure( 3 )
subplot( 2, 2, 1 ) ;
title('Basic FFT') ;
stem( imag( fft( fsinf0 ) ) ) ;	%uncentered FFT
title('Basic FFT') ;
subplot( 2, 2, 2 ) ;
stem( imag( FSINf0 ) ) ;		%centered FFT
title('Centered FFT') ;
subplot( 2, 2, 3 ) ;
stem( fi, imag( FSINf0 ) ) ;	%proper frequency bin labels
title('+ freq labels') ;
subplot( 2, 2, 4 ) ;
stem( fi, imag( FSINf0 ) ) ;	%centered axes
title('+ centered axes') ;
ax = gca ;
ax.XAxisLocation = 'origin' ;
ax.YAxisLocation = 'origin' ;
set( gcf,'color','w') ;

%% Exercise 4.1.4c: double the frequency
tol		= 1e-10 ; 

N		= 16			% aka sps
f0		= 1 
T		= 1 / f0 
ts		= T / N 		%sample time
t		= [ 0 : ts : T - ts ] ;
f1		= 2 * f0 
unit	= true

fsinf1	= sin( 2 * pi * f1 * t ) ;
fcosf1	= cos( 2 * pi * f1 * t ) ;

FSINf1	= bft( fsinf1, N, unit, tol ) ;
FCOSf1	= bft( fcosf1, N, unit, tol ) ;
fi = [ [ - N / 2 : 1 : -1 ] 0 [ 1 : 1 : ( N / 2 ) - 1 ] ] ;

figure( 1 ) ;
subplot( 2, 2, 1 ) ;
stem( t, fsinf1 ) ;
subplot( 2, 2, 2 ) ;
stem( fi, imag( FSINf1 ) ) ;

subplot( 2, 2, 3 ) ;
stem( t, fcosf1 ) ;
subplot( 2, 2, 4 ) ;
stem( fi,  FCOSf1 ) ;
set( gcf,'color','w') ;


%% Exercise 4.1.5: energy and power

tol		= 1e-10 ; 

f0		= 1 
A		= 2
T		= 1 / f0 

N		= 16			% aka sps
ts		= T / N			%sample time
t		= [ 0 : ts : T - ts ] ;
f		= [ [ - N / 2 : 1 : -1 ] 0 [ 1 : 1 : ( N / 2 ) - 1 ] ] ;
f1		= 2 * f0

% Exercise 4.1.5b
fcos1	= A * cos( 2 * pi * f0 * t ) ;
fcos2	= A * cos( 2 * pi * f1 * t ) ;
FCOS1	= bft( fcos1, N, false, tol ) ;
FCOS1U	= bft( fcos1, N, true, tol ) ;
FCOS2U	= bft( fcos2, N, true, tol ) ;

figure( 1 ) ;
subplot( 2, 2, 1 ) ;
stem( t, fcos1 ) ;
subplot( 2, 2, 2 ) ;
stem( f, FCOS1U ) ;
subplot( 2, 2, 3 ) ;
stem( t, fcos2 ) ;
subplot( 2, 2, 4 ) ;
stem( f, FCOS2U ) ;


%energy and power in time domain
[ E1t, P1t ] = ep( fcos1 )			% Exercise 4.1.5a
[ E1f, P1f ] = ep( FCOS1 ) ;
P1f = P1f / N
[ E1fu, P1fu ] = ep( FCOS1U )

[ E2t, P2t ] = ep( fcos2 )
[ E2fu, P2fu ] = ep( FCOS2U )
%power in time domain


%energy in freq domain
%power in freq domain
%parseval theorem



%% Exercise 4.1.6: Filtering 
clear ;

% Exercise 4.1.6 first try a column vector orientation: 
Hn = [ 3 2 1 0 -1 1 ]' 
SigInC = [ 1 1 -1 -1 1 1 -1 -1 1 1 ]'
N = length( SigInC ) 

Mc = convMtx( Hn, N )
SigOut1C = Mc * SigInC ;
SigOut2C = conv( SigInC, Hn ) ;

okC = isequal( SigOut1C, SigOut2C )

%second try row vectors:
HnR = Hn.' ;
SigInR = SigInC.' ;

McR = convMtx( HnR, N )			% Exercise 4.1.6a
SigOut1C = SigInR * McR 
SigOut2C = conv( SigInR, HnR ) 

okR = isequal( SigOut1C, SigOut2C )

whos


