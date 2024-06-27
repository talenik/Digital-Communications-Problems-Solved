function h = customPlot( Signals, type, time )
%standard plot just plots real part by default
%if signal is real valued - just plot the signal
%if signal is complex valued - throw erro

%processing third argument
if nargin < 3
	%time is not specified at all
	[ r, c ]	= size( Signals ) ;
	maxTime		= max( r, c ) ;		%the longer dimension wins :)
	time		= [ 0 : 1 : maxTime - 1 ] ;
else
	maxTime	= max( size( time ) ) ;
	if maxTime == 1
		%time is not a vector but Ts 
		maxTime = max( size( Signals ) )
		time	= time * [ 0 : 1 : maxTime - 1 ] ;
	else
		%check signal size compatibility
		if maxTime ~= max( size( Signals ) )
			whos
			error('Signal size different from time size.') ;
		end
	end
end

%proces second argument
if nargin < 2
	%default type is continuous
	type = 'cont' ;
end

%process first argument
if ~isreal( Signals )
	%error beter than warning ???
	error('Signals are copmlex') ;
end


if strcmp( type, 'cont')
	h = plot( time, Signals ) ;
else
	%discrete-time plot
	h = stem( time, Signals, 'Marker', '.' ) ;
end