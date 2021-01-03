teacher(a;b;c;d;e;f;g;h;i;j;k;l;m;n;o;p;q;r;s;t;u).
teaches(
    a,info;
    a,math;
    b,bio;
    b,nawi;
    c,ge;
    c,gewi;
    d,ge;
    d,grw;
    e,de;
    e,mu;
    f,de;
    f,ku;
    g,geo;
    g,eth;
    h,reli;
    h,spo;
    i,reli;
    i,ku;
    j,math;
    j,chem;
    k,math;
    k,chem;
    l,deu;
    l,grw;
    m,eng;
    m,mu;
    n,math;
    n,geo;
    o,spo;
    o,fremd;
    p,eng;
    p,fremd;
    q,deu;
    q,fremd;
    r,deu;
    r,eng;
    s,eng;
    s,spo;
    t,te;
    t,eng;
    u,bio;
    u,phy
).
subject(X) :- teaches(_,X).
class(
    5..10,a;
    5..10,b
).
%classes per week (for class 5 only at the moment)
classperweek(
    5,de,5;
    5,info,0;
    5,eng,5;
    5,fremd,0;
    5,math,4;
    5,bio,2;
    5,chem,0;
    5,phy,0;
    5,ge,1;
    5,grw,0;
    5,geo,2;
    5,spo,3;
    5,eth,2;
    5,ku,2;
    5,mu,2;
    5,tec,0;
    5,nawi,0;
    5,gewi,0;
).
room(1..21).
%for monday to friday
weekday(1..5).

%for lesson 1 to 9 
slot(1..9).

physRoom(9).
chemRoom(8).
bioRoom(7).
pcRoom(5..6).
musicRoom(4).
artRoom(3).
gym(1..2).

standardRoom(10..21).

maxHourse(X,30) :- teacher(X).

% For each teacher and each timeslot, pick at most one subject which they'll teach and a class and room for them.
{timetable(W,S,T,A,B,J,R):class(A,B),room(R),teaches(T,J)} <= 1 :- weekday(W);slot(S);teacher(T);class(A,B).

% Cardinality constraint enforcing that no room is occupied more than once in the same timeslot on the timetable.
:- #count{uses(T,A,B,J):timetable(W,S,T,A,B,J,R)} > 1; weekday(W); slot(S); room(R).

% Cardinaltiy constraint enforcing that no class has two subject at the same time
:- #count{timp(A,B,W,S,R): timetable(W,S,T,A,B,J,R)} != 1, class(A,B), slot(S), weekday(W).

%*
maximum(C,N,S,X) :- X = #count{temp(A,B): timetable(A,B,Y,C,N,S,Z)}, class(C,N), subject(S).
:- maximum(C,N,S,X), classperweek(C,S,Y), X!=Y.
*%

%ob das geht weiß ich noch nicht, sollte aber lul (constaint that classes per week is right
:- #count{temp(A,B): timetable(A,B,Y,C,N,S,Z)} != X, class(C,N), subject(S), classperweek(C,S,X).

:- timetable(W,S,T,C,N,J,R), subject(J), J=phy, room(R), not physRoom(R). 
:- timetable(W,S,T,C,N,J,R), subject(J), J=chem, room(R), not chemRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=bio, room(R), not bioRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=info, room(R), not pcRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=mu, room(R), not musicRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=ku, room(R), not artRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=spo, room(R), not gym(R).

:- timetable(W,S,T,C,N,J,R), subject(J), not J=phy, room(R), physRoom(R). 
:- timetable(W,S,T,C,N,J,R), subject(J), not J=chem, room(R), chemRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=bio, room(R), bioRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=info, room(R), pcRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=mu, room(R), musicRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=ku, room(R), artRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=spo, room(R), gym(R).

%teacherCount(T,X) :- X = #count{xmp(A,B): timetable(A,B,T,C,N,S,Z)}, teacher(T).
%:- teacherCount(T,X), maxHourse(T,Y), X>Y.

#show timetable/7.

