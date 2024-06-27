%% Exercise 1.2.1 ----------------------------------------------------

N = 5

u = [ 0 : N - 1 ]'
v = [ N : 2 * N - 1 ]
w = [ 3 : 2 : 2 * N + 2 ]
inner = u' * v'
elem  = u .* v

%% Exercise 1.2.2 ----------------------------------------------------
m = 4
%rand produces numbers between 0 and 1, must use transform:
A = round( 10 * rand( m ) )

rank( A )
det( A )

%sum all columns:
sum( A )

%sum all rows:
sum( A, 2 )

%sum all elements:
%sum( A, 'all' )	%this will work in new MATLAB, not Octave
sum( sum( A ) )		%will work everywhere

Alr = fliplr( A )
Aud = flipud( A )
Atr = A'
A90 = rot90( A )

isequal( Atr, A90 ) %not equal: transpose is NOT 90 degree rotation

%% Exercise 1.2.3 ----------------------------------------------------

v  = A( :, 2 )
u  = A( 1, : )
w  = A( end, : )
A1 = A( :, 1 : m / 2 )
A2 = A(  ( m / 2 ) + 1 : end, : )

v1 = A(:)'
%this will work in Octave, but notin MATLAB:
%v2 = A'(:)'

%more portable code
T = A' ;
v2 = T(:)'

%% Exercise 1.2.4 ----------------------------------------------------

%logical indexing
A5 = A( A > 5 )
ind = A > 5 ;

C = zeros( size( A ) )
C( ind ) = A( ind )

%linear indexing
ind = find( A > 5 )
C = zeros( size( A ) )
C( ind ) = A( ind )



A( ind ) = 0


%% Exercise 1.2.5 ----------------------------------------------------

%This will work in Octave, but not MATLAB:
%Octave - local functions must be defined before first call:
%Comment these function definitions out or delete in MATLAB:
 % function [ S1, S2, S3, S4, S5, S6 ] = foo( A )
 %   [ r, c ] = size( A )
 %   if r ~= 4 || c ~= 4
 %     error('unsupported matrix size') ;
 %   end
 %   S1 = A( 1, 1 : 3 ) ;
 %   S2 = A( 2 : 4, 4 ) ;
 %   S3 = A( 2 : 3, 2 : 3 ) ;
 %   S4 = A( 2 : 4, 1 ) ;
 %   S5 = A( 4, 2 : 3 ) ;
 %   S6 = A( 1, 4 ) ;
 % end
 % 
 % function D = bar( S1, S2, S3, S4, S5, S6 )
 %   D = zeros( 4 ) ;
 %   D( 1 : 3, 1 ) = S1' ;
 %   D( 4, 1 ) =  S6' ;
 %   D( 1, 2 : 4 ) = S4' ;
 %   D( 2 : 3, 2 : 3 ) = S3' ;
 %   D( 4, 2 : 4 ) = S2' ;
 %   D( 2 : 3, 4 ) = S5' ;
 % end

A = round( 10 * rand( m ) )
[ S1, S2, S3, S4, S5, S6 ] = foo( A )
D = bar( S1, S2, S3, S4, S5, S6 )

ok = isequal( D, A' )


%% Exercise 1.2.6 ----------------------------------------------------

N = 5 ;

A = round( rand( N ) )
v = round( rand( N, 1 ) )

Av = mod( A * v, 2 )
Al = logical( Av )

whos Av Al

%% Exercise 1.2.5 MATLAB - local functions must be defined AT THE END OF THE SOURCE FILE
% This will work in MATLAB, but not in Octave:
function [ S1, S2, S3, S4, S5, S6 ] = foo( A )
  [ r, c ] = size( A )
  if r ~= 4 || c ~= 4
    error('unsupported matrix size') ;
  end
  S1 = A( 1, 1 : 3 ) ;
  S2 = A( 2 : 4, 4 ) ;
  S3 = A( 2 : 3, 2 : 3 ) ;
  S4 = A( 2 : 4, 1 ) ;
  S5 = A( 4, 2 : 3 ) ;
  S6 = A( 1, 4 ) ;
end

function D = bar( S1, S2, S3, S4, S5, S6 )
  D = zeros( 4 ) ;
  D( 1 : 3, 1 ) = S1' ;
  D( 4, 1 ) =  S6' ;
  D( 1, 2 : 4 ) = S4' ;
  D( 2 : 3, 2 : 3 ) = S3' ;
  D( 4, 2 : 4 ) = S2' ;
  D( 2 : 3, 4 ) = S5' ;
end





