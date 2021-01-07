class(5, a). classTeacher(t1, 5, a).
class(5, b). classTeacher(t2, 5, b).

subject(mathe). subjectTimes(mathe, 5, 2).
subject(deutsch). subjectTimes(deutsch, 5, 1).
subject(kunst). subjectTimes(kunst, 5, 0).

teacher(t1). maxHours(t1, 20). teaches(t1, mathe).
teacher(t2). maxHours(t2, 20). teaches(t2, deutsch). teaches(t2, kunst).

room(r1).
room(r2). specialRoom(r2, deutsch).

weekday(montag).
weekday(dienstag).
weekday(mittwoch).
slot(montag, 1, 1).
slot(montag, 2, 2).
slot(dienstag, 1, 1).
slot(dienstag, 2, 2).
%slot(mittwoch, 1, 1).
%slot(mittwoch, 2, 2).


