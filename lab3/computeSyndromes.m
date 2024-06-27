function Syndromes = computeSyndromes( H, Words )
% Syndromes = ComputeSyndromes( H, Words )
%	computes syndromes for a given matrix of row-wise stored binary words.
%	Stores resulting syndromes row-wise in a single matrix.

Syndromes = mod( Words * H', 2 ) ;