function Combinations = findGF2Combinations( n, k )

xInd			= nchoosek( [ 1 : n ], k ) ;
rows			= size( xInd, 1 ) ;
yInd			= repmat( [ 1 : rows ]', 1, k ) ; 
linearIndex		= sub2ind( [ rows n ], yInd, xInd ) ;

Combinations	= zeros( rows, n ) ;
Combinations( linearIndex ) = 1 ;