% -------------------------- Knowledge Base for an arbitrary tiny school to calcualte a timetable ----------------------------


% Teachers and the subjects they teach
teacher(z). teaches(z, ma).
teacher(y). teaches(y, de).

%max hours a teacher may teach per week 
maxHourse(X, 20) :- teacher(X).

% Every class in the school and the corresponding classteacher
class(1, a). classTeacher(z,1,a).
class(1, b). classTeacher(y,1,b).

% Every subject and the lessons per week that this lesson is taught
subject(ma). subjectTimes(ma, 1, 3).
subject(de). subjectTimes(de, 1, 3).

% Every posible weekday and slot a lesson can take place
% A slot can have one or two hours
weekday(1..5).
slot(1, 1).
slot(2, 2).

% Rooms
room(1..2).
standardRoom(1..2).

physRoom(3).
chemRoom(4).
bioRoom(5).
pcRoom(6).
musicRoom(7).
artRoom(8).
gym(9).
