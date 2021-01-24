freeday(T,W) :- teacher(T), weekday(W), not timetable(W,_,T,_,_,_,_).

re(W,S,T,C,N,J,R) :- timetable(W,S,T,C,N,J,R), not blocked(R), not ill(T).

findenew(W,S,T) :- timetable(W,S,T,C,N,J,R), teacher(T), ill(T).
change(W,S,T,X) :- findenew(W,S,T), teacher(X), not timetable(W,S,X,_,_,_,_), not ill(X), not freeday(X,W).
1{re(W,S,X,C,N,J,R) : change(W,S,T,X)}1 :- timetable(W,S,T,C,N,J,R), findenew(W,S,T). 

findenewr(W,S,R) :- timetable(W,S,T,C,N,J,R), room(R), blocked(R).
changer(W,S,R,X) :- findenewr(W,S,R), room(X), not timetable(W,S,_,_,_,_,X), not blocked(X).
1{re(W,S,X,C,N,J,R) : changer(W,S,T,X)}1 :- timetable(W,S,T,C,N,J,R), findenewr(W,S,T). 

#show re/7.




