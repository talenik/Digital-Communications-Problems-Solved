function ort = areOrthogonal( G, H )
% ort = areOrthogonal( G, H ) 
%	tests orthogonality of GF(2) matrices G and H.
%	returns 1 is matrices are orthogonal, 0 otherwise

R = G * H' ;
R = sum( sum( abs( mod( R, 2 ) ) ) ) ;

if R > 0
	ort = 0 ;
else
	ort = 1 ;
end;
