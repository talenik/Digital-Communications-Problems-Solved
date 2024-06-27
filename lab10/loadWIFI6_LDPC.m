function code = loadWIFI6_LDPC( R, n )
	
	Ks = [ 324 432 486 540 648 864 972 1080 1296 1458 1620 ] ;
	Rs = [ 1/2 2/3 3/4 5/6 ] ;
	Ns = [ 648 1296 1944] ;

	k  = round( n * R ) ;
	ri = getIndex( Rs, R, 'R' ) ;
	ki = getIndex( Ks, k, 'k' ) ;
	ni = getIndex( Ns, n, 'n' ) ;

	[ Hbm, z ] = IEEE80211_code( ri, ni ) ;
	
	code.N			= n ;
	code.K			= k ;
	code.M			= n - k ;
	code.Nb			= 24 ;
	code.Mb			= code.M / z ;
	code.R			= R ;

	code.Hbm		= Hbm ; 
	code.z			= z ;

end

function [ Hbm, Z ] = IEEE80211_code( ri, ni )
	IEEE80211_2020_LDPC ;
	HN	= H_IEEE80211{ ni } ;
	Hbm = HN{ ri } ;
	Z	= Z_IEEE80211( ni ) ;
end


function i = getIndex( haystack, needle, label )

	if nargin == 2
		label = 'value' ;
	end

	i = find( haystack == needle, 1 ) ;
	if isempty( i )
		error( [ 'Unsupported ' label ] ) ;
	end
end