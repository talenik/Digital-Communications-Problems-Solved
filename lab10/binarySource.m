function data = binarySource( rows, columns )
% Generates random binary matrix with uniform distribution 
%	- that is ones must occur with the same probability as zeros.
% Usage: data = binarySource( rows, columns )

data	= randi( [0 1], rows, columns ) ;
%or:
%data 	= binaryErrorMatrix( 0.5, rows, columns ) ;
