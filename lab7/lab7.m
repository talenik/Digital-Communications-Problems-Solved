clc ;
clear ;
format compact ;
path( [ '..' filesep 'lab4' ], path ) ;

%% Example: Naive attempt to evaluate AWGN properties
n = 20 ;
s = randn( n, 1 ) ;
S = fft( s ) ;
SM = abs( S ) ;


[ r, lr ] = xcorr( s ) ;
%[ r2, l2] = xcor( s ) ;
[ r, lr ] = xcov( s ) ;

R = fft( r ) ;

h = figure( 'Color', 'w' ) ;


subplot( 2, 2, 1 ) ;
plot( s ) ;
subplot( 2, 2, 2 ) ;
plot( abs( S ) ) ;
subplot( 2, 2, 3 ) ;
plot( r ) ;
subplot( 2, 2, 4 ) ;
plot( abs( R ) ) ;


% discrete

h = figure( 'Color', 'w' ) ;
subplot( 2, 2, 1 ) ;
stem( s ) ;
subplot( 2, 2, 2 ) ;
stem( abs( S ) ) ;
subplot( 2, 2, 3 ) ;
stem( r ) ;
subplot( 2, 2, 4 ) ;
stem( abs( R ) ) ;


%% Exercise 7.1

M = 5 ;
N = 10 ;

m = 8 ;
v = 3 ;

Rn = random( [ M N ], m, v ) ;

% Calculate the sample mean and variance of all pseudo random matrices:

%a) for each column 
Mna = mean( Rn )
Vna = var( Rn )

%b) for each row
Mna = mean( Rn, 2 )
Vna = var( Rn, 0, 2 )

%c) for the whole matrix
Mnc = mean( Rn, 'all' ) 
Vnc = var( Rn, 0, 'all' )


%% Exercise 7.2:
% Generate a pseudo random column vector V of varying length N
% and constant mean and variance m = 10, v = 3.
% For each vector length N calculate sample mean ms and variance vs
% and for each calculated ms and vs calculate thei relative errors in %.
% Run this section several times to observe slightly different results each
% time.

m = 10	%desired mean 
v = 3	%desired variance

for N = [1 2 5 10.^[1:5]]
	V	= random( [ N 1 ], m , v ) ;
	sm	= mean( V ) ;
	sv	= var( V ) ;
	me	= 100 * abs(sm - m) / m ;
	ve  = 100 * abs(sv - v) / v ;

	fprintf(" N: %6d, mean: %10.6f, var: %10.6f, mean err: %10.6f%%, var err: %10.6f%% \n", N, sm, sv, me, ve ) ;
end

%% Exercise 7.3: Sample mean and sample variance: 
%  estimating Gaussian random process moments by averaging over enseble

h = figure('Name','Ensemble averaging over:','NumberTitle','off', 'Color', 'w')

% n - number of time samples per realization
% s - number of realisations - ensemble size
n = 100 ;

Nf = 4 ;
for f = [ 1 : Nf ]
	s = 10 .^ f 
	%each column is a single realization of Gaussian process
	%Noise matrix contains an ensemble or realizations - columns
	RN = random( [ n s ] ) ;
	
	%estimate mean signal
	Me		= mean( RN, 2 ) ;		%should be nearing 0 with larger s
	%estimate signal variance - should be one
	Ve		= var( RN, 0, 2 ) ;	%should be nearing 0 with larger s
	whos Data Me Ve
	signals = [ zeros( n, 1 ) ones( n, 1 ) Me Ve ] ;
	
	%assuming first index for plot is zero
	x = [ 0 : 1 : size( signals, 1 ) - 1 ] ;
	
	subplot( 2, 2, f ) ;

	plotSignals( h, 'plot', signals, x, 'rkbr' ) ;
	title( [ num2str( s ) ' realizations' ] ) ;
	xlabel( [ 'time index [n]' ] ) ;
end

set(h, 'Position',[ 800 100 1100 1000 ]) ;

%% Exercise 7.4: Sample mean and sample variance of a random vector 
%  estimating Gaussian random process moments by averaging over enseble
close all ;


% n - number of time samples per realization
% s - number of realisations - ensemble size
n = 10 ;

right = 0 ;
h = figure('Color', 'w' ) ;
for f = [ 3 4 ]		%or 3 4
	s = 10 .^ f 
	%each column is a set of samples belonging to a random vector component
	RN = random( [ s n ] ) ;
	
	%estimate mean signal
	Me		= mean( RN ) ;		%should be nearing 0 with larger s
	%estimate signal variance - should be one
	Ve		= var( RN ) ;		%should be nearing 0 with larger s
	
	
	subplot( 3, 2, 1 + right ) ;
	customPlot( Me, 'disc' ) ;
	title( ['means - autoscale' ] ) ;
	xlabel( [ 'X[j]' ] ) ;

	subplot( 3, 2, 3 + right ) ;
	customPlot( Ve, 'disc' ) ;
	title( ['variances - autoscale' ] ) ;
	xlabel( [ 'X[j]' ] ) ;

	subplot( 3, 2 ,5 + right ) ;
	customPlot( Ve, 'disc' ) ;
	hold on ;
	customPlot( Me, 'disc' ) ;
	grid on ;
	title( ['means and variances - in scale' ] ) ;
	xlabel( [ 'X[j]' ] ) ;

	right = right + 1 ;
end

%% Exercise 7.7: Autocorrelation function estimate

n	= 100 	% time samples
Nf	= 4 ;	% charts to draw

f1 = figure('Name','Averaged autocorrelation:','NumberTitle','off', 'Color', 'w') ;

for f = [ 0 : Nf - 1 ]
	
	s = 10 ^ f  
	%each column is a single realization of AWGN process
	%Noise matrix contains an ensemble or realizations - columns
	Noise = random( [ n s ] ) ;
	
	%autocorrelation realisations
	[ RaE, lags ]	= excor( Noise, Noise ) ;

	RaeMean			= mean( RaE, 2 ) ;

	subplot( 2, 2, f + 1 ) ;
	plotSignals( f1, 'plot', RaeMean, lags ) ;
	title( [ num2str( s ) ' realizations' ] ) ;
	xlabel( [ 'm' ] ) ;
end


%% Exercise 7.8: PSD estimate

n	= 128 ;	% time samples
Nf	= 4 ;	% charts to draw

f2 = figure('Name','PSD:','NumberTitle','off', 'Color', 'w') ;

for f = [ 0 : Nf - 1 ]
	
	s = 10 ^ f ; 
	%each column is a single realization of AWGN process
	%Noise matrix contains an ensemble or realizations - columns
	Noise = random( [ n s ] ) ;
	
	%autocorrelation realisations

	[ RaE, lags ]	= excor( Noise, Noise ) ;

	PSDrealisations	= fft( RaE, n, 1 ) ;
	PSDest1			= mean( PSDrealisations, 2 ) ;
	
	RaeMean			= mean( RaE, 2 ) ;
	PSDest2			= fft( RaeMean, n ) ;

	[ e, dh, de ] = equals( PSDest1, PSDest2 )  

	whos

	subplot( 2, 2, f + 1 ) ;
	plotSignals( f2, 'plot', abs( PSDest2 ) ) ;
	title( [ num2str( s ) ' realizations' ] ) ;
	xlabel( [ 'frequency [k]' ] ) ;
	ylim([0 3*n])
end



