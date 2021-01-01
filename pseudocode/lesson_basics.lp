%----------------------------------------------------------
% Basis für die Zeitplanung (Was findet wann wo statt)
%----------------------------------------------------------


% Slots können aufeinander folgen
consecutive(W, L1, L2) :- slot(W, L1, _), slot(W, L2, _), L2=L1+1.


% Eine Stunde eines Kurses findet zu einer bestimmten Zeit in einem bestimmten Raum statt
{ lesson(W, L, T, Y, C, S, R) : slot(W, L, _), room(R) } :- course(T, Y, C, S).


% Jede Ressource (Lehrer, Klasse, Raum) kann in einem Zeitraum nur einmal genutzt werden...
% TODO implement


% Es muss so viele Stunden für einen Kurs geben, wie für die jeweilige Klassenstufe in diesem Fach festgelegt
% TODO test
:- X1 = #count{ (W, L): lesson(W, L1, T, Y, C, S, _) }, slot(W, L1, 1), course(T, Y, C, S), X2 = #count{ (W, L): lesson(W, L2, T, Y, C, S, _) }, slot(W, L2, 2), subjectTimes(S, Y, XT), (X1+(X2*2))!=XT.

% Stunden bestimmter Fächer dürfen nur in bestimmten Räumen stattfinden
:- lesson(M, _, R), course(M, _, _, S1), specialRoom(R, S2), S1!=S2.


% Jede Klasse hat min. eine Stunde mit ihrem Lehrer in ihrem Klassenraum
:- classTeacher(T, Y, C), not lesson(_, _, T, Y, C, _, _).


% Jeder Lehrer hat einen freien Tag
freeday(T, W) :- teacher(T), weekday(W), not lesson(W, _, T, _, _, _, _).
:- teacher(T), not freeday(T, _).

% Ein Lehrer hat maximal zwei Stunden hintereinander
:- consecutive(W, L1, L2), consecutive(W, L2, L3), lesson(W, L1, T, _, _, _, _), lesson(W, L2, T, _, _, _, _), lesson(W, L3, T, _, _, _, _).

% Ein Lehrer hat max. zwei Freistunden hintereinander
:- consecutive(W, L1, L2), consecutive(W, L1, L2), not lesson(W, L1, T, _, _, _, _), not lesson(W, L2, T, _, _, _, _), lesson(W, _, T, _, _, _, _).


