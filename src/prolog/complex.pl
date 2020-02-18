:-module(complex,[
             set_default_is/3,
             op(700,xfx,iis),
             iis/2,
             op(700,xfx,c_equals),
             c_equals/2,
             complex_canonical/3,
             is_canonical/3,
             complex_exponential/3,
             is_exponential/3,
             complex_number/1
         ]).
:-op(700,xfx,iis).
:-op(700,xfx,c_equals).

:-dynamic a_default_is/3.
a_default_is(is(A,B),A,B).

set_default_is(F,A,B):-
    retractall(a_default_is(_,_,_)),
    asserta(a_default_is(F,A,B)).

default_is(A,B):-
    a_default_is(C,A,B),
    call(C).


(_ iis Y):-
    \+ ground(Y),
    throw(error(instantiation_error, context(complex:(iis)/2, _))).

(X iis Y):-
    catch(default_is(Z,Y),_,(!,fail)),!,
    X = Z.

(R+I*i iis X):-
    complex_canonical(X,R,I),!.


(M iis abs(Z)):-
    ZZ iis Z,
    complex_exponential(ZZ,M,_),!.

(F iis phase(Z)):-
    ZZ iis Z,
    complex_exponential(ZZ,_,F),!.

(R iis real(Z)):-
    ZZ iis Z,
    complex_canonical(ZZ,R,_),!.

(I iis imaginary(Z)):-
    ZZ iis Z,
    complex_canonical(ZZ,_,I),!.

(R-I*i iis conjugate(Z)):-
    ZZ iis Z,
    complex_canonical(ZZ,R,I),!.

(X iis reciprocal(Z)):-
    ZZ iis Z,
    complex_canonical(ZZ,R,I),
    default_is(S,R*R+I*I),
    X iis R/S + I/S*i,!.

(X iis sqrt(Z)):-!,
    X iis Z**0.5.

(X iis exp(Z)):-
    ZZ iis Z,
    complex_canonical(ZZ,R,I),
    X iis exp(R)*cos(I) + exp(R)*sin(I)*i,!.

(X iis sin(Z)):-
    ZZ iis Z,
    complex_canonical(ZZ,R,I),
    X iis sin(R)*cosh(I) + cos(R)*sinh(I)*i,!.

(X iis cos(Z)):-
    ZZ iis Z,
    complex_canonical(ZZ,R,I),
    X iis cos(R)*cosh(I) + sin(R)*sinh(I)*i,!.

(X iis tan(Z)):-
    ZZ iis Z,
    complex_number(ZZ),
    X iis sin(ZZ)/cos(ZZ),!.

(X iis ctan(Z)):-
    ZZ iis Z,
    complex_number(ZZ),
    X iis cos(ZZ)/sin(ZZ),!.

(i iis i):-!.

(-1 iis i*i):-!.

(0 iis 0*i):-!.

(0 iis 0.0*i):-!.

(i iis 1*i):-!.

(i iis 1.0*i):-!.

(-1 iis e**(i*pi)):-!.

(-1 iis e**(pi*i)):-!.

(AA*i iis A*i):-
    number(A),!,
    AA=A.

(0 iis O1+O2*i):-
    zero(O1),
    zero(O2),!.
(0 iis O1-O2*i):-
    zero(O1),
    zero(O2),!.

(R iis R+O*i):-
    number(R),
    zero(O),!.
(I*i iis O+I*i):-
    number(I),
    zero(O),!.
(II*i iis O-I*i):-
    number(I),
    zero(O),!,
    default_is(II,-I).

(R-II*i iis R+I*i):-
    number(R),
    number(I),
    I<0,!,
    default_is(II,-I).

(R+II*i iis R-I*i):-
    number(R),
    number(I),
    I<0,!,
    default_is(II,-I).


(R iis R-I*i + I*i):-!.

(RR+I*i iis A+Z):-
    number(A),
    complex_canonical(Z,R,I),!,
    default_is(RR,A+R).

(X*i iis A*i + B*i):-
    number(A),
    number(B),!,
    default_is(X,A+B).

(R+X*i iis R-A*i + B*i):-
    number(R),
    number(A),
    number(B),!,
    default_is(X,B-A).

(RR+A*i iis B + R + A*i):-
    number(R),
    number(A),
    number(B),!,
    default_is(RR,R+B).


(RR+A*i iis B + (R + A*i)):-
    number(R),
    number(A),
    number(B),!,
    default_is(RR,R+B).

(R+X*i iis R+A*i + B*i):-
    number(R),
    number(A),
    number(B),!,
    default_is(X,A+B).

(RR+II*i iis Z1+Z2):-
    complex_canonical(Z1,R1,I1),
    complex_canonical(Z2,R2,I2),!,
    default_is(RR,R1+R2),
    default_is(II,I1+I2).

(X iis A+B):-
    AA iis A,
    BB iis B,
    complex_number(AA),
    complex_number(BB),!,
    XX iis AA+BB,
    X=XX.


(0 iis I*i - I*i):-
    number(I),!.

(I*i iis R+I*i - R):-!.

(R iis R+I*i - I*i):-!.

(I*i iis I1*i - I2*i):-
    number(I1),
    number(I2),!,
    default_is(I,I1-I2).

(R-X*i iis R-A*i - B*i):-
    number(R),
    number(A),
    number(B),!,
    default_is(X,A+B).

(R+X*i iis R+A*i - B*i):-
    number(R),
    number(A),
    number(B),!,
    default_is(X,A-B).


(RR+I*i iis Z-A):-
    number(A),
    complex_canonical(Z,R,I),!,
    default_is(RR,R-A).

(RR+II*i iis Z1-Z2):-
    complex_canonical(Z1,R1,I1),
    complex_canonical(Z2,R2,I2),!,
    default_is(RR,R1-R2),
    default_is(II,I1-I2).

(X iis A-B):-
    AA iis A,
    BB iis B,
    complex_number(AA),
    complex_number(BB),!,
    XX iis AA-BB,
    X=XX.

(A*i iis i*A):-
    number(A),!.

(-A iis A*i*i):-
    number(A),!.

(X iis A*i*B*i):-
    number(A),
    number(B),!,
    default_is(X,-A*B).

(I*i iis A*i*B):-
    number(A),
    number(B),!,
    default_is(I,A*B).

(C*exp(i*H) iis A*exp(i*F)*(B*exp(i*G))):-
    number(A),
    number(B),
    number(F),
    number(G),!,
    default_is(C,A*B),
    default_is(H,F+G).

(C*exp(i*H) iis A*exp(i*F)*B*exp(i*G)):-
    number(A),
    number(B),
    number(F),
    number(G),!,
    default_is(C,A*B),
    default_is(H,F+G).

(C*exp(i*G) iis A*(B*exp(i*G))):-
    number(A),
    number(B),
    number(G),!,
    default_is(C,A*B).

(C*exp(i*G) iis A*B*exp(i*G)):-
    number(A),
    number(B),
    number(G),!,
    default_is(C,A*B).


(RR+II*i iis A*Z):-
    number(A),
    complex_canonical(Z,R,I),!,
    default_is(RR,A*R),
    default_is(II,A*I).

(RR+II*i iis Z1*Z2):-
    complex_canonical(Z1,R1,I1),
    complex_canonical(Z2,R2,I2),!,
    default_is(RR,R1*R2 - I1*I2),
    default_is(II,R1*I2 + I1*R2).

(X iis A*B):-
    AA iis A,
    BB iis B,
    complex_number(AA),
    complex_number(BB),!,
    XX iis AA*BB,
    X=XX.

(1 iis i/i):-!.
(C*i iis i/A):-
    number(A),!,
    default_is(C,1/A).
(C iis i/(A*i)):-
    number(A),!,
    default_is(C,1/A).
(A iis A*i/i):-
    number(A),!.
(C iis A*i/(B*i)):-
    number(A),
    number(B),!,
    default_is(C,A/B).
(C*i iis A*i/B):-
    number(A),
    number(B),!,
    default_is(C,A/B).


(RR+II*i iis A/B):-
    number(B),
    AA iis A,
    complex_canonical(AA,R,I),!,
    default_is(RR,R/B),
    default_is(II,I/B).

(X iis A/B):-
    complex_number(A),
    complex_number(B),
    X iis A*reciprocal(B),!.

(X iis A/B):-
    AA iis A,
    BB iis B,
    complex_number(AA),
    complex_number(BB),!,
    XX iis AA/BB,
    X=XX.

(W iis i**N):-
    integer(N),
    default_is(K,N mod 4),
    (   K=0,!,
        W=1
    ;   K=1,!,
        W=i
    ;   K=2,!,
        W= -1
    ;   K=3,!,
        W= -i
    ).

(exp(i*P) iis i**A):-
    number(A),!,
    default_is(P,pi*A/2).

(X iis -1**i):-!,
    default_is(X,exp(-pi)).
(X iis -1.0**i):-!,
    default_is(X,exp(-pi)).

(X iis A**i):-
    number(A),!,
    (   A>0,!,
        default_is(L,log(A)),
        X = exp(i*L)
    ;   A<0,!,
        default_is(L,log(-A)),
        default_is(M,exp(-pi)),
        X = M*exp(i*L)
    ;   X=0
    ).

(X iis Z**i):-
    complex_exponential(Z,M,P),!,
    default_is(A,e**(-P)),
    X iis A*M**i.

(exp(i*L) iis A**(B*i)):-
    number(A),
    number(B),!,
    catch(
        catch(
            default_is(L,log(A**B)),
            error(evaluation_error(float_overflow),_),
            L is B*log(A)
        ),
        error(evaluation_error(undefined), context(log/1, _)),
        (   A = 0,
            L = 0
        ;   L is log(A)
        )
    ).

(A*E iis Z**i):-
    complex_exponential(Z,M,P),!,
    default_is(A,e**(-P)),
    E iis M**i.


(AA*exp(i*PP) iis Z**N):-
    number(N),
    complex_exponential(Z,A,P),!,
    default_is(AA,A**N),
    default_is(PP,P*N).

(XX iis N**Z):-
    number(N),
    complex_canonical(Z,A,B),!,
    default_is(M,N**A),
    E iis N**(B*i),
    (   E = exp(_),
        XX = M*E
    ;   XX iis M*E
    ).

(X iis Z**Z2):-
    complex_exponential(Z,M,P),
    complex_canonical(Z2,A,B),!,
    default_is(MM,M**A),
    exp(P1) iis M**(B*i),
    P2 iis i*P*Z2,
    PP iis P1+P2,
    X iis MM*exp(PP).


(X iis N**Z):-
    number(N),
    complex_canonical(Z,R,I),!,
    default_is(A,N**R),
    B iis N**(I*i),
    X iis A*B.

(X iis A**B):-
    AA iis A,
    BB iis B,
    complex_number(AA),
    complex_number(BB),!,
    XX iis AA**BB,
    XX = X.

(X iis A^B):-
    X iis A ** B.

c_equals(A,B):-
    Z1 iis A,
    complex_canonical(Z1,R1,I1),
    Z2 iis B,
    complex_canonical(Z2,R2,I2),
    R1==R2,
    I1==I2.

complex_canonical(i,0,1):-!.
complex_canonical(-i,0,-1):-!.
complex_canonical(R,R,0):-
    number(R),!.
complex_canonical(I*i,0,I):-
    number(I),!.
complex_canonical(R+i,R,1):-
    number(R),!.
complex_canonical(R+I*i,R,I):-
    number(R),
    number(I),!.
complex_canonical(R-i,R,-1):-
    number(R),!.
complex_canonical(R-II*i,R,I):-
    number(R),
    number(II),!,
    default_is(I,-II).

complex_canonical(exp(i),R,I):-!,
    default_is(R,cos(1)),
    default_is(I,sin(1)).
complex_canonical(exp(i*F),R,I):-
    number(F),!,
    default_is(R,cos(F)),
    default_is(I,sin(F)).
complex_canonical(M*exp(i),R,I):-
    number(M),!,
    default_is(R,M*cos(1)),
    default_is(I,M*sin(1)).
complex_canonical(M*exp(i*F),R,I):-
    number(M),
    number(F),!,
    pol_rec(R,I,M,F).

complex_canonical(cos(F)+i*sin(F),R,I):-
    number(F),!,
    pol_rec(R,I,1,F).
complex_canonical(M*(cos(F)+i*sin(F)),R,I):-
    number(M),
    number(F),!,
    pol_rec(R,I,M,F).

is_canonical(i,0,1):-!.
is_canonical(-i,0,-1):-!.
is_canonical(R,R,0):-
    number(R),!.
is_canonical(I*i,0,I):-
    number(I),!.
is_canonical(R+i,R,1):-
    number(R),!.
is_canonical(R+I*i,R,I):-
    number(R),
    number(I),!.
is_canonical(R-i,R,-1):-
    number(R),!.
is_canonical(R-II*i,R,I):-
    number(R),
    number(II),!,
    default_is(I,-II).

complex_exponential(i,1,F):-!,
    default_is(F,pi/2).
complex_exponential(-i,-1,F):-!,
    default_is(F,pi/2).
complex_exponential(M,M,0):-
    number(M),!.
complex_exponential(M*i,M,F):-
    number(M),!,
    default_is(F,pi/2).
complex_exponential(R+i,M,F):-
    number(R),!,
    pol_rec(R,1,M,F).
complex_exponential(R+I*i,M,F):-
    number(R),
    number(I),!,
    pol_rec(R,I,M,F).
complex_exponential(R-i,M,F):-
    number(R),!,
    pol_rec(R,-1,M,F).
complex_exponential(R-I*i,M,F):-
    number(R),
    number(I),!,
    default_is(II,-I),
    pol_rec(R,II,M,F).

complex_exponential(exp(i),1,1):-!.
complex_exponential(exp(i*F),1,F):-
    number(F),!.
complex_exponential(M*exp(i),M,1):-
    number(M),!.
complex_exponential(M*exp(i*F),M,F):-
    number(M),
    number(F),!.

complex_exponential(cos(F)+i*sin(F),1,F):-
    number(F),!.
complex_exponential(M*(cos(F)+i*sin(F)),M,F):-
    number(M),
    number(F),!.

is_exponential(exp(i),1,1):-!.
is_exponential(exp(i*F),1,F):-
    number(F),!.
is_exponential(M*exp(i),M,1):-
    number(M),!.
is_exponential(M*exp(i*F),M,F):-
    number(M),
    number(F),!.

is_exponential(cos(F)+i*sin(F),1,F):-
    number(F),!.
is_exponential(M*(cos(F)+i*sin(F)),M,F):-
    number(M),
    number(F),!.


pol_rec(R,I,M,F):-
    number(R),
    number(I),!,
    default_is(M,sqrt(R*R+I*I)),
    default_is(F,atan2(I,R)).
pol_rec(R,I,M,F):-
    number(M),
    number(F),!,
    default_is(R,M*cos(F)),
    default_is(I,M*sin(F)).

complex_number(A):-
    var(A),!,fail.

complex_number(i):-!.
complex_number(-i):-!.
complex_number(R):-
    number(R),!.
complex_number(R + I*i):-
    number(R),
    number(I),!.
complex_number(R - I*i):-
    number(R),
    number(I),!.
complex_number(R - i):-
    number(R),!.
complex_number(exp(i*F)):-
    number(F),!.
complex_number(M*exp(i*F)):-
    number(M),
    number(F),!.
complex_number(cos(F)+i*sin(F)):-
    number(F),!.
complex_number(M*(cos(F)+i*sin(F))):-
    number(M),
    number(F),!.
complex_number(I):-
    imaginary_number(I,_),!.

imaginary_number(i,1):-!.
imaginary_number(I*i,I):-
    number(I),!.

zero(0):-!.
zero(0.0):-!.
zero(-0):-!.
zero(-0.0):-!.

one(1):-!.
one(1.0):-!.
