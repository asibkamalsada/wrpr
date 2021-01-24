#!/usr/bin/env python3
import os
from typing import List

import clingo
import sys

from util.interpreter import solve_and_write

current_dir = os.path.dirname(os.path.abspath(__file__))

arg_names: List[str] = ['weekday', 'slot', 'teacher', 'grade', 'class', 'subject', 'room']


def main():
    arg_n = len(sys.argv)
    if arg_n < 3:
        raise TooFewArgumentsException()

    ctl = clingo.Control()
    # read asp program file
    for n in range(1, arg_n - 1):
        ctl.load(sys.argv[n])
    # standard grounding
    ctl.ground([('base', [])])

    sol_folder = os.path.join(current_dir, 'solutions')
    ctl.configuration.solve.models = sys.argv[arg_n - 1]
    solve_and_write(ctl, sol_folder, 'timetable', no_=sys.argv[arg_n - 1])


class TooFewArgumentsException(Exception):
    def __init__(self):
        self.message = 'not enough arguments'


if __name__ == '__main__':
    main()
