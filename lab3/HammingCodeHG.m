function [ H, G ] = HammingCodeHG( r )
%[ H, G ] = HammingCodeHG( r )
%	finds the parity check matrix H and generator matrix G for
%	a Hamming code defined by it's order R.
%	Both matrices are in systematic form and the orientation
%	of the matrices facilitates the use of a row-vector
%	dataword representation.
% The use of the hammgen( ) function from the Communication System
% toolbox in your implementation is explicitly prohibited.

[ n k ] = HammingCodeNK( r ) ;
m		= n - k ;

p       = setdiff( [ 1 : n ], 2.^[ 0 : r - 1 ] ) ;
P       = deToBi( p', r ) ;
H       = [ P' eye(r) ] ;
G       = [ eye(k) P  ] ;



