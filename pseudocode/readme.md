# Überblick

Nachfolgend die Grundlagen zur Problemmodellierung.

## Grundlagen

Es gibt folgende grundlegenden Objekte, Relationen und Grundregeln:

- Zeitslot
  - Es gibt bestimmte Zeiten, zu denen etwas stattfinden darf
  - Zeiräume haben einen bestimmten **Tag**
  - Zeiträume eines Tages (potentielle Schulstunden) sind durchnummeriert (1, 2, 3, ...)
  - Zeitslots S und T eines Tages folgen aufeinander, wenn T=S+1
  - Ein Zeitslot kann ein oder zwei Zeiteinheiten (Schulstunden zum zählen für Lehrer und Stundentafeln) haben
- Stunde
  - Eine Stunde ist etwas, was zu einer bestimmten Zeit in einem bestimmten Raum stattfindet
  - Für jede Stunde gibt es mindestens einen Lehrer
    - Erstimplementation: jede Stunde hat genau einen Lehrer und Raum
  - Jede Stunde ist einem Kurs zugeordnet
- Kurs
  - Ein Kurs ist eine "Gemeinschaft" aus Lehrer, Klasse und Fach
    - Erstimplementation: kaum Regeln zur Bildung solcher Zuordnungen (Klassenlehrerregel)
    - Realität: Für min. einige Klassen wird ein bestimmter Lehrer vor Erstellung des Stundenplans festgelegt
  - Jede Stunde gehört zu einem Kurs, jeder Kurs hat mindestens eine Stunde
- Fach
  - Begriff sollte selbsterklärend sein
  - Für verschiedene Klassen gibt es je Fach verschiedene Kurse
  - Es ist gegeben, welches Fach in welcher Klassenstufe mit wie vielen Stunden unterrichtet wird (Stundentafel)
    - Entsprechend viele Stunden haben die Kurse in diesen Klassenstufen
- Raum
  - Ein Raum ist ein Ort, in dem zu einer bestimmten Zeit ein bestimmter Kurs stattfinden kann
  - Stunden bestimmter Fächer dürfen nur in bestimmten Räumen stattfinden
- Klassenraum
  - Jede Klasse hat einen Klassenraum
  - In diesem hat sie mindestens eine Stunde mit ihrem Klassenlehrer
- Lehrer
  - Ein Lehrer ist jemand, der ein bestimmtes Fach (und damit Kurse dieses Fachs) unterrichten kann
  - Ein Lehrer hat bestimmte Beschränkungen, die berücksichtigt werden müssen (siehe weitere Grundregeln und Optimierungsregeln)
  - Ein Lehrer kann Klassenlehrer für höchstens eine Klasse sein
- Klassenlehrer
  - Jede Klasse hat einen Klassenlehrer, mit dem sie mindestens einen Kurs hat
- Klasse
  - Eine Klasse ist eine Menge/Gruppe Schüler einer bestimmten Klassenstufe
  - Jede Klasse hat genau einen Klassenraum und genau einen Klassenlehrer (siehe ebenda)
  - Eine Klasse hat Kurse von Fächern gemäß der Stundetafel ihrer Klassenstufe
- Klassenstufe
  - Eine Klassenstufe ist eine Gruppe von Klassen mit den gleichen Vorgeschriebenen Stundentafeln

```
+------------+
|            |
|    +--- Lehrer --------------- Klassenlehrer
|    |                                 |
|    |        Raum ----- Klassenraum   |
|    |         |                   |   |
|    +------- Kurs --------------- Klasse
|             /  \                    |
|            /    \                   |
|           /      \                  |
|        Stunde     \                 |
|          |         \                |
|        Zeit         |               |
|                     |               |
+------------------- Fach ------- Klassenstufe
```

Einige Entitäten haben ein "Kürzel", welches im Logikprogramm als Atom verwendet wird:

- Klassenstufe (5, 6, ...)
- Klasse (a, b, ...)
- Lehrer
- Fächer
- Kurse
- Zeitslots
- Räume

### Zusatzentitäten

Für Optimierungen und Erweiterungen:

- Kursgruppe
  - Eine Gruppe von n Kursen, die für alle m Klassen einer Klassenstufe zum gleichen Zeitpunkt stattfinden
  - n und m können unterschiedlich sein
  - Ziel: Abbildung Ethik/Religion und Profiluntericht
  - m ist im Input enthalten, n muss noch irgendwie rein
- Fächergruppe
  - Eine Fächergruppe ist eine Gruppe/Menge von Fächern
  - Ziel ist, dass die Stunden der Kurse dieser Fächer in möglichst großen Abständen zueinander unterrichtet werden (z.B. Kunst, Musik und Sport oder Sprachen)
  - Kann in der Ertimplementation Ersatzlos ausgelassen werden
- Schüler
  - Ein Schüler ist Mitglied in einer Klasse
  - Für Erweiterung auf Oberstufe elementar, sonst weniger wichtig

### Weitere Grundregeln

- Ein Slot hat 1 oder 2 "Stunden" (zeitlich gesehen)
- Jede Ressource (Klasse, Lehrer, Raum) kann in einem Zeitraum nur einmal genutzt werden
- Jede Stunde muss einen Kurs und einen Raum haben
- Regeln für Lehrer
  - Ein Lehrer unterrichtet maximal n Stunden pro Woche
- Jeder Lehrer hat einen freien Tag
- Ein Lehrer hat maximal zwei Stunden (egal ob Einzel- oder Doppelstunden) hintereinander
- Ein Lehrer hat max. zwei Freistunden hintereinander


## Optimierungsregeln

Regeln, die nach Möglichkeit bei Erstellung des Stundenplans berücksichtigt werden sollten:

1) Blockstunden
  - Einführung Blockstunden als 2 Stunden zusammen (oder ein Slot mit 2 Einheiten, je nachdem was besser performt)
  - Blockstunden gibt es nur zu bestimmten Zeiten
  - Es soll so viel wie möglich als Block unterrichtet werden
2) Es sollte mehr Stunden früh als Nachmittags geben (sowohl für Lehrer als auch für Klassen)
3) Ein Fach nicht zweimal am selben Tag (außer Blockstunden)
4) Keine Freistunden für Klassen
5) Fächer einer Fächergruppe (Musik&Kunst, Sprachen, ...) sollten in möglichst großen Abständen unterrichtet werden
  - Niemals direkt aufeinanderfolgend wegen Sprachen
6) Eine Klasse hat möglichst viele Stunden mit ihrem Klassenlehrer
7) Eine Klasse hat möglichst viele Stunden in einem Klassenraum
8) Möglichst gleichmäßige Anzahl Stunden pro Tag für Klassen
9) Ein Fach sollte in etwa gleichem Maße von den verschiedenen Lehrern unterrichtet werden


## Zweiteilung

Die Planung kann (gedanklich) in zwei Teile geteilt werden, die miteinander gar nicht so viel zu tun haben.

1. Planung von Kursen
  - Welche Kurse hat eine Klasse (gemäß Stundentafel)
  - Welcher Lehrer unterrichtet welchen Kurs
    - Beachtung Workload Lehrer (allg. und je Fach)
    - Beachtung Klassenlehrer unterrichtet min. einen Kurs für seine Klasse
  - Es könnten noch weitere Beschränkungen eingeführt werden
2. Zeitplanung
  - Welche Stunden eines Kurses finden zu welchen Zeitpunkten in welchen Räumen statt

### Für Vertretungspläne

- Stunden mit für diesen Zeitraum ausgefallenen Klassen annulieren
- Stunden mit für diesen Zeitraum ausgefallenen Räumen verlegen (Raum und Zeitraum können sich ändern)
- Stunden mit für diesen Zeitraum ausgefallenen Lehrer vertreten lassen (Lehrer kann sich ändern) wenn möglich, sonst Ausfall
  - Je niedriger desto wichtiger Vertretung (Optimierung)

Separates Programm oder Integration???

## Modularisierung

Für die Erstellung von Stundenplänen:

- inputs
  - Mehrere vom Script generierte Dateien mit den Input-Daten
  - Zeiten
  - Lehrer
  - Räume (Fachräume)
  - Klassen, Klassenlehrer, Klassenräume
  - Stundentafel (Fächer für Klassenstufe)
- common_basics
  - Allgemeine Definitionen
- course_basics
  - Basisregeln für die Planung von Kursen
- course_opt
  - Optimierungen für die Planung von Kursen
- lesson_basics
  - Basisregeln für die Zeitplanung
- lesson_opt
  - Optimierungsregeln für die Zeitplanung

## Variablen und Prädikate

Konsistent verwendete Variablen:
- Y... Klassenstufe
- C... Klasse
- T... Lehrer
- S... Fach
- L... Zeitslot (1, 2, ...)
- W... Wochentag
- R... Raum
- U... Zeiteinheiten

Predikate kursiv (in Sternchen) für gegeben:
- *class(Y, C)* - Klassenstufe, Klassenbezeichnung
- *teacher(T)* - Lehrer
- *teaches(T, S)* - Lehrer unterrichtet Fach
- *classTeacher(T, Y, C)* - Lehrer, class/2 (Klassenstufe, Klasse)
- *maxHours(T, X)* - Lehrer, maximale Anzahl Stunden
- *subject(S)* - Fach
- course(T, Y, C, S) - Lehrer, class/2, Fach
- *subjectTimes(S, Y, X)* - Fach, Klassenstufe, Anzahl Stunden gemäß Stundentafel
- courseHours(T, Y, C, S, H) - course/4, Anzahl dessen Stunden (hergeleitet aus subjectTimes)
- lesson(W, L, T, Y, C, S, R) - Tag, Zeitslot, course/4 (Lehrer, class/2, Fach), Raum
- *room(R)* - Raum
- *specialRoom(R, S)* - Raum, Fach (für das dieser Raum geeignet ist)
- *slot(W, L, U)* - Tag, Zeitslot, Zeiteinheiten
- *weekday(W)* - Wochentag

Hilfspredikate:
- consecutive(W, L1, L2) - Zwei Zeitslots, die aufeinander folgen
- not_teached(S, Y) - Ein Fach, welches in einem bestimmten Jahr nicht unterrichtet wird
- teacherHours(T, H) - Anzahl Stunden eines Lehrers











