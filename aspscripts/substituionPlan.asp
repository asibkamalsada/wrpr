%*------------------------------------------------------------------------------------------------------------------
                                   Script to find a new substitution timetable
--------------------------------------------------------------------------------------------------------------------*%

% Teachers should not work on there free day
freeday(T,W) :- teacher(T), weekday(W), not timetable(W,_,T,_,_,_,_).

% Import old timetable as much as possible
re(W,S,T,C,N,J,R) :- timetable(W,S,T,C,N,J,R), not blocked(R), not ill(T).

% Finde a new teacher that is free for a lesson
findenew(W,S,T) :- timetable(W,S,T,C,N,J,R), teacher(T), ill(T).
change(W,S,T,X) :- findenew(W,S,T), teacher(X), not timetable(W,S,X,_,_,_,_), not ill(X), not freeday(X,W).
% Refill gabs with teachers that are free
1{re(W,S,X,C,N,J,R) : change(W,S,T,X)}1 :- timetable(W,S,T,C,N,J,R), findenew(W,S,T). 

% Same for blocked rooms
findenewr(W,S,R) :- timetable(W,S,T,C,N,J,R), room(R), blocked(R).
changer(W,S,R,X) :- findenewr(W,S,R), room(X), not timetable(W,S,_,_,_,_,X), not blocked(X).
1 {re(W,S,X,C,N,J,R) : changer(W,S,T,X)} 1 :- timetable(W,S,T,C,N,J,R), findenewr(W,S,T). 

% A teacher should in the best case teach the subject he substitutes 
:~ re(W,S,X,C,N,J,R), not teaches(X,J).[1@1]

#show re/7.




