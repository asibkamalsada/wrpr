%*------------------------------------------------------------------------------------------------------------------
                                   Script to find a new substitution timetable
--------------------------------------------------------------------------------------------------------------------*%

% Teachers should not work on there free day
freeday(T,W) :- teacher(T), weekday(W), not timetable(W,_,T,_,_,_,_).

% Finde a new teacher that is free for a lesson
findenew(W,S,T) :- timetable(W,S,T,C,N,J,R), ill(T).
change(W,S,T,X) :- findenew(W,S,T), teacher(X), not timetable(W,S,X,_,_,_,_), not ill(X), not freeday(X,W).
% Refill gaps with teachers that are free
0 {new(W,S,X,C,N,J,R) : change(W,S,T,X)} 1 :- timetable(W,S,T,C,N,J,R), findenew(W,S,T).

% Same for blocked rooms
findenewr(W,S,R) :- timetable(W,S,T,C,N,J,R), blocked(R).
changer(W,S,R,X) :- findenewr(W,S,R), room(X), not timetable(W,S,_,_,_,_,X), not blocked(X).
0 {new(W,S,T,C,N,J,X) : changer(W,S,R,X)} 1 :- timetable(W,S,T,C,N,J,R), findenewr(W,S,R).

#maximize { 1@3,W,S,T,C,N,J,R : new(W,S,T,C,N,J,R) }.

% A teacher should in the best case teach the subject he substitutes
:~ new(W,S,X,C,N,J,R), not teaches(X,J).[1@1,W,S,X]

:~ new(W,S,T,C,N,phy,R), not physRoom(R).[1@2,W,S,R]
:~ new(W,S,T,C,N,chem,R), not chemRoom(R).[1@2,W,S,R]
:~ new(W,S,T,C,N,bio,R), not bioRoom(R).[1@2,W,S,R]
:~ new(W,S,T,C,N,inf,R), not pcRoom(R).[1@2,W,S,R]
:~ new(W,S,T,C,N,mu,R), not musicRoom(R).[1@2,W,S,R]
:~ new(W,S,T,C,N,ku,R), not artRoom(R).[1@2,W,S,R]
:~ new(W,S,T,C,N,spo,R), not gym(R).[1@2,W,S,R]


% Import old timetable as much as possible
re(W,S,T,C,N,J,R) :- timetable(W,S,T,C,N,J,R), not blocked(R), not ill(T).
re(W,S,T,C,N,J,R) :- new(W,S,T,C,N,J,R).

#show re/7.




