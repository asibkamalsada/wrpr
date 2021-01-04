#!/usr/bin/env python3
from typing import List

import clingo
import sys

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
                if term.arguments[2] not in teachers:
                    teachers[term.arguments[2]] = []
                teachers[term.arguments[2]].append(term)

        return teachers

    @staticmethod
    def group_classes(terms):
        classes = {}

        for term in terms:
            if term.match('timetable', 7):
                if (term.arguments[3], term.arguments[4]) not in classes:
                    classes[(term.arguments[3], term.arguments[4])] = []
                classes[(term.arguments[3], term.arguments[4])].append(term)

        return classes

    @staticmethod
    def group_rooms(terms):
        rooms = {}

        for term in terms:
            if term.match('timetable', 7):
                if term.arguments[6] not in rooms:
                    rooms[term.arguments[6]] = []
                rooms[term.arguments[6]].append(term)

        return rooms


def main():
    ctl = clingo.Control()
    # read asp program file
    ctl.load(sys.argv[1])
    ctl.configuration.solve.models = sys.argv[2]
    # standard grounding
    ctl.ground([('base', [])])

    handle = ctl.solve(yield_=True)

    for model in handle:
        #print(model)
        teachers, classes, rooms = Interpreter.interpret(model)
        print(teachers)
        print(classes)
        print(rooms)


if __name__ == '__main__':
    main()
