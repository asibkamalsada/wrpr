%---------------------
% Allgemeine Basis
%---------------------

% Predikate (Sternchen für gegeben)
% *class/2 - Klassenstufe, Klassenbezeichnung
% *teacher/1 - Lehrer
% *teaches/2 - Lehrer unterrichtet Fach
% *classTeacher/2 - Lehrer, Klasse
% *maxHours/2 - Lehrer, maximale Anzahl Stunden
% *subject/1 - Fach
% course/4 - Kursbezeichnung, Lehrer, Klasse, Fach
% *subjectTimes/3 - Fach, Klassenstufe, Anzahl Stunden gemäß Stundentafel
% lesson/3 - Kurs, Zeit, Raum
% *room/1 - Raum
% *specialRoom/2 - Raum, Fach (für das dieser Raum geeignet ist)
% *slot/3 - Zeitslot, Tag, Zeiteinheiten
% *weekday/1 - Tag


% Ein Lehrer unterrichtet Fächer
%-

% Ein Kurs ist eine "Gemeinschaft" aus Lehrer, Klasse und Fach (welches dieser Lehrer unterrichtet)
course(T, C, S) :- teaches(T, S), class(_, C).

% Eine Stunde ist etwas, was zu einer bestimmten Zeit in einem bestimmten Raum stattfindet
lesson(C, T, R) :- course(C, _, _, _), slot(T, _, _), room(R).

% Abstände zwischen Slots
%- ??????????????????????

% Definition Anzahl Stunden eines Kurses
%- ??????????????????????

