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

point(X, Y) :- X >= 0, Y >= 0. %ID type check

triangle(point(XA, YA), point(XB, YB), point(XC, YC)) :-
  point(XA, YA) \= point(XB, YB),
  point(XA, YA) \= point(XC, YC),
  point(XB, YB) \= point(XC, YC).

distance(point(X1, Y1), point(X2, Y2), D) :-
  D is sqrt((X2-X1)^2 + (Y2-Y1)^2).

sides(triangle(point(XA, YA), point(XB, YB), point(XC, YC)), DA, DB, DC) :-
  DA is sqrt((XB-XC)^2 + (YB-YC)^2),
  DB is sqrt((XA-XC)^2 + (YA-YC)^2),
  DC is sqrt((XA-XB)^2 + (YA-YB)^2).

circles(triangle(point(XA, YA), point(XB, YB), point(XC, YC)), RA, RB, RC) :-
  sides(triangle(point(XA, YA), point(XB, YB), point(XC, YC)), A, B, C),
  RA is 1/2*(-A+B+C),
  RB is 1/2*( A-B+C),
  RC is 1/2*( A+B-C).


% circles
