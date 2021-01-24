%*
-------------------------- Knowledge Base for an arbitrary school to calcualte a timetable ----------------------------
*%

% Teachers and the subjects they teach 

teacher(a;b;c;d;e;f;g;h;i;j;k;l;m;n;o;p;q;r;s;t;u).
teaches(a,inf).
teaches(a,ma).
teaches(b,bio).
teaches(b,profil).
teaches(c,ge).
teaches(c,profil).
teaches(d,ge).
teaches(d,grw).
teaches(e,de).
teaches(e,mu).
teaches(f,de).
teaches(f,ku).
teaches(g,geo).
teaches(g,ethikreligion).
teaches(h,ethikreligion).
teaches(h,spo).
teaches(i,ethikreligion).
teaches(i,ku).
teaches(j,ma).
teaches(j,ch).
teaches(k,ma).
teaches(k,ch).
teaches(l,de).
teaches(l,grw).
teaches(m,en).
teaches(m,mu).
teaches(n,ma).
teaches(n,geo).
teaches(o,spo).
teaches(o,fremd).
teaches(p,en).
teaches(p,fremd).
teaches(q,de).
teaches(q,fremd).
teaches(r,de).
teaches(r,en).
teaches(s,en).
teaches(s,spo).
teaches(t,tuc).
teaches(t,en).
teaches(u,bio).
teaches(u,ph).

%max hours a teacher may teach per week 
maxHours(X,30) :- teacher(X).

%---------------------------------------------------------------------------------------------------------------

% Every class in the school and the corresponding classteacher

class(
    5..10,a;
    5..10,b
).

classTeacher(a,5,a).
classTeacher(b,5,b). 
classTeacher(c,6,a). 
classTeacher(d,6,b). 
classTeacher(e,7,a). 
classTeacher(f,7,b). 
classTeacher(g,8,a). 
classTeacher(h,8,b). 
classTeacher(i,9,a). 
classTeacher(j,9,b). 
classTeacher(k,10,a). 
classTeacher(l,10,b).

%---------------------------------------------------------------------------------------------------------------

% Every subject and the maximum lessons per week that this lesson is taught 

subject(de).
subjectTimes(de, 5, 5).
subjectTimes(de, 6, 4).
subjectTimes(de, 7, 4).
subjectTimes(de, 8, 4).
subjectTimes(de, 9, 4).
subjectTimes(de, 10, 4).
subject(en).
subjectTimes(en, 5, 5).
subjectTimes(en, 6, 4).
subjectTimes(en, 7, 4).
subjectTimes(en, 8, 3).
subjectTimes(en, 9, 3).
subjectTimes(en, 10, 3).
subject(fremd).
subjectTimes(fremd, 5, 0).
subjectTimes(fremd, 6, 3).
subjectTimes(fremd, 7, 4).
subjectTimes(fremd, 8, 3).
subjectTimes(fremd, 9, 3).
subjectTimes(fremd, 10, 3).
subject(ma).
subjectTimes(ma, 5, 4).
subjectTimes(ma, 6, 4).
subjectTimes(ma, 7, 4).
subjectTimes(ma, 8, 4).
subjectTimes(ma, 9, 4).
subjectTimes(ma, 10, 4).
subject(bio).
subjectTimes(bio, 5, 2).
subjectTimes(bio, 6, 2).
subjectTimes(bio, 7, 1).
subjectTimes(bio, 8, 1).
subjectTimes(bio, 9, 2).
subjectTimes(bio, 10, 2).
subject(ch).
subjectTimes(ch, 5, 0).
subjectTimes(ch, 6, 0).
subjectTimes(ch, 7, 1).
subjectTimes(ch, 8, 2).
subjectTimes(ch, 9, 2).
subjectTimes(ch, 10, 2).
subject(ph).
subjectTimes(ph, 5, 0).
subjectTimes(ph, 6, 2).
subjectTimes(ph, 7, 2).
subjectTimes(ph, 8, 2).
subjectTimes(ph, 9, 2).
subjectTimes(ph, 10, 2).
subject(ge).
subjectTimes(ge, 5, 1).
subjectTimes(ge, 6, 2).
subjectTimes(ge, 7, 2).
subjectTimes(ge, 8, 2).
subjectTimes(ge, 9, 2).
subjectTimes(ge, 10, 2).
subject(grw).
subjectTimes(grw, 5, 0).
subjectTimes(grw, 6, 0).
subjectTimes(grw, 7, 1).
subjectTimes(grw, 8, 1).
subjectTimes(grw, 9, 2).
subjectTimes(grw, 10, 2).
subject(geo).
subjectTimes(geo, 5, 2).
subjectTimes(geo, 6, 2).
subjectTimes(geo, 7, 2).
subjectTimes(geo, 8, 1).
subjectTimes(geo, 9, 1).
subjectTimes(geo, 10, 2).
subject(spo).
subjectTimes(spo, 5, 3).
subjectTimes(spo, 6, 3).
subjectTimes(spo, 7, 2).
subjectTimes(spo, 8, 2).
subjectTimes(spo, 9, 2).
subjectTimes(spo, 10, 2).
subject(ethikreligion).
subjectTimes(ethikreligion, 5, 2).
subjectTimes(ethikreligion, 6, 2).
subjectTimes(ethikreligion, 7, 2).
subjectTimes(ethikreligion, 8, 2).
subjectTimes(ethikreligion, 9, 2).
subjectTimes(ethikreligion, 10, 2).
subject(ku).
subjectTimes(ku, 5, 2).
subjectTimes(ku, 6, 1).
subjectTimes(ku, 7, 1).
subjectTimes(ku, 8, 1).
subjectTimes(ku, 9, 1).
subjectTimes(ku, 10, 1).
subject(mu).
subjectTimes(mu, 5, 2).
subjectTimes(mu, 6, 1).
subjectTimes(mu, 7, 1).
subjectTimes(mu, 8, 1).
subjectTimes(mu, 9, 1).
subjectTimes(mu, 10, 1).
subject(tuc).
subjectTimes(tuc, 5, 2).
subjectTimes(tuc, 6, 1).
subjectTimes(tuc, 7, 1).
subjectTimes(tuc, 8, 1).
subjectTimes(tuc, 9, 1).
subjectTimes(tuc, 10, 1).
subject(profil).
subjectTimes(profil, 5, 0).
subjectTimes(profil, 6, 0).
subjectTimes(profil, 7, 0).
subjectTimes(profil, 8, 2).
subjectTimes(profil, 9, 2).
subjectTimes(profil, 10, 2).
subject(inf).
subjectTimes(inf, 5, 0).
subjectTimes(inf, 6, 0).
subjectTimes(inf, 7, 1).
subjectTimes(inf, 8, 1).
subjectTimes(inf, 9, 1).
subjectTimes(inf, 10, 1).

%---------------------------------------------------------------------------------------------------------------

% Every posible weekday and slot a lesson can take place
% A slot can have one or two hours

weekday(1..5).
slot(1, 2).
slot(2, 1).
slot(3, 2).
slot(4, 1).
slot(5, 1).
slot(6, 2).

%---------------------------------------------------------------------------------------------------------------

% Every room in specialist room for special subjects

room(1..21).
standardRoom(10..21).

physRoom(9).
chemRoom(8).
bioRoom(7).
pcRoom(5..6).
musicRoom(4).
artRoom(3).
gym(1..2).

