function p = plotSignals( f, type, signals, x, colors )
%plotSignals	plot/stem real/complex signal or multiple signals
%	if signal is real, plots a simple plot
%	if signal is complex, plots a grid of: real, imag, abs, angle
%	if signal is a vector, plots it as y-axis values
%	if signal is a matrix, plots each column as a separate signal 
%	assumes first index for plot is zero
%
%	plotSignals( f, type, signals )
%		f		- figure handle
%		type	- 'stem' or 'plot'
%		signal	- a vector/matrix of signal (y-axis) values
%		Indices of signal will serve as the x-axis values.
%	plotSignals( f, type, signals, colors )
%		colors	- char array indicating color for each signal
%				  each letter must be one of: 'rgbcmykw' 	
%
%	plotSignals( f, type, signals, x )
%		x		- vector of x-values, must be same length as signal
%
%	returns: line handles - plot output
%
%	See also: plotComplex, plot, stem

	if nargin == 0 
		%run unittest
		p = unitTest() ;
		return ;
	end
	if nargin < 5
		colors = false ;
	end
	if nargin < 4
		%assuming first index for plot is zero
		x = [ 0 : 1 : size( signals, 1 ) - 1 ] ;
	end

	[ R, C ] = size( signals ) ;

	if isreal( signals )
		if isequal( type, 'stem' )
			p = stem( x, signals, 'Marker', '.' ) ;
		else
			p = plot( x, signals ) ;
		end
		if colors	% not empty
			if length( colors ) ~= C
				error('nr. of colors must be equal to nr. of signals') ;
			end
			for c = 1 : C
				p( c ).Color = colors( c ) ;
			end
		end
	else
		p = plotComplex( f, type, signals, x ) ;	
	end
end

function ok = unitTest()
	x = [ 0 : 0.1 : 2 * pi ]' ;
	f = sin( x ) ;
	g = cos( x ) ;
	S = [ f g ] ;
	Z = -1 * S ;

	h = figure() ; 
	p = plotSignals( h, 'plot', S ) ;	%plot to a figure
	hold on ;
	p = plotSignals( h, 'plot', Z ) ;	%add signals to existing plot

	h = figure() ; 	
	p = plotSignals( h, 'plot', S, x ) ;	
	p = plotSignals( h, 'plot', Z, x ) ; %overwrite figure
	
	h = figure() ; 
	p = plotSignals( h, 'stem', S, x, 'rb' ) ;
	p = plotSignals( h, 'stem', Z, x, 'km' ) ; %overwrite figure

	ok = true ;
end