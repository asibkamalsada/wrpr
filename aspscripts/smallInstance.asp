% -------------------------- Knowledge Base for an arbitrary small school to calcualte a timetable ----------------------------


% Teachers and the subjects they teach
teacher(a). teaches(a, ma).
teacher(b). teaches(b, de).
teacher(c). teaches(c, ku).
teacher(d). teaches(d, mu).
teacher(e). teaches(e, spo).

%max hours a teacher may teach per week 
maxHourse(X, 20) :- teacher(X).

% Every class in the school and the corresponding classteacher
class(1, a). classTeacher(a,1,a).
class(1, b). classTeacher(b,1,b).

% Every subject and the lessons per week that this lesson is taught
subject(ma). subjectTimes(ma, 1, 3).
subject(de). subjectTimes(de, 1, 3).
subject(ku). subjectTimes(ku, 1, 1).
subject(mu). subjectTimes(mu, 1, 1).
subject(spo). subjectTimes(spo, 1, 2).

% Every posible weekday and slot a lesson can take place
% A slot can have one or two hours
weekday(1..5).
slot(1, 1).
slot(2, 2).
slot(3, 1).

% Rooms
room(1..9).
standardRoom(1..2).

physRoom(3).
chemRoom(4).
bioRoom(5).
pcRoom(6).
musicRoom(7).
artRoom(8).
gym(9).
