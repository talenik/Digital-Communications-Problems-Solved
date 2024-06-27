function dHamm = computeHammingDistance( U, V )
% Computes Hamming distance of two matrices U and V.

T		= U - V ;
dHamm	= nnz( T ) ;