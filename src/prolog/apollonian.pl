% List Handling
append([], X, X).
append([H|T], X, [H|S]) :- append(T, X, S).


% Triangular Math -> Base Circles from Triangle
sides(((XA, YA), (XB, YB), (XC, YC)), DA, DB, DC) :-
  DA is sqrt((XB-XC)^2 + (YB-YC)^2),
  DB is sqrt((XA-XC)^2 + (YA-YC)^2),
  DC is sqrt((XA-XB)^2 + (YA-YB)^2).

basis(triangle((XA, YA), (XB, YB), (XC, YC)), [[XA, YA, RA], [XB, YB, RB], [XC, YC, RC]]):-
  sides(((XA, YA), (XB, YB), (XC, YC)), A, B, C),
  RA is 1/2*(-A+B+C),
  RB is 1/2*( A-B+C),
  RC is 1/2*( A+B-C).

basis((XA, YA, RA), (XB, YB, RB), (XC, YC, RC)):-
  sides(((XA, YA), (XB, YB), (XC, YC)), A, B, C),
  RA is 1/2*(-A+B+C),
  RB is 1/2*( A-B+C),
  RC is 1/2*( A+B-C).


% Complex Numbers
sum([], (0, 0)).
sum([(CurR, CurI)|Tail], (SumR, SumI)) :-
   sum(Tail, (RestR, RestI)),
   SumR is CurR + RestR, SumI is CurI + RestI.

sub((R1, C1), (R2, C2), (R, C)) :- R is R1 - R2, C is C1 - C2.

mul((R1, C1), (R2, C2), (R, C)) :-
    R is (R1 * R2 - C1 * C2), C is (C1 * R2 + R1 * C2).

div((A,B), (C,D), (E,F)) :-
    C2 is C**2, D2 is D**2,
    E is (A*C + B*D) / (C2 + D2),
    F is (B*C - A*D) / (C2 + D2).

sqrt((X, Y), (R, C)) :-
  SQX2Y2 is sqrt(X**2 + Y**2),
  R is sqrt((SQX2Y2+X)/2),
  C is sqrt((SQX2Y2-X)/2).

solve(C1, C2, C3, S) :-
  % "When trying to find the radius of a fourth circle tangent to
  % three given kissing circles,  the equation is best rewritten as:"
  % https://en.wikipedia.org/wiki/Descartes%27_theorem
  % k1 + k2 + k3 + (2 * sqrt(k1 * k2 + k2 * k3 + k1 * k3))
  mul(C1, C2, P12), mul(C1, C3, P13), mul(C2, C3, P23), %C1*C2 | C1*C3 | C2*C3
  sum([P12, P13, P23], SP), sqrt(SP, SQ), % P12 + P13 + P23 | sqrt()
  mul(SQ, (2,0), SQ2), sum([C1, C2, C3, SQ2], S).


% adjacent((200, 200, -200), (100, 200, 100), (300, 200, 100), C4).
adjacent((X1, Y1, R1), (X2, Y2, R2), (X3, Y3, R3), (X4, Y4, R4)) :-
  % Calculagte Bends and solve for 4th Radius using Descartes
  B1 is 1/R1, B2 is 1/R2, B3 is 1/R3, % calculate bends
  solve((B1, 0), (B2, 0), (B3, 0), (B4,_)), R4 is 1/B4, %if not working -> abs(1/B4)
  % Calculate Relaitive Centers to Solve Descartes Equation
  solve((X1*B1, Y1*B1), (X2*B2, Y2*B2), (X3*B3, Y3*B3), BC4),
  div(BC4, (B4, 0), (X4, Y4)).

flip((X1, Y1, R1), (X2, Y2, R2), (X3, Y3, R3), (X4, Y4, R4), (X5, Y5, R5)) :-
  % "So if we already have one value for b_4, we can just subtract it from
  % double the sum of the other three bends to find the second value of b_4."
	% https://mathlesstraveled.com/2016/05/04/apollonian-gaskets-and-descartes-theorem/
  B1 is 1/R1, B2 is 1/R2, B3 is 1/R3, B4 is 1/R4, % calculate bends
  B5 is 2 * (B1 + B2 + B3) - B4, R5 is 1/B5,

  % "For each operation we compute the same formula twice, once for the bends and once
  % for the bend-center products. To recover the center of a circle, just divide the
  % bend-center product by the bend. And voila!"
  % https://mathlesstraveled.com/2016/06/10/apollonian-gaskets-and-descartes-theorem-ii/
  sum([(X1*B1, Y1*B1), (X2*B2, Y2*B2), (X3*B3, Y3*B3)], S), mul(S, (2,0), S2),
  sub(S2, ((X4*B4, Y4*B4)), S2Sub), div(S2Sub, (B5, 0), (X5, Y5)).

gasket(_, _, _, 0, []).

gasket(C1, C2, C3, Depth, [[XI, YI, RI], [XO, YO, RO]|Tail ]) :-
  adjacent(C1, C2, C3, (XI, YI, RI)), flip(C1, C2, C3, (XI, YI, RI), (XO, YO, RO)),
  DepthN is Depth - 1,
  recurse(C1, C2, C3, (XI, YI, RI), InnerRecurse, DepthN), % Further Inner Circles
  recurse(C1, C2, C3, (XO, YO, RO), OuterRecurse, DepthN), % Further Outer Circles
  append(InnerRecurse, OuterRecurse, Tail).

% Recursion Break Condition
recurse( _, _, _, _, [], 0).

% CO: Fixed Circle
recurse(C1, C2, C3, CO, [ [X5, Y5, R5], [X6, Y6, R6], [X7, Y7, R7]|Tail ], Depth) :-
  DepthN is Depth - 1,
  flip(CO, C1, C2, C3, (X5, Y5, R5)),
  flip(CO, C1, C3, C2, (X6, Y6, R6)),
  flip(CO, C2, C3, C1, (X7, Y7, R7)), !,
  recurse(C1, C2, CO, (X5, Y5, R5), Rec1, DepthN),
  recurse(C1, C3, CO, (X6, Y6, R6), Rec2, DepthN),
  recurse(C2, C3, CO, (X7, Y7, R7), Rec3, DepthN),
  append(Rec1, Rec2, PreTail),
  append(PreTail, Rec3, Tail).

loop_through_list(File, [Head|[]]) :- write(File, Head).
loop_through_list(File, [Head|Tail]) :-
    write(File, Head), write(File, ', '),
    loop_through_list(File, Tail).

writeGasket(C1, C2, C3, Depth, Filename) :-
  gasket(C1, C2, C3, Depth, G),
  open(Filename, write, File),
  write(File, '{ "gasket": [ '),
  loop_through_list(File, G),
  write(File, ' ] }'),
  close(File).
