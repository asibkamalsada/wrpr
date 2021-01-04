#!/usr/bin/env python3
import os
from typing import List

import shutil
import clingo
import sys
import csv

current_dir = os.path.dirname(os.path.abspath(__file__))

arg_names: List[str] = [
    'weekday',
    'slot',
    'teacher',
    'grade',
    'class',
    'subject',
    'room'
]


class Interpreter:
    def __init__(self, model):
        self.symbols = model.symbols(shown=True)

        self.model_n = model.number

        self.teachers = Interpreter.group_teachers(self.symbols)
        self.classes = Interpreter.group_classes(self.symbols)
        self.rooms = Interpreter.group_rooms(self.symbols)

        self.teachers_csv = Interpreter.interpret_group(self.teachers)
        self.classes_csv = Interpreter.interpret_group(self.classes)
        self.rooms_csv = Interpreter.interpret_group(self.rooms)

    @staticmethod
    def group_teachers(terms):
        teachers = {}
        for term in terms:
            if term.match('timetable', 7):
                teacher = term.arguments[2]
                if teacher not in teachers:
                    teachers[teacher] = set()
                teachers[teacher].add(term)

        return teachers

    @staticmethod
    def group_classes(terms):
        classes = {}
        for term in terms:
            if term.match('timetable', 7):
                class_ = (term.arguments[3], term.arguments[4])
                if class_ not in classes:
                    classes[class_] = set()
                classes[class_].add(term)

        return classes

    @staticmethod
    def group_rooms(terms):
        rooms = {}
        for term in terms:
            if term.match('timetable', 7):
                room = term.arguments[6]
                if room not in rooms:
                    rooms[room] = set()
                rooms[room].add(term)

        return rooms

    @staticmethod
    def interpret_group(group):
        _csv = {}
        for grouped, rules in group.items():
            timetable_csv = [{}, {}, {}, {}, {}, {}, {}, {}, {}]
            for term in rules:
                t = term.arguments
                row_n = int(str(t[1])) - 1
                if t[0] not in timetable_csv[row_n]:
                    new_str = str(term)
                else:
                    new_str = timetable_csv[row_n][t[0]] + ' ' + str(term)
                timetable_csv[row_n][t[0]] = new_str
            _csv[grouped] = timetable_csv

        return _csv

    def write_full(self):
        self.write_teachers()
        self.write_classes()
        self.write_rooms()

    def write_teachers(self):
        for teacher, content in self.teachers_csv.items():
            CSVWriter.write(os.path.join(current_dir, 'csv', str(self.model_n), 'teachers'),
                            'teacher_' + str(teacher) + '.csv',
                            content)

    def write_classes(self):
        for (grade, class_), content in self.classes_csv.items():
            CSVWriter.write(os.path.join(current_dir, 'csv', str(self.model_n), 'classes'),
                            'class_' + str(grade) + '_' + str(class_) + '.csv',
                            content)

    def write_rooms(self):
        for room, content in self.rooms_csv.items():
            CSVWriter.write(os.path.join(current_dir, 'csv', str(self.model_n), 'rooms'),
                            'room_' + str(room) + '.csv',
                            content)


class CSVWriter:
    @staticmethod
    def write(path, file_name, content):
        os.makedirs(path, exist_ok=True)
        with open(os.path.join(path, file_name), 'w', newline='') as csv_file:
            writer = csv.DictWriter(csv_file, delimiter=';', fieldnames=[
                clingo.Number(1), clingo.Number(2), clingo.Number(3), clingo.Number(4), clingo.Number(5)
            ])

            writer.writeheader()
            writer.writerows(content)


def clean_csvs():
    work_dir = os.path.join(current_dir, 'csv')
    if os.path.exists(work_dir) and os.path.isdir(work_dir):
        shutil.rmtree(work_dir)


def main():
    arg_n = len(sys.argv)
    if arg_n < 3:
        raise TooFewArgumentsException()

    ctl = clingo.Control()
    # read asp program file
    for n in range(1, arg_n - 1):
        ctl.load(sys.argv[n])
    ctl.configuration.solve.models = sys.argv[arg_n - 1]
    # standard grounding
    ctl.ground([('base', [])])

    with ctl.solve(yield_=True) as handle:
        clean_csvs()
        for model in handle:
            # print(model)
            interpreter = Interpreter(model)
            interpreter.write_full()


class TooFewArgumentsException(Exception):
    def __init__(self):
        self.message = 'not enough arguments'


if __name__ == '__main__':
    main()

