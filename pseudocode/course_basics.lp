%-----------------------------------------------
% Basis für die Planungen von Kursen (Wer was)
%-----------------------------------------------

%TODO test everything

% Kurse auswählen
% Ein Kurs ist eine "Gemeinschaft" aus Lehrer, Klasse und Fach (welches dieser Lehrer unterrichtet)
{ course(T, Y, C, S) : teaches(T, S), class(Y, C) }.

% Jede Klasse hat min. einen Kurs mit ihrem Klassenlehrer
:- classTeacher(T, Y, C), not course(T, Y, C, _).

% Ein Lehrer unterrichtet max. x Stunden (-> maxHours/2)
% TODO implement

