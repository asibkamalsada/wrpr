%----------------------------------------------------------
% Basis für die Zeitplanung (Was findet wann wo statt)
%----------------------------------------------------------


% Jede Ressource (Klasse, Lehrer, Raum) kann in einem Zeitraum nur einmal genutzt werden
%-


% Es muss so viele Stunden für einen Kurs geben, wie für die jeweilige Klassenstufe in diesem Fach festgelegt
%-

% Stunden bestimmter Fächer dürfen nur in bestimmten Räumen stattfinden
:- lesson(C, _, R), course(C, _, _, S1), specialRoom(R, S2), S1!=S2.


% Jede Klasse hat min. eine Stunde mit ihrem Lehrer in ihrem Klassenraum
%-

% Jeder Lehrer hat einen freien Tag
%-

% Ein Lehrer hat maximal vier Stunden hintereinander
%-

% Ein Lehrer hat max. 3 Freistunden hintereinander
%-

