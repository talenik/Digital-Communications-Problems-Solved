function LogicalSymbols =  detectBPSK( SignalSpaceSamples )
% Demodulate noisy detector samples of BPSK modulation.
% Works only in case of real valued BPSK with mapping:
% logical 0 -> signal space -1, logical 1 -> signal space +1.

LogicalSymbols		= zeros( size( SignalSpaceSamples ) ) ;
ind					= SignalSpaceSamples > 0 ;
LogicalSymbols(ind)	= 1 ;