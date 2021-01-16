%*
-------------------------- Rules to create and filter timetables ----------------------------
*%

% Create all possible timetables
% For each teacher and each timeslot, pick at most one subject which they'll teach and a class and room for them
{timetable(W,S,T,A,B,J,R):class(A,B),room(R),teaches(T,J)} <= 1 :- weekday(W);slot(S, _);teacher(T).

%---------------------------------------------------------------------------------------------------------------
% Basic constraints 

% Cardinality constraint enforcing that no room is occupied more than once in the same timeslot on the timetable.
:- #count{uses(T,A,B,J):timetable(W,S,T,A,B,J,R)} > 1; weekday(W); slot(S, _); room(R).


% Cardinaltiy constraint enforcing that no class has two subjects at the same time
:- #count{timp(R): timetable(W,S,T,A,B,J,R)} > 1; class(A,B); slot(S, _); weekday(W).

% Cardinaltiy constraint that maximum classes per week is correct
classSubjectTimes(A, B, J, X) :- #sum{ H, W, S : timetable(W, S, T, A, B, J, R), slot(S, H) }=X, class(A, B), subject(J).
:- classSubjectTimes(A, _, J, X1), subjectTimes(J, A, X2), X1!=X2.

% Cardinaltiy constraint that one teacher will only teach one subject per slot
:- #count{T: timetable(W,S,T,A,B,J,R)} > 1, class(A,B), subject(J).

% Constraints that all classes that need a specialist room will be taught in them 
:- timetable(W,S,T,C,N,J,R), subject(J), J=phy, room(R), not physRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=chem, room(R), not chemRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=bio, room(R), not bioRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=inf, room(R), not pcRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=mu, room(R), not musicRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=ku, room(R), not artRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), J=spo, room(R), not gym(R).

% Constraints that all classes that don't need a specialist room will not be taught in them 
:- timetable(W,S,T,C,N,J,R), subject(J), not J=phy, room(R), physRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=chem, room(R), chemRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=bio, room(R), bioRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=inf, room(R), pcRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=mu, room(R), musicRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=ku, room(R), artRoom(R).
:- timetable(W,S,T,C,N,J,R), subject(J), not J=spo, room(R), gym(R).

%---------------------------------------------------------------------------------------------------------------
% Teacher constraints 

% Teachers get one day off 
freeday(T,W) :- teacher(T), weekday(W), not timetable(W,_,T,_,_,_,_).
:- teacher(T), not freeday(T,_).

% Teacher only have to teach their maximum amount of hours per week
:- #sum{H, W, S: timetable(W, S, T, A, B, J, R), slot(S, H) } > Y, teacher(T), maxHourse(T,Y).

% A teacher has a maximum of 2 lessons in a row (possibly block lessons)
:- timetable(W, S, T, _, _, _, _), timetable(W, S+1, T, _, _, _, _), timetable(W, S+2, T, _, _, _, _).

% TODO which of these two approaches is better???
%connectedTeacher(T,W,S,W,S) :- timetable(W,S,T,_,_,_,_).
%connectedTeacher(T,W,S,W,Y) :- timetable(W,S,T,_,_,_,_), timetable(W,V,T,_,_,_,_), connectedTeacher(T,W,S,W,V),  timetable(W,Y,T,_,_,_,_), |Y - V| == 1.
%:- connectedTeacher(T,W,S,W,Y), |S - Y| > 2.


% A teacher has a maximum of 2 free periods in a row (on a non-free day)
:- timetable(W, _, T, _, _, _, _), slot(S, _), not timetable(W, S, T, _, _, _, _), not timetable(W, S+1, T, _, _, _, _).

% This will slowdown the solving alot
%:- timetable(W,_,T,_,_,_,_), connectedTeacher(T,W,A,W,B), connectedTeacher(T,W,X,W,Y), A < X, B < Y, A < B, X < Y, |B - X|>3.

%---------------------------------------------------------------------------------------------------------------
% Class constraints 

% Profil und Ethik/Religion lessons will be at the same time for every grade level (maybe todo // hardcoding problems)

:-class(C,_), subject(J), J = ethikreligion, #count{slots(W,S):timetable(W,S,_,C,_,J,_)} > 2.
:-class(C,_), subject(J), J = profil, #count{slots(W,S):timetable(W,S,_,C,_,J,_)} > 2.


% Constraint that a class will not have any free periods 
connected(A,B,W,S,W,S) :- timetable(W,S,_,A,B,_,_).
connected(A,B,W,S,W,Y) :- timetable(W,S,_,A,B,_,_), timetable(W,V,_,A,B,_,_), connected(A,B,W,S,W,V),  timetable(W,Y,_,A,B,_,_), |Y - V| == 1.
:- timetable(W,S,_,A,B,_,_), timetable(W,V,_,A,B,_,_), not connected(A,B,W,S,W,V).

#show timetable/7.
