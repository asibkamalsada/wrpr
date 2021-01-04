#!/usr/bin/env python3

import clingo
import sys


class Context:
    def id(self, x):
        return x

    def seq(self, x, y):
        return [x, y]


def main():
    ctl = clingo.Control()
    # read asp program file
    ctl.load(sys.argv[1])
    ctl.configuration.solve.models='0'
    # standard grounding
    ctl.ground([('base', [])])
    with ctl.solve(yield_=True) as handle:
        for m in handle:
            print("Answer: {}".format(m))
        # gives a SolveResult
        result = handle.get()


if __name__ == '__main__':
    main()
