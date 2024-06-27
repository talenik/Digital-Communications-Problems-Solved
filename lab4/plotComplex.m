function h = plotComplex( f, type, signal, x )
%plotComlex		plot/stem complex-valued signal
%	plots a 2x2 grid of: real and imaginary parts, magnitude and phase
%
%	plotComplex( f, type, signal )
%		f		- figure number
%		type	- 'stem' or 'plot'
%		signal	- a vector of signal (y-axis) values
%		Indices of signal will serve as the x-axis values. 
%
%	plotComplex( f, type, signal, x )
%		x		- vector of x-values
%
%	returns: figure handle
%
%	Example:
%		h = plotComplex( 1, 'stem', Sig ) ;

if nargin < 4
	x = [ 1 : length( signal ) ]
end

if isequal( type, 'stem')
	pfh = @stem ;
	mrk = '.' 
else
	pfh = @plot ;
	mrk = 'none'
end

if ~ishandle( f )
	h = figure( f ) ;
end

subplot( 2, 2, 1 ) ;
pfh( x, real( signal ), 'Marker', mrk ) ;
title('real') ;

subplot( 2, 2, 2 ) ;
pfh( x, imag( signal ), 'Marker', mrk  ) ;
title('imag') ;

subplot( 2, 2, 3 ) ;
pfh( x, abs( signal ), 'Marker', mrk  ) ;
title('magnitude') ;

subplot( 2, 2, 4 ) ;
pfh( x, angle( signal ), 'Marker', mrk ) ;
title('phase') ;

set( gcf,'color','w') ;