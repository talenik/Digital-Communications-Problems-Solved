function [ E, P ] = ep( Signal ) 

[ y, x ] = size( Signal ) ;

if y > 1
	N = y ;
else
	N = x ;
end

E = sum( Signal .* conj( Signal ) ) ;
P = E ./ N ;