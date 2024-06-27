function data = binarySource( rows, columns )
% Generates random binary matrix with uniform distribution 
%	- that is ones must occur with the same probability as zeros.
% Usage: data = binarySource( rows, columns )
%
% You may only use the built-in function rand() in your implementation.

data	= binaryErrorMatrix( 0.5, rows, columns ) ;

