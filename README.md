# Wissensrepräsentation: Praktikumsprojekt Stundenplan

## Ablauf Stundenplanerstellung

- Ein Python Script ließt die Eingangsdaten (CSV-Dateien) ein, und erstellt daraus ASP-Dateien mit entsprechenden Fakten
- Ein ASP Programm löst das Problem
- Das Python Script schreibt die Ergebnismenge formatiert und (nach Räumen, Lehrern und Klassen) gruppiert in menschenlesbare Dateien
- Sollte eine Ressource ausfallen, kann die ursprüngliche Ergebnismenge genommen, die Fakten mit nicht vorhandenen Ressourcen entfernt und das 
    ASP-Programm erneut ausgeführt werden

## ASP Modell

Auf die Struktur des Python Scripts soll an dieser Stelle nicht genauer eingegangen werden, da das ASP-Programm der eigentliche Kern ist.

### Entitäten

Es gibt folgende grundlegenden Objekte, Relationen und Grundregeln:

- Schultag (Wochentag)
  - Wochentag, an dem grundsätzlich Stunden stattfinden dürfen
- Zeitslot
  - Ein Zeitpunkt, zu dem an einem Schultag eine Schulstunde stattfinden kann (1. Stunde, 2. Stunde, ...)
  - Zeitslots sind durchnummeriert
  - Zwei Zeitslots N und M folgen aufeinander, wenn M=N+1
- Klassenstufe
  - Eine Klassenstufe ist eine Menge von Klassen mit den gleichen vorgeschriebenen Stundentafeln
  - Die Klassenstufe sind nummeriert
- Klasse
  - Konkrete Klasse einer bestimmten Klassenstufe (z.B. 5a, 5b, 6a, ...)
  - Es kann beliebig viele Klassen innerhalb einer Klassenstufe geben
  - Eine Klasse hat Schulstunden mit Fächern gemäß der Stundetafel ihrer Klassenstufe
  - Eine Klasse hat einen Klassenlehrer, mit dem sie mindestens eine Stunde hat
- Lehrer
  - Ein Lehrer ist jemand, der ein bestimmtes Fach (und damit Kurse dieses Fachs) unterrichten kann
  - Ein Lehrer hat bestimmte Beschränkungen, die berücksichtigt werden müssen (siehe weitere Grundregeln und Optimierungsregeln)
  - Ein Lehrer kann Klassenlehrer für eine Klasse sein
  - Ein Lehrer wird anhand eines Kürzels identifiziert, welches im Logikprogramm als Atom verwendet wird
- Fach
  - Wird von Lehrern für Klassen unterrichtet
  - Es ist gegeben, welches Fach in welcher Klassenstufe mit wie vielen Stunden unterrichtet wird (Stundentafel)
    - Entsprechend viele Stunden müssen alle Klassen dieser Klassenstufe haben
  - Wahlmöglichkeiten werden nicht im Stundenplan abgebildet
    - Zum Beispiel werden Ethik und Religion als ein Fach betrachtet, welches für alle Klassen einer Klassenstufe zum selben Zeitpunkt stattfindet
    - Die Schulleitung kann somit entsprechend der gewählten Fächer verteilen
    - Analog die schulspezifischen Profile
- Raum
  - Selbstsprechend
  - Stunden bestimmter Fächer dürfen nur in bestimmten Räumen stattfinden
- Schulstunde
  - Entspricht einer stattfindenden Schulstunde
  - Gekennzeichnet durch Schultag, Zeitslot, Lehrer, Klasse, Raum
  - Lehrer, Klassen und Räume können zu einem bestimmten Zeitslot an einem bestimmten Tag nicht mehrfach genutzt werden


Relationen als Diagram:

```
Lehrer -------- Klassenlehrer -------- Klasse -------- Klassenstufe
   |                                      |                 |
   |                                      |           Stundentafel
   +----------------+      +--------------+                 |
                    |      |                              Fach
                    |      |                                |
Raum ------------ Schulstunde ------------------------------+
                   /        \
                  /          \
                Tag        Zeitslot
```

### Weitere Grundregeln

- Bestimmte Slots können zu Blockstunden zusammengefasst werden, für welche der selbe Lehrer die selbe Klasse im selben Raum und Fach unterrichtet
- Jede Ressource (Klasse, Lehrer, Raum) kann in einem Zeitslot eines Tages nur einmal genutzt werden
- Ein Lehrer hat eine maximale Zahl Stunden pro Woche, die er unterrichten darf
- Regeln für Klassen
  - Klassen habe keine Freistunden (Zeitslots ohne Schulstunde zwischen Zeitslots mit Schulstunden)
- Regeln für Lehrer
  - Jeder Lehrer hat einen freien Schultag
  - Ein Lehrer hat maximal drei Stunden (egal ob Einzel- oder Doppelstunden) hintereinander
  - Ein Lehrer hat max. zwei Freistunden hintereinander

### Optimierungsregeln

1. Blockstunden
  - Blockstunden gibt es nur zu bestimmten Zeiten
  - Es soll so viel wie möglich als Block unterrichtet werden
2. Es sollte mehr Stunden früh als Nachmittags geben (sowohl für Lehrer als auch für Klassen)
3. Ein Fach nicht zweimal am selben Tag (außer Blockstunden)
4. Fächer einer Fächergruppe (Musik&Kunst, Sprachen, ...) sollten in möglichst großen Abständen unterrichtet werden
  - Niemals direkt aufeinanderfolgend wegen Sprachen
5. Eine Klasse hat möglichst viele Stunden mit ihrem Klassenlehrer
6. Eine Klasse hat möglichst viele Stunden in einem Klassenraum
7. Möglichst gleichmäßige Anzahl Stunden pro Tag für Klassen
8. Lehrer sollten Fächer im etwa gleichem Maß unterrichten

### Prädikate

Prädikate, kursiv (bzw. in Sternchen) für im Input gegeben:
- *slot(S)* - Zeitslot an einem Tag
- *weekday(W)* - Schultag (Wochentag, an dem Schule grundsätzlich stattfindet)
- *room(R)* - Raum
- *class(A, B)* - Klassenstufe und konkrete Klasse, also z.B. `class(5, a)` für Klasse 5a
- *classTeacher(T, Y, C)* - Lehrer, class/2 (Klassenstufe, Klasse)
- *teacher(T)* - Lehrer
- *teaches(T, J)* - Ein Lehrer T unterrichtet ein bestimmtes Fach J
- *subject(J)* - Ein Fach
- *subjectTimes(J, A, X)* - Wie viele Stunden X muss eine Klasse der Klassenstufe A im Fach J unterrichtet werden
- *maxHours(T, X)* - Wie viele Stunden ein Lehrer maxmal unterrichten darf pro Woche
- timetable(W, S, T, A, B, J, R) - Schulstunde mit Wochentag, Zeitslot, Lehrer, class/2 (Klassenstufe, Klasse), Fach, Raum

