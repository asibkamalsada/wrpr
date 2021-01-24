import os
import re
import sys

import clingo


from util import interpreter
from util.interpreter import solve_and_write


current_dir = os.path.dirname(os.path.abspath(__file__))


def handle_room(rooms):
    return handle(rooms, 'room')


def handle_teacher(teachers):
    return handle(teachers, 'teacher')


def handle(lst, name):
    index = input(f'choose {name} with the index:\n'
                  f'{dict(enumerate(lst))}\n')
    try:
        if int(index) in range(0, len(lst)):
            print(f'{name} "{lst[int(index)]}" added as a restriction')
            return lst[int(index)]
    except ValueError:
        print(f'"{index}" is no valid index')


def extract_restrictions(ctl):
    teachers = [symbolicatom.symbol for symbolicatom in ctl.symbolic_atoms.by_signature('teacher', 1)]

    rooms = [symbolicatom.symbol for symbolicatom in ctl.symbolic_atoms.by_signature('room', 1)]

    t_r = set()
    r_r = set()

    while True:
        another = input('add another restriction? [Y/n]\n')
        if str.lower(another) == 'n':
            break

        option = input('[1] room\n'
                       '[2] teacher\n')
        try:
            option = int(option)
            if option not in range(1, 3):
                raise ValueError()
        except ValueError:
            print('option not found')
            continue

        if option == 1:
            r_r.add(handle(rooms, 'room'))
        if option == 2:
            t_r.add(handle(teachers, 'teacher'))

        print(f'current restrictions: {r_r}, {t_r}\n')

    return r_r, t_r


def handle_restrictions(ctl, r_r, t_r, solution):
    for r in r_r:
        solution = re.sub(
            r"timetable\([^,]+?,[^,]+?,[^,]+?,[^,]+?,[^,]+?,[^,]+?," + re.escape(str(r.arguments[0])) + r"\)\.", "",
            solution)
        prg = f':- timetable(_, _, _, _, _, _, {r.arguments[0]}).'
        ctl.add("base", [], prg)
        # print(prg)
    for t in t_r:
        solution = re.sub(
            r"timetable\([^,]+?,[^,]+?," + re.escape(str(t.arguments[0])) + r",[^,]+?,[^,]+?,[^,]+?,[^)]+?\)\.", "",
            solution)
        prg = f':- timetable(_, _, {t.arguments[0]}, _, _, _, _).'
        ctl.add("base", [], prg)
        # print(prg)

    tts = list(re.findall(r"timetable\([^)]+?\)", solution))
    fst = '{' + '; '.join(tts) + '}.'
    weighted = [f'1@20:{tt}' for index, tt in enumerate(tts, start=1)]
    snd = '#maximize {' + '; '.join(weighted) + '}.'

    ctl.add("base", [], f'{fst}\n{snd}')
    ctl.ground([('base', [])])

    print('stop')


def main():
    if len(sys.argv) != 4:
        raise Exception('not enough parameters')

    knowledgeBase = os.path.join(sys.argv[1], 'knowledgeBase.asp')
    ttConstraints = os.path.join(sys.argv[1], 'timetableConstrains.asp')
    ttOptimization = os.path.join(sys.argv[1], 'timetableOptimization.asp')
    solution_p = sys.argv[2]

    with open(solution_p, 'r') as file:
        solution = file.read()

    ctl = clingo.Control()
    # add knowledge base
    ctl.load(knowledgeBase)

    ctl.ground([('base', [])])

    r_r, t_r = extract_restrictions(ctl)

    handle_restrictions(ctl, r_r, t_r, solution)

    ctl.load(ttConstraints)
    ctl.load(ttOptimization)

    ctl.ground([('base', [])])

    solve_and_write(ctl, 'rescheduled', int(sys.argv[3]))

    interpreter.compare_asps(solution_p, solution_p.replace('solutions', 'rescheduled'))


if __name__ == '__main__':
    main()
