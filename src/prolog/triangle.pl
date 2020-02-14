%:- op(1200, xfx, --->).

% point(ID, X, Y) :- X >= 0, Y >= 0. %ID type check
%
%
% triangle(ID, P1, P2, P3) :-
%   point(P1, AX, AY), point(P2, BX, BY), point(P3, CX, CY).

% sides(Triangle, A, B, C, D1, D2, D3):-
%   triangle(Triangle, A, B, C), point(A, AX, AY), point(B, BX, BY), point(C, CX, CY),
%   distance()

% Complex numbers
% pack_install(plcomplex).

% distance(A, B, D) :-
%   point(A, X1, Y1),
%   point(B, X2, Y2),
%   D is sqrt((X2-X1)^2 + (Y2-Y1)^2).

% triangle()
% point(a,5,2).
% point(b,4,0).
% point(c,2,3).
% point(d,5,2).

% point(ID, X, Y)
%
% % P1 :- point("P1", 1, 1).
% point("P2", 2, 1).
% point("P3", 3, 1).
%
% let P1 = point(1,1)
%
% T1 = triangle(P1, P2, P3)
%
% Gasket(T1, C)
% C=[circle,...]

point(X, Y) :- number(X), number(Y), X >= 0, Y >= 0. %ID type check

%number(X), number(Y), X >= 0, Y >= 0 ---> point(X,Y).

% circle(point(X,Y), R) :-

triangle(point(XA, YA), point(XB, YB), point(XC, YC)) :-
  point(XA,YA), point(XB, YB), point(XC, YC),
  point(XA, YA) \= point(XB, YB),
  point(XA, YA) \= point(XC, YC),
  point(XB, YB) \= point(XC, YC).

% distance(point(X1, Y1), point(X2, Y2), D) :-
%   D is sqrt((X2-X1)^2 + (Y2-Y1)^2).

sides(triangle(point(XA, YA), point(XB, YB), point(XC, YC)), DA, DB, DC) :-
  triangle(point(XA, YA), point(XB, YB), point(XC, YC)),
  DA is sqrt((XB-XC)^2 + (YB-YC)^2),
  DB is sqrt((XA-XC)^2 + (YA-YC)^2),
  DC is sqrt((XA-XB)^2 + (YA-YB)^2).

circles(triangle(point(XA, YA), point(XB, YB), point(XC, YC)), RA, RB, RC) :-
  sides(triangle(point(XA, YA), point(XB, YB), point(XC, YC)), A, B, C),
  RA is 1/2*(-A+B+C),
  RB is 1/2*( A-B+C),
  RC is 1/2*( A+B-C).


descartes(R1, R2, R3, RI, RO) :-
  K1 is 1/R1, % todo +/-
  K2 is 1/R2,
  K3 is 1/R3,
  KI is (K1 + K2 + K3 + 2*sqrt(K1*K2 + K2*K3 + K3*K1)),
  KO is (K1 + K2 + K3 - 2*sqrt(K1*K2 + K2*K3 + K3*K1)),
  RI is abs(1/KI),
  RO is abs(1/KO).

% special case: third circle becomes a line
descartes(R1, R2, RI, RO) :-
    K1 is (1 / R1),
    K2 is (1 / R2),
    KI is K1 + K2 + 2 * sqrt(K1 * K2),
    KO is K1 + K2 - 2 * sqrt(K1 * K2),
    RI is (1 / KI),
    RO is (1 / K0).


% Calculate Outer Circle for triangle
% todo circle(point(X,Y), R)
% outer(triangle(point(1, 1), point(3, 1), point(2, 3)), X, Y, R).
outer(triangle(point(XA, YA), point(XB, YB), point(XC, YC)), X, Y, R):-
  sides(triangle(point(XA, YA), point(XB, YB), point(XC, YC)), A, B, C),
  S is 1/2*(A+B+C),
  Delta is sqrt(S*(S-A)*(S-B)*(S-C)), % Herons Formula,
  U is A - (Delta/(S - A)),
  V is B - (Delta/(S - B)),
  W is C - (Delta/(S - C)),
  R1 is 1/2*(-A+B+C),
  R2 is 1/2*( A-B+C),
  R3 is 1/2*( A+B-C),
  descartes(R1, R2, R3, _, R),
  X is (U*XA + V*XB + W*XC) / (U+V+W),
  Y is (U*YA + V*YB + W*YC) / (U+V+W).

% Calculate Inner Circle for triangle
% todo circle(point(X,Y), R)
% inner(triangle(point(1, 1), point(3, 1), point(2, 3)), X, Y, R).
inner(triangle(point(XA, YA), point(XB, YB), point(XC, YC)), X, Y, R):-
  sides(triangle(point(XA, YA), point(XB, YB), point(XC, YC)), A, B, C),
  S is 1/2*(A+B+C),
  Delta is sqrt(S*(S-A)*(S-B)*(S-C)), % Herons Formula,
  U is A + (Delta/(S - A)),
  V is B + (Delta/(S - B)),
  W is C + (Delta/(S - C)),
  R1 is 1/2*(-A+B+C),
  R2 is 1/2*( A-B+C),
  R3 is 1/2*( A+B-C),
  descartes(R1, R2, R3, R, _),
  X is (U*XA + V*XB + W*XC) / (U+V+W),
  Y is (U*YA + V*YB + W*YC) / (U+V+W).

% gasket(triangle(point(1, 1), point(3, 1), point(2, 3)).
gasket(triangle(point(XA, YA), point(XB, YB), point(XC, YC))):-
  % circles(triangle(point(XA, YA), point(XB, YB), point(XC, YC)), RA, RB, RC),
  inner(triangle(point(XA, YA), point(XB, YB), point(XC, YC)), XI, YI, RI),
  outer(triangle(point(XA, YA), point(XB, YB), point(XC, YC)), XO, YO, RI),
  gasket(triangle(point(XA, YA), point(XB, YB), point(XI, YI))),
  gasket(triangle(point(XA, YA), point(XC, YC), point(XI, YI))),
  gasket(triangle(point(XB, YB), point(XC, YC), point(XI, YI))),
  gasket(triangle(point(XA, YA), point(XB, YB), point(XO, YO))),
  gasket(triangle(point(XA, YA), point(XC, YC), point(XO, YO))),
  gasket(triangle(point(XB, YB), point(XC, YC), point(XO, YO))).

% circles
% calculate an alternative circle from four others
recursive(C1, C2, C3, C4, Depth, MaxDepth) :-
  Depth == MaxDepth, !.

recursive(C1, C2, C3, C4, Depth, MaxDepth) :-
    ( Depth == 0
      -> CN1 is vieta(C1, C2, C3, C4),
      recursive(Temp, C2, C3, C4,), 1, MaxDepth,
      CN2 is vieta(C2, C1, C3, C4),
      CN3 is vieta(C3, C1, C2, C4),
      CN4 is vieta(C4, C1, C2, C3),

      recursive((CN2, C1, C3, C4), Depth+1, MaxDepth),
      recursive((CN3, C1, C2, C4), Depth+1, MaxDepth),
      recursive((CN4, C1, C2, C3), Depth+1, MaxDepth).
    ).

% Alternative fourth curvature from the previous four
vieta(R1, R2, R3, R4, K1N, Z1N) :-
  Z1N is (2 * (R2 + R3 + R4) - R1) / K1N

% four circles touch, calculate alternative one touching last three cirlces
% F: touches three circles (C1, C2, C3, C4), except the alternative one
vieta(F, R1, R2, R3, NewCircle) :-
  CF = 1/F,
  C1 = 1/R1, % 1/R to get curvature
  C2 = 1/R2,
  C3 = 1/R3,
  KN = 2 * (C1 + C2 + C3) - CF,
  MN = (2 * (C1 + C2 + C3) - CF) / KN)),
  NewCircle is circle(MN, complex(MN), 1/curn). % Complex number module missing

% M1 is (X + Y * J)
% X: x center coord
% Y: y center coord
% J: Complex Number
