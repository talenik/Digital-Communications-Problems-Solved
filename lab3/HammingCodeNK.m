function [ N, K ] = HammingCodeNK( r )
% [ N K ] = HammingCodeNK( r ) 
%	finds the Codeword size N and dataword size K for a given
%	R - parameter of a Hamming code.

N = 2^r - 1 ;
K = 2^r - r - 1 ;
