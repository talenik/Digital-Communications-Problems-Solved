function W = ftm( N )

e = [ 0 : N - 1 ] ;

%matrix of exponents
me = e' * e ;

%scaling factors
fi	= sqrt( N ) ;
f	= ( 1 / fi ) ;

W =  f * exp( -2 * pi * i * me / N ) ;