function Zn0 = detectorSamplesLLR( RxBlock , noiseVariance ) 
% Exercise 10.18: 
% Compute channel LLRs in BPSK AWGN.
%	Takes samples from a BPSK detector in a receiver 
%	as input, and produces corresponding LLRs: Zn(0) as output.
%	Assume AWGN channel model with known noise variance.

Zn0 = ( 2 / noiseVariance ) * RxBlock ;