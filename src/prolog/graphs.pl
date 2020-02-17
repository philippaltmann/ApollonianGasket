:- use_module(library(pce)).
:- use_module(library(plot/barchart)).
:- use_module(library(autowin)).
:- consult(triangle).

%test_barchart :-
    %new(W, picture),
    %send(W, display, new(BC, bar_chart(vertical,0,200))),
    %forall(member(Name/Height/Color,
    %          [x/100/red, y/150/green, z/80/blue, v/50/yellow]),
    %       (   new(B, bar(Name, Height)),
    %           send(B, colour(Color)),
    %           send(BC, append, B)
    %       )),
    %send(W, open).

graph :-
    new(W, picture('Apollonian Gasket')),
    send(W, display,
        new(@ci, circle(100)), point(25, 25)),
    send(W, display,
        new(@cj, circle(50)), point(125, 50)),
    send(W, display,
        new(@ck, circle(50)), point(107, 97)),

    send(@ci, fill_pattern, colour(blue)),
    send(@cj, fill_pattern, colour(green)),
    send(@ck, fill_pattern, colour(orange)),
    send(W, open).
