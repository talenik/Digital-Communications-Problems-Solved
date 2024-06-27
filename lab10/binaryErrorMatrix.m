function errors = binaryErrorMatrix( pb, rows, columns ) 
%Generates random binary matrix.
%	The number of ones in this matrix must follow the probability specified
%	by parameter pb.

r			= rand( rows, columns ) ;
i			= ( r <= pb ) ;
errors		= zeros( rows, columns ) ;
errors( i ) = 1 ;