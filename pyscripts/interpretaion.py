#!/usr/bin/env python3

import clingo
import sys


class Answers:
    models = []

    def on_model(self, model):
        self.models.append(model)
        print("Answer: {}".format(model))

    def get(self):
        return self.models


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

    answers = Answers()
    ctl.solve(on_model=answers.on_model)


if __name__ == '__main__':
    main()
