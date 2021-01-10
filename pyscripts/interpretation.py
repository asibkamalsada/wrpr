#!/usr/bin/env python3
import os
from typing import List

import shutil
import clingo
import sys

from pyscripts.util.interpreter import Interpreter

current_dir = os.path.dirname(os.path.abspath(__file__))

arg_names: List[str] = ['weekday', 'slot', 'teacher', 'grade', 'class', 'subject', 'room']


def clean_solutions(directory):
    work_dir = os.path.join(directory, 'solutions')
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
        clean_solutions(current_dir)
        for model in handle:
            # print(model)
            interpreter = Interpreter(model, current_dir)
            interpreter.write_full()


class TooFewArgumentsException(Exception):
    def __init__(self):
        self.message = 'not enough arguments'


if __name__ == '__main__':
    main()
