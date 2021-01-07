%-----------------------------------------------
% Basis für die Planungen von Kursen (Wer was)
%-----------------------------------------------


% Whether a subject is teached within a particular year
not_teached(S, Y) :- subjectTimes(S, Y, X), X=0.


% Ein Kurs ist eine "Gemeinschaft" aus Lehrer, Klasse und Fach
% Weise jeder Klasse für jedes Fach (welches in dieser Stufe unterrichtet wird) einen Lehrer zu (der dieses Fach unterrichtet)
1{ course(T, Y, C, S) : teaches(T, S)  }1 :- class(Y, C), subject(S), not not_teached(S, Y).


% Jede Klasse hat min. einen Kurs mit ihrem Klassenlehrer (der min. eine Stunde hat)
ctcourse(Y, C) :- course(T, Y, C, S), not not_teached(S, Y), classTeacher(T, Y, C).
:- class(Y, C), not ctcourse(Y, C).


% Anzahl der Stunden eines Kurses
courseHours(T, Y, C, S, H) :- subjectTimes(S, Y, H), course(T, Y, C, S).


% Ein Lehrer unterrichtet max. x Stunden (-> maxHours/2)
teacherHours(T, H) :- H=#sum{ X, Y, C, S : courseHours(T, Y, C, S, X) }, teacher(T).
:- teacherHours(T, H1), maxHours(T, H2), H1>H2.





%#show course/4.
%#show courseHours/5.
%#show teacherHours/2.
