function Rn  = random( s, m, v )
% Exercise 7.1:
% randn() wrapper for generating arbitrary normal distribution values
% usage: Rn  = random( [ s, m, v )
%   s - size of the output matrix s = [ M N ]
%	m – desired sample mean value with default value 0 if not specified
%	v  – desired sample variance with default value 1 if not specified

if nargin < 3 
	v = 1 ;
end
if nargin < 2
	m = 0 ;
end

M = s( 1 ) ;
N = s( 2 ) ;

Rn = m + sqrt( v ) * randn( M, N ) ;