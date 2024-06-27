function SignalSpaceSymbols = modulateBPSK( LogicalSymbols )
% Performs all digital BPSK modulation. The
% The output should be signal space (IQ plane) prototypes.  
% Use the following mapping of the logical binary signal to signal space prototype: 0 -> -1, 1 -> +1.
% The input and output may be a scalar, vector or a matrix.

SignalSpaceSymbols 	= 2 * LogicalSymbols - 1 ;

