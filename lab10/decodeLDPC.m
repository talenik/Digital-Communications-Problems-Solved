function Xne = decodeLDPC( H, Zn0, nIter, verbose )
% Exercise 10.20: the min-sum algorithm LDPC decoder

if nargin < 4
	verbose = 0 ;
end

[ M, N ] = size( H ) ;

ZMN = zeros( M, N ) ;
LMN = zeros( M, N ) ;

% Exercise 10.20a - Zmn buffer initialization
for m = 1 : M
	Nm	= ( H( m, : ) == 1 ) ;	%indices N(m) - using logical indices
	ZMN( m, Nm ) = Zn0( Nm ) ;		
end

dbg( verbose, 'ZMN', ZMN )
NH = logical( ~H ) ;

for k = 1 : nIter

	% run horizontal scan sequentially for each row
	for m = 1 : M
		% Exercise 10.20b - find linear indices N(m) for row m
		Nm	= find( H( m, : ) == 1 ) ;		
		LMN( m, : ) = horizontal( N, Nm, ZMN( m, : ) ) ;
	end
	
	dbg( verbose, 'LMN', LMN )
	
	% Exercise 10.20d - update Zn(k) values eq. ( 10.43 )
	Znk = Zn0 + sum( LMN ) ;
	
	dbg( verbose, 'Zn0', Zn0 )
	dbg( verbose, 'Znk', Znk )
	
	% Exercise 10.20e - update Zmn(k) values eq. ( 10.45 ) 
	for m = 1 : M
		ZMN( m, : ) = Znk - LMN( m, : )  ;		
	end
	ZMN( NH ) = 0 ;
	
	Xne = hardDecision( Znk ) ;

	dbg( verbose, 'ZMN', ZMN )
	dbg( verbose, 'Xne', Xne )

	% Exercise 10.20f - test orthogonality and return 
	if all( mod( H * Xne', 2 ) == 0 )
		return ;
	end
	
end

	disp('Decoding didnt converge successfully.') ;
end

function Lmn = horizontal( N, Nm, Zmn, verbose )

if nargin < 4
	verbose = 0 ;
end

%  Exercise 10.20c 
%  Implements equations (10.41) for one specific value of row index m
%
%	Nm	is row vector of indices N(m) - must use linear indices
%	Zmn is a row vector of values of Zn on positions N(m), filled by zeros 
%	Nma  is N(m)\n
%	Lmn is a row vector of check node m output LLRs
	Lmn = zeros( 1, N ) ;
	
	for n = Nm

		Nma		= Nm( Nm ~= n ) ;
		Zmna	= Zmn( Nma ) ;
		s		= prod( sign( Zmna ) ) ;
		m		= min( abs( Zmna ) ) ;
		
		Lmn( n ) = s * m ;	
		
		dbg( verbose, 'Nma', Nma )
		dbg( verbose, 'Zmna', Zmna )
		dbg( verbose, 'Lmn(n)', Lmn( n ) )
	end
end

	
	