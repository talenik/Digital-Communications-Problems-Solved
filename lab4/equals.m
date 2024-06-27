function [ E, H, D ] = equals( A, B, tol )
% equal - test if two matrices contain equal values
%
%	E = equal( A, B )
%		same as isequal( A, B )
%
%	E = equal( A, B, tol )
%		returns true if the sum of absolute values 
%		of differences of all elements is less than
%		a given tolerance
%
%	[ E, H, D ] = equal( A, B [ , tol ] )
%		E - boolean flag indicating matrix equality
%		H - hamming distance of matrices
%		D - sum of absolute differences
%
%	returns false if matrices not of the same size

if ~isequal( size( A ), size( B ) )
	E = false ;
	H = -1 ;
	D = -1 ;
	return
end

if nargin < 3 
	if isequal( A, B )
		E = true ;
		H = 0 ;
		D = 0 ;
		return 
	else
		E = false ;
		H = hamming() ;
		D = difff() ;
	end
else
	D = difff() ;
	if D < tol
		E = true ;
	else
		E = false ;
	end
	H = hamming() ;
end

	%inner functions
	function h = hamming( )
		h = nnz( A ~= B ) ;
	end

	function d = difff()
		d  = sum( sum( abs( A - B ) ) ) ;
	end

end


