:- use_module(library(http/http_server)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_json)).

:- consult(apollonian).
:- set_setting(http:cors, [*]).

:- initialization http_server([port(8008)]).
:- http_handler(root(gasket), handle_gasket, [ get ]).

handle_gasket(Request) :-
  http_parameters(Request, [
    depth(Depth, [number]), x1(X1, [float]), y1(Y1, [float]),
    x2(X2, [float]), y2(Y2, [float]), x3(X3, [float]), y3(Y3, [float])
  ]),
  basis((X1, Y1, R1), (X2, Y2, R2), (X3, Y3, R3)),
  gasket((X1, Y1, R1), (X2, Y2, R2), (X3, Y3, R3), Depth, Gasket),
  append([[X1, Y1, R1], [X2, Y2, R2], [X3, Y3, R3]], Gasket, Result),
  cors_enable, reply_json(Result, []).
