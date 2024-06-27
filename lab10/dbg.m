function dbg( flag, name, variable)
	
	if nargin < 3
		if flag
			disp( name )
		end
	else
		if flag
			disp( [ name ' = '] ) 
			disp( num2str( variable ) )
		end
	end