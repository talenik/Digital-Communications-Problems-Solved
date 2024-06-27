function errorVectors = findAllErrorVectors( n, tcor )
% For a given codeword size n, and maximum number of corectable errors tcor,
% generate all error vectors - generate all combinations of binary 
% vectors with number of ones between 0 and tcor (including).
% Store these as rows in a matrix.

errorVectors = [] ;
%i is the number of errors
for i = 0 : 1 : tcor
	%generate all possible error words with i ones in them
	Cni = findGF2Combinations( n, i ) ;
	errorVectors = [ errorVectors ; Cni ] ; 
end 
