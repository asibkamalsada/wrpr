class(5, a).
class(6, a).
class(7, a).
class(8, a).
class(9, a).
class(10, a).


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

maxHours(T, 20) :- teacher(T).

classTeacher(a,5,a).
classTeacher(c,6,a).
classTeacher(e,7,a).
classTeacher(g,8,a).
classTeacher(i,9,a).
classTeacher(k,10,a).

teaches(a,profil).
teaches(a,ma).
teaches(b,bio).
teaches(b,ma).
teaches(c,ge).
teaches(c,profil).
teaches(d,en).
teaches(d,grw).
teaches(e,de).
teaches(e,mu).
teaches(f,de).
teaches(f,ku).
teaches(g,en).
teaches(g,ethikreligion).
teaches(h,ethikreligion).
teaches(h,spo).
teaches(i,ethikreligion).
teaches(i,de).
teaches(j,ma).
teaches(j,ch).
teaches(k,ma).
teaches(k,geo).
teaches(l,de).
teaches(l,en).
teaches(m,spo).
teaches(m,fremd).
teaches(n,en).
teaches(n,fremd).
teaches(o,tuc).
teaches(o,info).


room(1). specialRoom(1, spo).
room(10). specialRoom(10, inf).
room(11). specialRoom(11, tuc).
room(12).
room(13).
room(20). specialRoom(20, ch).
room(21). specialRoom(21, ph).
room(22). specialRoom(22, bio).
room(30).
room(31).
room(32).
room(33).
room(40). specialRoom(40, ku).
room(41). specialRoom(41, mu).
room(42).
room(43).


weekday(mo). weekday(di). weekday(mi). weekday(do). weekday(fr).

slot(mo, 1, 2). slot(mo, 2, 1). slot(mo, 3, 2). slot(mo, 4, 1). slot(mo, 5, 1). slot(mo, 6, 2).
slot(di, 1, 2). slot(di, 2, 1). slot(di, 3, 2). slot(di, 4, 1). slot(di, 5, 1). slot(di, 6, 2).
slot(mi, 1, 2). slot(mi, 2, 1). slot(mi, 3, 2). slot(mi, 4, 1). slot(mi, 5, 1).
slot(do, 1, 2). slot(do, 2, 1). slot(do, 3, 2). slot(do, 4, 1). slot(do, 5, 1). slot(do, 6, 2).
slot(fr, 1, 2). slot(fr, 2, 1). slot(fr, 3, 2). slot(fr, 4, 1). slot(fr, 5, 1).


