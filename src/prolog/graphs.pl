:- use_module(library(pce)).
:- use_module(library(plot/barchart)).
:- use_module(library(autowin)).

:- consult(triangle).
:- consult(apollonian).

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
    new(P, dialog),			% create dialog panel
	send(P, above, W),		% put panel below drawing-area

    % Make circles tangent
    tangent((25, 25), (125, 50), (107, 97), [[_, _, R1], [_, _, R2], [_, _, R3]]),

    % Starting circles
    send(W, display,
        new(@ci, circle(R1)), point(25, 25)),
    send(W, display,
        new(@cj, circle(R2)), point(125, 50)),
    send(W, display,
        new(@ck, circle(R3)), point(107, 97)),
    

    % Descartes
    descartes(R1, R2, R3, RI, RO),
    

    % Generate outer circle
    outer(triangle(point(25, 25), point(125, 50), point(107, 97)), XB, YB, R4),
    send(W, display,
        new(@cb, circle(R4)), point(XB-12, YB-48)),

    % Get center of circle
    flip([25, 25, 100], [125, 50, 50], [107, 97, 50], [5, 35, 53], [X5, Y5, R5]),
    send(W, display,
        new(@cz, circle(R5)), point(X5, Y5+16)),

    send(@ci, fill_pattern, colour(blue)),
    send(@cj, fill_pattern, colour(green)),
    send(@ck, fill_pattern, colour(orange)),

	send(P, append, button(quit, message(W, destroy))),


    send(W, open).