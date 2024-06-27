function bits = hardDecision( LLR )
% Exercise 10.19: 
% Performs hard decision on supplied LLR values.
% the output are GF(2) values of bits, stored as doubles.
% Assumes BPSK modulation 0 -> + 1, therefore
% shoul output 0 where LLR > 0 

bits = ones( size( LLR ) ) ;
bits( LLR > 0 ) = 0 ;
