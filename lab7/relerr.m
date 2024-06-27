function re = relerr( vt, vm ) 
% relerr - calculate relative error in per cent
%	re = relerr( vt, vm )
%		vt - true value
%		vm - measured value
%		re - relative error - nonnegative, in range <0, 100> 

if vt == 0
	error('true value equal to zero') ;
end
re = abs( (vt - vm) / vt ) * 100 ;