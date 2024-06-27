function bin = deToBi( dec, width )
% dec is a scalar nonnegative integer value
% bin is a matrix of binary vectors representing the values

str     = dec2bin( dec, width ) ; 
if size( str, 2 ) > width
	error('width too small') ;
end

ind     = find( str == '1' ) ; 
y       = size( dec, 1 ) ;
bin     = zeros( y, width ) ; 
bin( ind ) = 1 ;
