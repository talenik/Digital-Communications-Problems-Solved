function myplot( x, y, xlab, ylab, what )

if nargin < 5
	what = 'plot' ;
end

if nargin < 4
	ylab = '' ;
end

if nargin < 3
	xlab = '' ;
end

if nargin < 2
	len = length( x ) ;
	y = x ;
	x = [ 1 : 1 : len ] ;
end




if isequal( what, 'plot')
	plot( x, y ) ;
elseif isequal( what, 'stem')
	stem( x, y ) ;
elseif isequal( what, 'semi')
	semilogy( x, y ) ;
	grid on ;
else
	error('Plot type not implemented (yet).') ;
end

xlabel( xlab, 'HorizontalAlignment','right') ;
ylabel( ylab, 'VerticalAlignment','top') ;

set( gcf,'color','w') ;