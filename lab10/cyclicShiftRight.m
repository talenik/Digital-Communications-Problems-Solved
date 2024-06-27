function rotated = cyclicShiftRight( M, shift )
% Exercise 10.6: Performs cyclic shift of vector's position - the ROR operation.
% Performs horizontal ROR, if a matrix is supplied, rotate all rows.
% The scalar shift specifies how many positions to rotate
%	if negative, a ROL operation is performed.

% Exercise: complete the code to obtain required functionality

[ y, x ] = size( M ) ;

if y > 1 && x == 1
	%column vector
	n = y ;
else
	%row vector or matrix
	n = x ;
end

if shift < 0
	%implement left shift as negative shift
	shift = n + shift ;
end 

shift	= mod( shift, n ) ;
s		= n - shift ;

if y > 1 && x == 1
	%column vector
	rotated = [ M( s + 1 : end ) ; M( 1 : s ) ] ;
else
	rotated = [ M( :, s + 1 : end ) M( :, 1 : s ) ] ;
end
