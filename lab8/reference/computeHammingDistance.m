function dHamm = computeHammingDistance( U, V )
% Computes Hamming distance of two matrices U and V.
%
% The use of the built-in function pdist() is prohibited.

dHamm	=  nnz( U - V ) ;