function Codeword = encodeLDPCmatrix( U, H, Z )
% Exercise 10.15
% encodeQCLDPCmatrix
%	Perform LDPC direct encoding procedure as specified in the 
%	IEEE 802.16e standard Annex G.
%	Encoder specific for QC-LDPC H matrix structures defined
%	in IEEE 802.16e and IEEE 802.11ax
%
% Codeword = encodeQCLDPCmatrix( U, H ) 
% Input arguments:
%	U is the data word - the data bits - column vector of length k
%	H is a sparse large binary parity check matrix of size m x n
%		that may be partitionaed to a grid of mb x nb square submatrices
%		each of szie z x z. nb is allways 24
%		mb and nb are standard-defined
%		z is auto-computed
% Return value:
%	Codeword - the systematic codeword - vector of length n
%
% Codeword = encodeLDPCmatrix( U, H, Z )
%	use this for non-standard experimental values of z, mb, nb 


if nargin == 3
	z = Z ;
end

[ m, n ] = size( H ) ;
k		= n - m ;

if ~exist('z','var') || isempty( z )
	z = n / 24 ;
end

[ A, B, T, C, D, E ] = partitionH( H, z ) ;


TI = invGF2dd( T, z ) ;
%test GF(2) inverse of double diagonal matrix
test	= mod( T * TI, 2 ) ;
if ~isequal( test, eye( m - z ) )
	error('Matrix inversion GF(2) failed.') ;
end

ETI		= mod( E * TI, 2 ) ;
%also test the identity (22) here:
FI		= mod( ETI * B + D, 2 ) ;

if ~isequal( FI, eye( size( FI, 1 ) ) )
	error('FI should be an identity matrix.') ;
end

T1		= mod( ETI * A + C, 2 ) ;
P1		= mod( T1 * U, 2 ) ;
P2		= mod( TI * ( A * U + B * P1 ), 2 ) ;

Codeword = [ U ; P1 ; P2 ] ;

