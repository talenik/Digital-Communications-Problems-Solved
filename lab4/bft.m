function Spectr = bft( Signal, N, unitary, tol )
%better DFT, assuming N is even

if nargin < 4
	tol = 1e-10 ;
end

if nargin < 3
	unitary = false ;
end

if nargin < 2 
	N = max( size( Signal ) ) ;
end

if mod( N, 2 ) ~= 0
	error( 'N not even' ) ;
end

if unitary
	S = 1 / sqrt( N ) ;
else
	S = 1 ;
end

X0 = S * fft( Signal, N ) ;

%shift zero frequency to zero
X1 = fftshift( X0 ) ;
X2 = [ X0( ( N / 2 ) + 1 : end ) X0( 1 : N / 2 ) ] ;

assert( isequal( X1, X2 ) ) ;
Spectr  = X2 ;

rs = sum( abs( real( Spectr ) ) ) ;
is = sum( abs( imag( Spectr ) ) ) ;

if rs < tol
	Spectr = i * imag( Spectr ) ;
elseif is < tol
	Spectr = real( Spectr ) ;
end