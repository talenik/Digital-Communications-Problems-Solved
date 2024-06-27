function H = convMtx( h, N )

[ y, x ] = size( h ) ;

if x > 1
	%row vector
	h = h.' ;
	if y > 1
		% H is a matrix
		error('H is not a vector') ;
	end
	row = true ;
else
	%column vector
	row = false ;
	if y == 1
		error('H is a scalar') ;
	end
end

ny = max( x, y ) ;

r	= N + ny - 1 ;
c	= N ;

H = zeros( r, c ) ;
Hc = [ h ; zeros( r - ny , 1 ) ] ;

for i = 1 : c 
	H( :, i ) = Hc ;
	Hc = [ 0 ; Hc( 1 : end - 1 ) ] ;
end

if row
	H = H.' ;
end