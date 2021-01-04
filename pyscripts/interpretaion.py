#!/usr/bin/env python3

import clingo
import sys


def on_model(model):
    print("Answer: {}".format(model))


class Context:
    def id(self, x):
        return x

    def seq(self, x, y):
        return [x, y]


def main():
    ctl = clingo.Control()
    # read asp program file
    ctl.load(sys.argv[1])
    ctl.configuration.solve.models = sys.argv[2]
    # standard grounding
    ctl.ground([('base', [])])
    ctl.solve(on_model=on_model)


if __name__ == '__main__':
    main()
