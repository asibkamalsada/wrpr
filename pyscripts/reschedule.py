import os
import sys

import clingo

from util.interpreter import solve_and_write


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


def handle_restrictions(ctl, r_r, t_r):
    for r in r_r:
        ctl.add("base", [], f'blocked({r.arguments[0]}).')
    for t in t_r:
        ctl.add("base", [], f'ill({t.arguments[0]}).')

    ctl.ground([('base', [])])

    print('stop')


def main():
    if len(sys.argv) != 4:
        raise Exception('not enough parameters')

    knowledgeBase = os.path.join(sys.argv[1], 'knowledgeBase.asp')
    subs = os.path.join(sys.argv[1], 'substitutionPlan.asp')
    solution_p = sys.argv[2]

    ctl = clingo.Control()
    # add knowledge base
    ctl.load(knowledgeBase)

    ctl.ground([('base', [])])

    r_r, t_r = extract_restrictions(ctl)

    handle_restrictions(ctl, r_r, t_r)

    ctl.load(subs)
    ctl.load(solution_p)

    ctl.ground([('base', [])])

    solve_and_write(ctl, sol_folder='rescheduled', rule='re', no_=int(sys.argv[3]))


if __name__ == '__main__':
    main()
