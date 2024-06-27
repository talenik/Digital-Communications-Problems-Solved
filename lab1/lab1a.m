%% Exercise 1.1.1 ----------------------------------------------------

a = 2 * pi
v = [ 1 : 1 : 8 ] %
A = [ 1 2 ; 3 4 ]
b = a ; u = v ; B = A
c = a + 2 * b ; w = v + 2 * u ; C = A + 2 * B
whos
a + v   %OK: scalar + vector
a + A   %OK: scalar + matrix
a * v   %OK: scalar * vector
a * A   %OK: scalar * matrix
%A + v   %error: size mismatch
v + u'  %NOT error, but unexpected conversion vector > matrix
clear a

%% Exercise 1.1.2 ----------------------------------------------------

Hx = -( (1/2)*log2(1/2) +(1/4)*log2(1/4)+(1/4)*log2(1/4))
x = 1
fx = sqrt( exp( -2*( x - 3) / (x - 2) ) / 2*pi*i )
fx = sqrt( exp( -2*( x - 3) / (x - 2) ) / ( 2 * pi * i ) )

%limit goes to infinity
x = 2
fx = sqrt( exp( -2*( x - 3) / (x - 2) ) / ( 2 * pi * i ) )

x = pi
fx = sqrt( exp( -2*( x - 3) / (x - 2) ) / ( 2 * pi * i ) )

%% Exercise 1.1.3 ----------------------------------------------------

format compact
e = 0.00000000000000022204
eps
e == eps
%help format
format long
e
eps
e == eps

%% Exercise 1.1.4 ----------------------------------------------------

%naive:
sin( pi ) == 0
tan( pi / 2 ) == Inf

%better - comparing floating point values with tolerance:
tol = 1e-9
abs(sin(pi) - 0) < tol
lim = 1e+12
abs(tan(pi/2)) > lim

%% Exercise 1.1.5 ----------------------------------------------------

format short
B = [ 16 2+i 3-2i ; 5 11 10 ]
C = B'        %conjugate transpose - correct for complex-valued matrices
D = B.'       %just transpose - carefull !
E = conj( B ) %just conjugate

C == D  %OK, result is a logical matrix
%D == E  %ERROR: size mismatch
%E == C  %ERROR: size mismatch

%proper equality test:
isequal( C, D )
isequal( D, E ) %doesnt produce size mismatch error
isequal( E, C ) %doesnt produce size mismatch error

%% Exercise 1.1.6 ----------------------------------------------------

A = [ 3 2 -1 ; 2 -2 4 ; -1 1/2 -1], b = [1 -2 0]', A\b





