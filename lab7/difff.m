function [ D ] = difff( A, B )
% cumulative Euclidean distance between the elements of two complex
% matrices
assert( isequal( size( A ), size( B ) ) ) ;

Tr = ( real( A ) - real( B ) ).^ 2 ;
Ti = ( imag( A ) - imag( B ) ).^ 2 ;

assert( all( all( Tr >= 0 ) ) && all( all( Ti >= 0 ) ) ) ;

D = sum( sum( sqrt ( Ti + Tr ) ) ) ; 