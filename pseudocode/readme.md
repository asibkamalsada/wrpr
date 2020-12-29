# Überblick

Nachfolgend die Grundlagen zum "Modell".

## Grundlagen

Es gibt folgende grundlegenden Objekte, Relationen und Grundregeln:

- Zeitslot
  - Es gibt bestimmte Zeiten, zu denen etwas stattfinden darf
  - Zeiträume haben **Abstände** zueinander
  - Zeiräume haben einen bestimmten **Tag**
  - Ein Zeitslot kann ein oder zwei Zeiteinheiten (quasi Zeitstunden zum zählen für Lehrer und Stundentafeln) haben
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
|------------------- Fach ------- Klassenstufe
```

Einige Entitäten haben ein "Kürzel", welches im Logikprogramm als Atom verwendet wird:

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
- Ein Lehrer hat maximal 4 Stunden hintereinander
- Ein Lehrer hat max. 3 Freistunden hintereinander


## Optimierungsregeln

Regeln, die nach Möglichkeit bei Erstellung des Stundenplans berücksichtigt werden sollten:

- So viel wie möglich als Blockstunden (Slots mit 2 Zeiteinheiten)
- Keine Freistunden für Klassen (zwischendrin)
- Fächer einer Fächergruppe sollten in möglichst großen Abständen zueinander unterrichet werden
  - Möglichst niemals hintereinander (Sprachen)? (Problem wenn "Kernfächer" eine Fächergruppe sind)
- Eine Klasse hat möglichst viele Stunden mit ihrem Klassenlehrer
- Eine Klasse hat möglichst viele Stunden in ihrem Klassenraum
- Möglichst gleichmäßige Anzahl Stunden pro Tag (für Klassen)
- Lehrer eines Faches sollten nicht vollkommen unterschiedliche Auslastungen für das jeweilige Fach haben
  - Sonst könnte es passieren, dass ein Lehrer nur ein Fach unterrichtet
  - Würde obsolet, wenn die Zuweisung Kurse zu Lehrer manuell erfolgt

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

## Predikate

- class/2 - Klassenstufe, Klassenbezeichnung (einmalig, z.B. c4a o.ä.)
- teacher/1 - Lehrer
- teaches/2 - Lehrer unterrichtet Fach
- classTeacher/2 - Lehrer, Klasse
- maxHours/2 - Lehrer, maximale Anzahl Stunden
- subject/1 - Fach
- course/4 - Kursbezeichnung, Lehrer, Klasse, Fach
- subjectTimes/3 - Fach, Klassenstufe, Anzahl Stunden gemäß Stundentafel
- lesson/3 - Kurs, Zeit, Raum
- room/1 - Raum
- slot/3 - Zeitslot, Tag, Zeiteinheiten
- weekday/1 - Tag











