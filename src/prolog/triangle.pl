%:- op(1200, xfx, --->).

% point(ID, X, Y) :- X >= 0, Y >= 0. %ID type check
%
%
% triangle(ID, P1, P2, P3) :-
%   point(P1, AX, AY), point(P2, BX, BY), point(P3, CX, CY).

% sides(Triangle, A, B, C, D1, D2, D3):-
%   triangle(Triangle, A, B, C), point(A, AX, AY), point(B, BX, BY), point(C, CX, CY),
%   distance()


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
