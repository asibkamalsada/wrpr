%----------------------------------------------------------
% Basis für die Zeitplanung (Was findet wann wo statt)
%----------------------------------------------------------


% Slots können aufeinander folgen
consecutive(W, L1, L2) :- slot(W, L1, _), slot(W, L2, _), L2=L1+1.


% Eine Stunde eines Kurses findet zu einer bestimmten Zeit in einem bestimmten Raum statt
{ lesson(W, L, T, Y, C, S, R) : slot(W, L, _), room(R) } :- course(T, Y, C, S).


% Jede Ressource (Lehrer, Klasse, Raum) kann in einem Zeitraum nur einmal genutzt werden...
% TODO Das viele count und != ist wohl kaum gut für die Performance... Aber so hier funktioniert es erst einmal
:- #count{ Y, C, S, R : lesson(W, L, T, Y, C, S, R) }>1, teacher(T).
:- #count{ T, S, R : lesson(W, L, T, Y, C, S, R) }>1, class(Y, C).
:- #count{ T, Y, C, S : lesson(W, L, T, Y, C, S, R) }>1, room(R).


% Es muss so viele Stunden für einen Kurs geben, wie für die jeweilige Klassenstufe in diesem Fach festgelegt
:- course(T, Y, C, S), courseHours(T, Y, C, S, H1), H2=#sum{ X, W, L, R : lesson(W, L, T, Y, C, S, R), slot(W, L, X) }, H1!=H2.


% Ein Fach, für welches es Spezialräume gibt, muss in einem solchen stattfinden
:- lesson(_, _, _, _, _, S, R1), specialRoom(R2, S), not specialRoom(R1, S).


% Jede Klasse hat min. eine Stunde mit ihrem Lehrer in ihrem Klassenraum
:- classTeacher(T, Y, C), not lesson(_, _, T, Y, C, _, _).


% Jeder Lehrer hat einen freien Tag
freeday(T, W) :- teacher(T), weekday(W), not lesson(W, _, T, _, _, _, _).
:- teacher(T), not freeday(T, _).

% Ein Lehrer hat maximal zwei Stunden hintereinander
:- consecutive(W, L1, L2), consecutive(W, L2, L3), lesson(W, L1, T, _, _, _, _), lesson(W, L2, T, _, _, _, _), lesson(W, L3, T, _, _, _, _).

% Ein Lehrer hat max. zwei Freistunden hintereinander (an einem Tag, den er nicht komplett frei hat)
:- consecutive(W, L1, L2), consecutive(W, L1, L2), not lesson(W, L1, T, _, _, _, _), not lesson(W, L2, T, _, _, _, _), lesson(W, _, T, _, _, _, _).



#show lesson/7.
