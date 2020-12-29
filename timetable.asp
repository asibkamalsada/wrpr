teacher(a).
teacher(b).
teacher(c).
teacher(d).
teacher(e).
teacher(f).
teacher(g).
teacher(h).
teacher(i).
teacher(j).
teacher(k).
teacher(l).
teacher(m).
teacher(n).
teacher(o).
teacher(p).
teacher(q).
teacher(r).
teacher(s).
teacher(t).
teacher(u).

maxHourse(X,30) :- teacher(X).

classTeacher(g,5,a).
classTeacher(r,5,b). 
classTeacher(o,6,a). 
classTeacher(c,6,b). 
classTeacher(a,7,a). 
classTeacher(k,7,b). 
classTeacher(b,8,a). 
classTeacher(d,8,b). 
classTeacher(u,9,a). 
classTeacher(t,9,b). 
classTeacher(q,10,a). 
classTeacher(p,10,b).



teaches(a,info).
teaches(a,math).
teaches(b,bio).
teaches(b,nawi).
teaches(c,ge).
teaches(c,gewi).
teaches(d,ge).
teaches(d,grw).
teaches(e,de).
teaches(e,mu).
teaches(f,de).
teaches(f,ku).
teaches(g,geo).
teaches(g,eth).
teaches(h,reli).
teaches(h,spo).
teaches(i,reli).
teaches(i,ku).
teaches(j,math).
teaches(j,chem).
teaches(k,math).
teaches(k,chem).
teaches(l,deu).
teaches(l,grw).
teaches(m,eng).
teaches(m,mu).
teaches(n,math).
teaches(n,geo).
teaches(o,spo).
teaches(o,fremd).
teaches(p,eng).
teaches(p,fremd).
teaches(q,deu).
teaches(q,fremd).
teaches(r,deu).
teaches(r,eng).
teaches(s,eng).
teaches(s,spo).
teaches(t,techom).
teaches(t,eng).
teaches(u,bio).
teaches(u,phy).

subject(X) :- teaches(_,X).

class(5,a).
class(5,b).
class(6,a).
class(6,b).
class(7,a).
class(7,b).
class(8,a).
class(8,b).
class(9,a).
class(9,b).
class(10,a).
class(10,b).

room(1..21).

physRoom(9).
chemRoom(8).
bioRoo(7).
pcRoom(5..6).
musicRoom(4).
artRoom(3).
gym(1..2).

standardRoom(10..21).

weekday(1..5).

slot(1..9).

1{timetable(C,D,E,A,B,G,F):teacher(E), room(F), subject(G)}1 :- class(A,B), weekday(C), slot(D).

:- timetable(W,S,T,C,N,J,R), teacher(T), subject(J), not teaches(T,J). 



#show timetable/7.

