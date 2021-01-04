#!/usr/bin/env python3
import os
from typing import List

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
    @staticmethod
    def interpret(model):
        symbols = model.symbols(shown=True)
        teachers = Interpreter.group_teachers(symbols)
        classes = Interpreter.group_classes(symbols)
        rooms = Interpreter.group_rooms(symbols)

        return teachers, classes, rooms

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
    def interpret_teachers(teachers):
        teachers_csv = {}
        for teacher, rules in teachers.items():
            timetable_csv = [{}, {}, {}, {}, {}, {}, {}, {}, {}]
            for term in rules:
                t = term.arguments
                row_n = int(str(t[1])) - 1
                old_str = timetable_csv[row_n].get(t[0], "")
                timetable_csv[row_n][t[0]] = old_str + ';' + str(term)
            teachers_csv[teacher] = timetable_csv

        return teachers_csv


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


def main():
    ctl = clingo.Control()
    # read asp program file
    ctl.load(sys.argv[1])
    ctl.configuration.solve.models = sys.argv[2]
    # standard grounding
    ctl.ground([('base', [])])

    with ctl.solve(yield_=True) as handle:
        for model in handle:
            # print(model)
            teachers, classes, rooms = Interpreter.interpret(model)
            teachers_csv = Interpreter.interpret_teachers(teachers)

            for teacher, content in teachers_csv.items():
                CSVWriter.write(os.path.join(current_dir, 'teachers'), 'teacher_' + str(teacher) + '.csv', content)

            break


if __name__ == '__main__':
    main()
