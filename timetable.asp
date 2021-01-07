teacher(a;b;c;d;e;f;g;h;i;j;k;l;m;n;o;p;q;r;s;t;u).
teaches(a,inf).
teaches(a,ma).
teaches(b,bio).
teaches(b,profil).
teaches(c,ge).
teaches(c,profil).
teaches(d,ge).
teaches(d,grw).
teaches(e,de).
teaches(e,mu).
teaches(f,de).
teaches(f,ku).
teaches(g,geo).
teaches(g,ethikreligion).
teaches(h,ethikreligion).
teaches(h,spo).
teaches(i,ethikreligion).
teaches(i,ku).
teaches(j,ma).
teaches(j,ch).
teaches(k,ma).
teaches(k,ch).
teaches(l,de).
teaches(l,grw).
teaches(m,en).
teaches(m,mu).
teaches(n,ma).
teaches(n,geo).
teaches(o,spo).
teaches(o,fremd).
teaches(p,en).
teaches(p,fremd).
teaches(q,de).
teaches(q,fremd).
teaches(r,de).
teaches(r,en).
teaches(s,en).
teaches(s,spo).
teaches(t,tuc).
teaches(t,en).
teaches(u,bio).
teaches(u,ph).

class(
    5..10,a;
    5..10,b
).

subject(de).
subjectTimes(de, 5, 5).
subjectTimes(de, 6, 4).
subjectTimes(de, 7, 4).
subjectTimes(de, 8, 4).
subjectTimes(de, 9, 4).
subjectTimes(de, 10, 4).
subject(en).
subjectTimes(en, 5, 5).
subjectTimes(en, 6, 4).
subjectTimes(en, 7, 4).
subjectTimes(en, 8, 3).
subjectTimes(en, 9, 3).
subjectTimes(en, 10, 3).
subject(fremd).
subjectTimes(fremd, 5, 0).
subjectTimes(fremd, 6, 3).
subjectTimes(fremd, 7, 4).
subjectTimes(fremd, 8, 3).
subjectTimes(fremd, 9, 3).
subjectTimes(fremd, 10, 3).
subject(ma).
subjectTimes(ma, 5, 4).
subjectTimes(ma, 6, 4).
subjectTimes(ma, 7, 4).
subjectTimes(ma, 8, 4).
subjectTimes(ma, 9, 4).
subjectTimes(ma, 10, 4).
subject(bio).
subjectTimes(bio, 5, 2).
subjectTimes(bio, 6, 2).
subjectTimes(bio, 7, 1).
subjectTimes(bio, 8, 1).
subjectTimes(bio, 9, 2).
subjectTimes(bio, 10, 2).
subject(ch).
subjectTimes(ch, 5, 0).
subjectTimes(ch, 6, 0).
subjectTimes(ch, 7, 1).
subjectTimes(ch, 8, 2).
subjectTimes(ch, 9, 2).
subjectTimes(ch, 10, 2).
subject(ph).
subjectTimes(ph, 5, 0).
subjectTimes(ph, 6, 2).
subjectTimes(ph, 7, 2).
subjectTimes(ph, 8, 2).
subjectTimes(ph, 9, 2).
subjectTimes(ph, 10, 2).
subject(ge).
subjectTimes(ge, 5, 1).
subjectTimes(ge, 6, 2).
subjectTimes(ge, 7, 2).
subjectTimes(ge, 8, 2).
subjectTimes(ge, 9, 2).
subjectTimes(ge, 10, 2).
subject(grw).
subjectTimes(grw, 5, 0).
subjectTimes(grw, 6, 0).
subjectTimes(grw, 7, 1).
subjectTimes(grw, 8, 1).
subjectTimes(grw, 9, 2).
subjectTimes(grw, 10, 2).
subject(geo).
subjectTimes(geo, 5, 2).
subjectTimes(geo, 6, 2).
subjectTimes(geo, 7, 2).
subjectTimes(geo, 8, 1).
subjectTimes(geo, 9, 1).
subjectTimes(geo, 10, 2).
subject(spo).
subjectTimes(spo, 5, 3).
subjectTimes(spo, 6, 3).
subjectTimes(spo, 7, 2).
subjectTimes(spo, 8, 2).
subjectTimes(spo, 9, 2).
subjectTimes(spo, 10, 2).
subject(ethikreligion).
subjectTimes(ethikreligion, 5, 2).
subjectTimes(ethikreligion, 6, 2).
subjectTimes(ethikreligion, 7, 2).
subjectTimes(ethikreligion, 8, 2).
subjectTimes(ethikreligion, 9, 2).
subjectTimes(ethikreligion, 10, 2).
subject(ku).
subjectTimes(ku, 5, 2).
subjectTimes(ku, 6, 1).
subjectTimes(ku, 7, 1).
subjectTimes(ku, 8, 1).
subjectTimes(ku, 9, 1).
subjectTimes(ku, 10, 1).
subject(mu).
subjectTimes(mu, 5, 2).
subjectTimes(mu, 6, 1).
subjectTimes(mu, 7, 1).
subjectTimes(mu, 8, 1).
subjectTimes(mu, 9, 1).
subjectTimes(mu, 10, 1).
subject(tuc).
subjectTimes(tuc, 5, 2).
subjectTimes(tuc, 6, 1).
subjectTimes(tuc, 7, 1).
subjectTimes(tuc, 8, 1).
subjectTimes(tuc, 9, 1).
subjectTimes(tuc, 10, 1).
subject(profil).
subjectTimes(profil, 5, 0).
subjectTimes(profil, 6, 0).
subjectTimes(profil, 7, 0).
subjectTimes(profil, 8, 2).
subjectTimes(profil, 9, 2).
subjectTimes(profil, 10, 2).
subject(inf).
subjectTimes(inf, 5, 0).
subjectTimes(inf, 6, 0).
subjectTimes(inf, 7, 1).
subjectTimes(inf, 8, 1).
subjectTimes(inf, 9, 1).
subjectTimes(inf, 10, 1).
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

block(1,2; 4,5; 8,9).

% For each teacher and each timeslot, pick at most one subject which they'll teach and a class and room for them.
{timetable(W,S,T,A,B,J,R):class(A,B),room(R),teaches(T,J)} <= 1 :- weekday(W);slot(S);teacher(T).

% Cardinality constraint enforcing that no room is occupied more than once in the same timeslot on the timetable.
:- #count{uses(T,A,B,J):timetable(W,S,T,A,B,J,R)} > 1; weekday(W); slot(S); room(R).


% Cardinaltiy constraint enforcing that no class has two subject at the same time
:- #count{timp(A,B,W,S,R): timetable(W,S,T,A,B,J,R)} > 1; class(A,B); slot(S); weekday(W).

%ob das geht weiß ich noch nicht, sollte aber lul (constaint that classes per week is right
:- #count{temp(A,B): timetable(A,B,T,C,N,S,R)} != X; class(C,N); subject(S); subjectTimes(S,C,X).


%lehrer immer ein fach
:- #count{A,B,J,T: timetable(W,S,T,A,B,J,R)} > 1, class(A,B), subject(J).

%lehrer freien Tag
freeday(T,W) :- teacher(T), weekday(W), not timetable(W,_,T,_,_,_,_).
:- teacher(T), not freeday(T,_).

:- timetable(W,S,T,C,N,J,R), subject(J), J=phy, room(R), not physRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=chem, room(R), not chemRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=bio, room(R), not bioRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=inf, room(R), not pcRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=mu, room(R), not musicRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=ku, room(R), not artRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=spo, room(R), not gym(R).

:- timetable(W,S,T,C,N,J,R), subject(J), not J=phy, room(R), physRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=chem, room(R), chemRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=bio, room(R), bioRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=inf, room(R), pcRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=mu, room(R), musicRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=ku, room(R), artRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=spo, room(R), gym(R).

%Constraint for no empty slots in the middle

connected(A,B,W,S,W,S) :- timetable(W,S,_,A,B,_,_).
connected(A,B,W,S,W,Y) :- timetable(W,S,_,A,B,_,_), timetable(W,V,_,A,B,_,_), connected(A,B,W,S,W,V),  timetable(W,Y,_,A,B,_,_), |Y - V| == 1.
:- timetable(W,S,_,A,B,_,_), timetable(W,V,_,A,B,_,_), not connected(A,B,W,S,W,V).

%teacher max hours
:- #count{xmp(A,B): timetable(A,B,T,C,N,S,Z)} > Y, teacher(T), maxHourse(T,Y).

%profil und ethik für klassenstufe zur gleichen zeit (maybe todo // hardcoding problems)

:-class(C,_), subject(J), J = ethikreligion, #count{slots(W,S):timetable(W,S,_,C,_,J,_)} > 2.
:-class(C,_), subject(J), J = profil, #count{slots(W,S):timetable(W,S,_,C,_,J,_)} > 2.

% Ein Lehrer hat maximal drei Stunden hintereinander

connectedTeacher(T,W,S,W,S) :- timetable(W,S,T,_,_,_,_).
connectedTeacher(T,W,S,W,Y) :- timetable(W,S,T,_,_,_,_), timetable(W,V,T,_,_,_,_), connectedTeacher(T,W,S,W,V),  timetable(W,Y,T,_,_,_,_), |Y - V| == 1.

%:- connectedTeacher(T,W,S,W,Y), |S - Y| > 2.

%maximal 2 freistunden (macht das Programm sehr langsam, zum testen bitte ausstellen)

%:- timetable(W,_,T,_,_,_,_), connectedTeacher(T,W,A,W,B), connectedTeacher(T,W,X,W,Y), A < X, B < Y, A < B, X < Y, |B - X|>3.


firstlesson(C,N,X) :- class(C,N), slot(S), S = 1, X = #count{days(W) : timetable(W,S,_,C,N,_,_)}.
%#maximize {X@10:firstlesson(C,N,X)}.

latelesson(C,N,W,X) :- class(C,N), weekday(W), slot(S), S > 6, X = #count{slots(S) : timetable(W,S,_,C,N,_,_)}.
%#minimize {X@5: latelesson(C,N,W,X)}.


%block lesson

blocklesson(X,Y,W,C,N,50):-block(X,Y), slot(X), slot(Y), weekday(W), class(C,N), subject(J), timetable(W,X,_,C,N,J,_), timetable(W,Y,_,C,N,J,_).
blocklesson(X,Y,W,C,N,0):-block(X,Y), weekday(W), class(C,N), subject(J), subject(Z), J != Z, timetable(W,X,_,C,N,J,_), timetable(W,Y,_,C,N,Z,_), slot(X), slot(Y).

#maximize {Z@9:blocklesson(X,Y,W,C,N,Z)}.


#show timetable/7.
%#show blocklesson/6.

