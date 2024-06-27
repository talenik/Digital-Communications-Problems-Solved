clear ;
clc ;
format compact ;


%% Exercise 1.3.1 ----------------------------------------------------
A = round( 1 + 9 .* rand( 4 ) );
b = round( 1 + 2 .* rand( 4,1 ) )
c = round( 3 + 3 .* rand( 4,1 ) )
d = round( 6 + 3 .* rand( 4,1 ) )

B = A * b ;
C = A * c ;
D = A * d ;

F = [ B C D ]
e = [ b c d ]

ok = isequal( A * e, F )  %  e * A cannot multiply

%% Exercise 1.3.2 ----------------------------------------------------

A11 = ones( 3, 4 )
A12 = 2 * ones( 3,2 )
A21 = 3 * ones( 2,4 )
A22 = 4 * ones( 2 )

B11 = 5 * ones( 4, 3 )
B21 = 6 * ones( 2, 3 )

A = [ A11 A12 ; A21 A22 ]
B = [ B11 ; B21 ]

C = A * B

C11 = A11 * B11 + A12 * B21
C21 = A21 * B11 + A22 * B21

C2 = [ C11 ; C21 ]

ok = isequal( C, C2 )

%% Exercise 1.3.3: implement the body of function deToBi() in a separate .m file

%use this section as a unit test
for d = [ 0 : 15 ]
	b = deToBi( d, 4 )
end


%% Exercise 1.3.4: implement the body of function generateAllBinaryWords( k ) in a separate .m file

Words = generateAllBinaryWords( 3 )
Words = generateAllBinaryWords( 4 )


