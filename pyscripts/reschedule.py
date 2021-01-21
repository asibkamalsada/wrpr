import sys

import clingo


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


def extract_restrictions():
    ctl = clingo.Control()
    # add knowledge base
    ctl.load(sys.argv[1])

    ctl.ground([('base', [])])

    teachers = [symbolicatom.symbol for symbolicatom in ctl.symbolic_atoms.by_signature('teacher', 1)]

    rooms = [symbolicatom.symbol for symbolicatom in ctl.symbolic_atoms.by_signature('room', 1)]

    restrictions = set()

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
            restrictions.add(handle(rooms, 'room'))
        if option == 2:
            restrictions.add(handle(teachers, 'teacher'))

        print(f'current restrictions: {restrictions}\n')

    return restrictions


def main():
    if len(sys.argv) != 3:
        raise Exception('not enough parameters')

    restrictions = extract_restrictions()


if __name__ == '__main__':
    main()
