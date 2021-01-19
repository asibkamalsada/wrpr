import csv
import os
import re
import sys

from clingo import Number


def write_group(path, file_name, content):
    fieldnames = [Number(1), Number(2), Number(3), Number(4), Number(5)]
    os.makedirs(path, exist_ok=True)
    with open(os.path.join(path, file_name), 'w', newline='') as csv_file:
        writer = csv.DictWriter(csv_file, delimiter=';', fieldnames=fieldnames)

        writer.writeheader()
        writer.writerows(content)


def read(path, file_name):
    with open(os.path.join(path, file_name), newline='') as csv_file:
        return csv.reader(csv_file, delimiter=',')


subject_room = {
    'Sport': 'gym',
    'Physik': 'physRoom',
    'Kunst': 'artRoom',
    'Chemie': 'chemRoom',
    'Biologie': 'bioRoom',
    'Informatik': 'pcRoom',
    'Musik': 'musicRoom'
}


def csv2asp(path):
    lines = []

    with open(os.path.join(path, 'classes.csv'), newline='') as csv_file:
        c_reader = csv.reader(csv_file, delimiter=',')
        for row in c_reader:
            lines.append(fn('class', row[0], row[1]))
            lines.append(fn('classTeacher', row[2], row[0], row[1]))

    with open(os.path.join(path, 'rooms.csv'), newline='') as csv_file:
        r_reader = csv.reader(csv_file, delimiter=',')
        for row in r_reader:
            lines.append(fn('room', row[0]))
            name = subject_room.get(row[1], 'standardRoom')
            lines.append(fn(name, row[0]))

    with open(os.path.join(path, 'subject_times.csv'), newline='') as csv_file:
        s_reader = csv.reader(csv_file, delimiter=',')
        for row in s_reader:
            lines.append(fn('subject', row[0]))
            for i in range(5, 11):
                # 5th grade is to be found in column 1 etc until 10th grade
                lines.append(fn('subjectTimes', row[0], str(i), row[i - 4]))

    with open(os.path.join(path, 'teachers.csv'), newline='') as csv_file:
        t_reader = csv.reader(csv_file, delimiter=',')
        for row in t_reader:
            lines.append(fn('teacher', row[0]))
            lines.append(fn('teaches', row[0], row[1]))
            lines.append(fn('teaches', row[0], row[2]))

    for weekday in range(1, 6):
        lines.append(fn('weekday', weekday))

    for slot in range(1, 10):
        lines.append(fn('slot', slot))

    lines.append('block(1,2; 4,5; 8,9).')

    # this csv file is not really useful
    with open(os.path.join(path, 'timetable.csv'), newline='') as csv_file:
        tt_reader = csv.reader(csv_file, delimiter=',')
        for row in tt_reader:
            pass

    lines.append('maxHours(X,30) :- teacher(X).')

    return lines


def atom(x):
    return re.sub(r'[^a-z0-9]', '', str.lower(str(x)))


def fn(fun, *args):
    atoms = [atom(x) for x in args]
    if not args:
        raise Exception()

    return fun + '(' + ', '.join(atoms) + ').'


def main():
    lines = csv2asp(sys.argv[1])

    for line in lines:
        print(line)


if __name__ == '__main__':
    main()
