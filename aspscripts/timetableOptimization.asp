%*
-------------------------- Optimization Rules to filter timetables ----------------------------
*%

% A class should start at the first lesson and should not have too many late lessons a week
firstlesson(C,N,X) :- class(C,N), X=#count{days(W) : timetable(W,1,_,C,N,_,_)}.
#maximize {X@10:firstlesson(C,N,X)}.

% Minimize late lessons
latelesson(C,N,W,X) :- class(C,N), weekday(W), slot(S, _), S>3, X = #count{slots(S) : timetable(W,S,_,C,N,_,_)}.
#minimize {X@9: latelesson(C,N,W,X)}.


% A class should have lots of lessons with their class teacher
classTeacherLessons(C, N, X) :- classTeacher(T, C, N), X = #count{ (W, S) : timetable(W, S, T, C, N, _, _) }.
#maximize { X@5 : classTeacherLessons(_, _, X) }.


% TODO Classroom could be regulated similarly

% A class should have approximately the same number of hours per day  
classLessonsAverage(C, N, X) :- class(C, N), X1 = #count{ (W, S): timetable(W, S, _, C, N, _, _) }, X = X1/5.
classLessons(W, C, N, X) :- class(C, N), weekday(W), X = #count{ S: timetable(W, S, _, C, N, _, _) }.
#minimize { X@7 : classLessons(_, W, C, X1), classLessonsAverage(C, N, X2), X=|X1-X2| }.


% Similar hours per subject and teacher
subjectLessonsAverage(T, X) :- teacher(T), X1 = #count{ (W, S): timetable(W, S, T, _, _, _, _) }, X=X1/2.
teacherSubjectLessons(T, J, X) :- teacher(T), subject(J), X = #count{ (W, S): timetable(W, S, T, _, _, J, _) }.
#minimize { X@7 : teacherSubjectLessons(T, J, X1), subjectLessonsAverage(J, X2), X=|X1-X2| }.
