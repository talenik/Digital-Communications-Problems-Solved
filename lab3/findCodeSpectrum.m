function [ spectrum, dmin ] = findCodeSpectrum( G ) 

Codewords = findAllCodewords( G ) ;
%assuming all zero codewords is the first row - if present
Codewords = Codewords( 2 : end, : ) ;

HammingWeights	= sum( Codewords, 2 ) ;
dmin			= min( HammingWeights ) ;
dmax			= max( HammingWeights ) ;
spectrum = [ zeros( 1, dmin - 1 ) hist( HammingWeights, [ dmin : 1 : dmax ] ) ] ;
