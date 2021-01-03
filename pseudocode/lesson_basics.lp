%----------------------------------------------------------
% Basis für die Zeitplanung (Was findet wann wo statt)
%----------------------------------------------------------


% Slots können aufeinander folgen
consecutive(W, L1, L2) :- slot(W, L1, _), slot(W, L2, _), L2=L1+1.


% Eine Stunde eines Kurses findet zu einer bestimmten Zeit in einem bestimmten Raum statt
1{ lesson(W, L, T, Y, C, S, R) : slot(W, L, _), room(R) } :- course(T, Y, C, S).


% Jede Ressource (Lehrer, Klasse, Raum) kann in einem Zeitraum nur einmal genutzt werden...
:- lesson(W, L, T, Y1, C1, S1, R1), lesson(W, L, T, Y2, C2, S2, R2), (Y1, C1, S1, R1)!=(Y2, C2, S2, R2).
:- lesson(W, L, T1, Y, C, S1, R1), lesson(W, L, T2, Y, C, S2, R2), (T1, S1, R1)!=(T2, S2, R2).
:- lesson(W, L, T1, Y1, C1, S1, R), lesson(W, L, T2, Y2, C2, S2, R), (T1, Y1, C1, S1)!=(T2, Y2, C2, S2).


% Ein Kurs muss so viele Stunden haben wie geplant
%actualHours(T, Y, C, S, H) :- H=#sum{ X, W, L, R : lesson(W, L, T, Y, C, S, R), slot(W, L, X) }, course(T, Y, C, S).
:- courseHours(T, Y, C, S, H1), H2=#sum{ X, W, L, R : lesson(W, L, T, Y, C, S, R), slot(W, L, X) }, H1!=H2.



% Ein Fach, für welches es Spezialräume gibt, muss in einem solchen stattfinden
:- lesson(_, _, _, _, _, S, R1), specialRoom(R2, S), not specialRoom(R1, S).
% Ein Spezialraum soll nicht für ein anderes Fach genutzt werden
:- lesson(_, _, _, _, _, S1, R), specialRoom(R, S2), S1!=S2.


% Jeder Lehrer hat einen freien Tag
freeday(T, W) :- teacher(T), weekday(W), not lesson(W, _, T, _, _, _, _).
:- teacher(T), not freeday(T, _).

% Ein Lehrer hat maximal zwei Stunden hintereinander
:- consecutive(W, L1, L2), consecutive(W, L2, L3), lesson(W, L1, T, _, _, _, _), lesson(W, L2, T, _, _, _, _), lesson(W, L3, T, _, _, _, _).

% Ein Lehrer hat max. zwei Freistunden hintereinander (an einem Tag, den er nicht komplett frei hat)
:- consecutive(W, L1, L2), consecutive(W, L1, L2), not lesson(W, L1, T, _, _, _, _), not lesson(W, L2, T, _, _, _, _), lesson(W, _, T, _, _, _, _).


#show lesson/7.



