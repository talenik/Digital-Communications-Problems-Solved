function ok = valueOK( M )
% ok = valueOK( M [, limit ] )
%	performs basic values check, detects suspicious values:
%		Inf, NaN
%	if limit set, also detects extremely large values

if nargin < 2
	limit = Inf ;
end

if any( isnan( M ), 'all' )
	error('variable contains NaN') ;
end

if any( isinf( M ), 'all' )
	error('variable contains Inf') ;
end

if isinf( limit )
	ok = 1 ;
else
	ok = nnz( abs( M ) > limit ) == 0 ;
end