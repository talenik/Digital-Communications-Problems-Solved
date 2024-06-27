function errors = binaryErrorMatrix( pb, rows, columns ) 
%Generates random binary matrix.
%	The number of ones in this matrix must follow the probability specified
%	by parameter pb.
%
% You may only use the built-in function rand() in your implementation.

r			= rand( rows, columns ) ;
i			= ( r <= pb ) ;
errors		= zeros( rows, columns ) ;
errors( i ) = 1 ;