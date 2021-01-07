%----------------------------------------------------------
% Basis für die Zeitplanung (Was findet wann wo statt)
%----------------------------------------------------------

% Eine Stunde eines Kurses findet zu einer bestimmten Zeit in einem bestimmten Raum statt
1{ lesson(W, L, T, Y, C, S, R) : slot(W, L, _), room(R) } :- course(T, Y, C, S).


% Jede Ressource (Lehrer, Klasse, Raum) kann in einem Zeitraum nur einmal genutzt werden...
% Teacher
:- #count{ Y, C, S, R : lesson(W, L, T, Y, C, S, R) }>1, slot(W, L, _), teacher(T).
% Class
:- #count{ T, S, R : lesson(W, L, T, Y, C, S, R) }>1, slot(W, L, _), class(Y, C).
% Room
:- #count{ T, Y, C, S : lesson(W, L, T, Y, C, S, R) }>1, slot(W, L, _), room(R).


% Ein Kurs muss so viele Stunden haben wie geplant
:- #sum{ X, W, L : lesson(W, L, T, Y, C, S, R), slot(W, L, X) } != H, courseHours(T, Y, C, S, H).


% Ein Fach, für welches es Spezialräume gibt, muss in einem solchen stattfinden
:- lesson(_, _, _, _, _, S, R1), specialRoom(R2, S), not specialRoom(R1, S).
% Ein Spezialraum soll nicht für ein anderes Fach genutzt werden
:- lesson(_, _, _, _, _, S1, R), specialRoom(R, S2), S1!=S2.


% Jeder Lehrer hat einen freien Tag
freeday(T, W) :- teacher(T), weekday(W), not lesson(W, _, T, _, _, _, _).
:- teacher(T), not freeday(T, _).

% Ein Lehrer hat maximal zwei Stunden hintereinander
:- lesson(W, L, T, _, _, _, _), lesson(W, L+1, T, _, _, _, _), lesson(W, L+2, T, _, _, _, _).

% Ein Lehrer hat max. zwei Freistunden hintereinander (an einem Tag, den er nicht komplett frei hat)
:- slot(W, L, _), slot(W, L+1, _), not lesson(W, L, T, _, _, _, _), not lesson(W, L+1, T, _, _, _, _), lesson(W, _, T, _, _, _, _).


#show lesson/7.



