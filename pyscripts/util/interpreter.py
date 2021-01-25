import os
import re
import shutil
import sys

from clingo import Control
from util import csvhandler
from util import htmlhandler


def group_teachers(terms, rule):
    teachers = {}
    for term in terms:
        if term.match(rule, 7):
            teacher = term.arguments[2]
            if teacher not in teachers:
                teachers[teacher] = set()
            teachers[teacher].add(term)

    return teachers


def group_classes(terms, rule):
    classes = {}
    for term in terms:
        if term.match(rule, 7):
            class_ = (term.arguments[3], term.arguments[4])
            if class_ not in classes:
                classes[class_] = set()
            classes[class_].add(term)

    return classes


def group_rooms(terms, rule):
    rooms = {}
    for term in terms:
        if term.match(rule, 7):
            room = term.arguments[6]
            if room not in rooms:
                rooms[room] = set()
            rooms[room].add(term)

    return rooms


def terms2csv(terms):
    timetable_csv = [{}, {}, {}, {}, {}, {}, {}, {}, {}]
    for term in terms:
        t = term.arguments
        slot = t[0].number
        row_n = t[1].number - 1
        if slot not in timetable_csv[row_n]:
            new_str = str(term)
        else:
            new_str = str(timetable_csv[row_n][slot]) + ' ' + str(term)
        timetable_csv[row_n][slot] = new_str

    return timetable_csv


def terms2dict_field(terms):
    dicts = [term2dict(term) for term in terms]
    tt = dict()
    for _dict in dicts:
        row = tt.get(_dict['slot'], dict())
        if _dict['weekday'] in row:
            print(f"{_dict} overwrites {row[_dict['weekday']]}", file=sys.stderr)
        row[_dict['weekday']] = _dict
        tt[_dict['slot']] = row
    return tt


def term2dict(term):
    d = dict()
    d['weekday'] = int(str(term.arguments[0]))
    d['slot'] = int(str(term.arguments[1]))
    d['teacher'] = str(term.arguments[2])
    d['grade'] = int(str(term.arguments[3]))
    d['class'] = str(term.arguments[4])
    d['subject'] = str(term.arguments[5])
    d['room'] = str(term.arguments[6])
    return d


class Interpreter:
    def __init__(self, model, directory, rule):
        self.directory = directory

        self.rule = rule

        self.symbols = model.symbols(shown=True)

        self.model_n = model.number

        self.teachers = group_teachers(self.symbols, self.rule)
        self.classes = group_classes(self.symbols, self.rule)
        self.rooms = group_rooms(self.symbols, self.rule)

    def write_full(self):
        self.write_group(self.teachers, 'teachers')
        self.write_group(self.classes, 'classes')
        self.write_group(self.rooms, 'rooms')
        self.write_asp()

    def write_asp(self):
        path = os.path.join(self.directory, str(self.model_n))
        os.makedirs(path, exist_ok=True)
        with open(os.path.join(path, f'tt{self.model_n}.asp'), 'w', newline='') as asp_file:
            asp_file.write('. '.join([str(x) for x in self.symbols]) + '.')

    def write_group(self, group, name):
        base_dir = os.path.join(self.directory, str(self.model_n), name)
        for x, terms in group.items():
            filename = f"{name}_{str(x).replace(' ', '')}"

            csvhandler.write_group(os.path.join(base_dir, 'csv'),
                                   filename + '.csv',
                                   terms2csv(terms))

            # print(f'{x}: {terms2dict_field(terms)}')

            htmlhandler.write_group(os.path.join(base_dir, 'html'),
                                    filename + '.html',
                                    terms2dict_field(terms))


def solve_and_write(ctl: Control, sol_folder, rule, no_=0):
    delete_folder(sol_folder)
    ctl.configuration.solve.models = no_
    with ctl.solve(yield_=True) as handle:
        count = 0
        m = 'cancel search with keyboard interrupt if number of models is set to 0 (or wait for it to find an optimum)'
        print(m)
        for model in handle:
            count += 1
            print(f'found model {count}, printing (DO NOT cancel)')
            # print(model)
            interpreter = Interpreter(model, sol_folder, rule)
            interpreter.write_full()


def delete_folder(directory):
    if os.path.exists(directory) and os.path.isdir(directory):
        shutil.rmtree(directory)
