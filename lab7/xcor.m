function [ R, lags, lag0i ] = xcor( A, B )
% Exercise 7.5: 
% xcor - simple non-normalized cross correlation of two column vectors
%
%	[ R, lags, lag0i ] = xcor( A, B )
%		calculates crosscorrelation between vectors A and B
%		R - crosscorrelation values, when vector B is shifted
%		lags - shifts of B: from -length( B ) - 1 to length( A ) - 1
%		lag0i - index of zero lag for getting R(0)
%
%	xcor( A )
%		calculates autocorelation
%
%	see also: conv, xcorr, convMtx

	if nargin == 0
		R = unitTest() ;
		return ;
	elseif nargin < 2 
		B = A ;
	end
	
	[ ra, ca ] = size( A ) ;
	[ rb, cb ] = size( B ) ;
	
	if ca > 1 || cb > 1
		error("Both arguments must be column vectors") ;
	end

	rl	= ra + rb - 1 ;
	l	= rb - 1 ;
	Af	= [ zeros( l, 1 ) ; A ] ;

	lags	= [ - ( rb - 1 ) : 1 : ra - 1 ] ;
	lag0i	= rb ;

	B	= flipud( B ) ;
	RM	= convMtx( B, ra ) ;
	assert( size( RM, 1 ) == rl ) ;
	R = RM * A ;

end

function ok = unitTest
	A = [ 1 2 3 ]' ;
	[ Ra1, l1, l0i ] = xcor( A ) 
	[ Ra2, l2 ] = xcorr( A ) 
	Ra1( l0i )
	Rok = equals( Ra1, Ra2, 1e-8 ) ;
	Lok = equals( l1, l2 ) ;
	ok = Rok && Lok 

	A = [ 1 2 3 ]'
	B = [ 8 7 6 5 4 ]'
	[ R1, l1, l0i ] = xcor( B, A ) 
	[ R2, l2 ] = xcorr( B, A ) 
	R1( l0i )
	Rok = equals( R1, R2(3:end), 1e-8 )
	Lok = equals( l1, l2 )

	ok = ok && Rok && Lok
end