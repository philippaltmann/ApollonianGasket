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
  % Generate Mutually Tangent Circles from given Triangle
  tangent((X1, Y1), (X2, Y2), (X3, Y3), Base),
  % Generate Gasket for given Depth based on Tangent Circles
  gasket( Base, Depth, Gasket ),
  cors_enable, reply_json(Gasket, []).
