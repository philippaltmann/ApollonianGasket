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
    new(P, dialog),			% create dialog panel

	send(P, above, W),		% put panel below drawing-area
    send(W, display,
        new(@ci, circle(100)), point(25, 25)),
    send(W, display,
        new(@cj, circle(50)), point(125, 50)),
    send(W, display,
        new(@ck, circle(50)), point(107, 97)),

    send(@ci, fill_pattern, colour(blue)),
    send(@cj, fill_pattern, colour(green)),
    send(@ck, fill_pattern, colour(orange)),

    send(P, append, button(box, message(@prolog, add_box, P))),
	send(P, append, button(ellipse, message(@prolog, add_ellipse, P))),
	send(P, append, button(quit, message(P, destroy))),

    send(W, open).


layoutdemo1 :-
    new(D, dialog('Layout Demo 1')),
    send(D, append,
    new(BTS, dialog_group(buttons, group))),
    send(BTS, gap, size(0, 30)),
    send(BTS, append, button(add)),
    send(BTS, append, button(rename), below),
    send(BTS, append, button(delete), below),
    send(BTS, layout_dialog),
    send(D, append, new(LB, list_browser), right),
    send(D, append, new(TI, text_item(name, ’’))),
    send(LB, alignment, left),
    send(D, layout),
    send(LB, bottom_side, BTS?bottom_side),
    send(LB, right_side, TI?right_side),
    send(D, open).