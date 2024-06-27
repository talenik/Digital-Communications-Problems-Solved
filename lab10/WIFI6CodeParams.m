function [ codeParam ]  = WImaxCodeParams( N, CodeId )
%Prepare and validate various parameters needed for WiMax LDPC decoding.
%	arguments: 
%		N		- codeword size 
%		CodeId	- specify, which one of the WiMax LDPC codes to use:
%				0 for the weakest code Rate 5/6
%				5 for the most powerfull code Rate 1/2
%				6 for no ECC 
%
%	returns:
%		codeParam - structure of various code parameters

%WiMax codewords sizes
legalCodewordSizes = 576 + 96 * [ 0 : 1 : 18 ] ; 

if isempty(find(legalCodewordSizes == N, 1))
	error('Not a legal codeword size for WiMax.') ;
end ;

RcS			= [5/6 3/4 3/4 2/3 2/3 1/2 1] ;
Rc			= RcS( CodeId + 1 ) ;

Mbs			= [ 4, 6, 6, 8, 8, 12 0] ;
Mb			= Mbs( CodeId + 1 ) ;

Nb			= 24 ;
TierSize	= N / Nb ;  %toto je z 

M			= Mb * TierSize ;
K			= N - M ;

%WiMax Z ( Tiersize ) sizes
legalZSizes = 24 + 4 * [0:1:18] ; 
if isempty(find(legalZSizes == TierSize, 1))
	error('Not a legal TierSize for WiMax.') ;
end ;

%pack everything in a nice structure
codeParam.N			= N ;
codeParam.K			= K ;
codeParam.M			= M ;
codeParam.TierSize	= TierSize ; %aka z
codeParam.Nb		= Nb ;
codeParam.Mb		= Mb ;
codeParam.Rc		= Rc ;
codeParam.CodeId	= CodeId ;
codeParam.Hbm		= WImaxLDPC( CodeId ) ;
