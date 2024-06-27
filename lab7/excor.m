function [ R, lags, lag0Index ] = excor( A, B )
% Exercise 7.6: 
% excorr - ensemble cross-correlation
%	wrapper for xcor() function to perform enemble (columnwise)
%	crosscorrelation of two matrices
%
%	[ Rxx, lags, lag0index ] = excorr( A, B )
%		calculates crosscorrelation of matrices A and B
%		A, B - a matrix, each column represents a data stream/realization
%		the number of columns of A and B must be equal
%		for all columns, only the crosscorrelation of column 
%		c of A with the same column of matrix B is calculated
%
%	excorr( A )
%		calculates autocorrelation
%		A - a matrix, each column represents a data stream
%		only an autocorrelation of column c with itself is calculated



if nargin < 2
	Y = X ;
end

[ ra, ca ]	= size( A ) ;
[ rb, cb ]	= size( B ) ;

if ca ~= cb
	error( 'incompatible nr. of columns' ) ;
end

rc = ra + rb - 1 ;

R = zeros( rc , ca ) ;
[ R( :, 1 ), lags, lag0Index ] = xcor( A( :, 1 ), B( :, 1 ) ) ;

for c = 2 : 1 : ca
	[ R( :, c ) ] = xcor( A( :, c ), B( :, c ) ) ;
end