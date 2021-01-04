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

    def interpret(self, model):
        symbols = model.symbols(terms=True)
        teachers = self.interpret_teachers(symbols)
        classes = self.interpret_classes(symbols)
        rooms = self.interpret_rooms(symbols)

        return teachers, classes, rooms

    def interpret_teachers(self, symbols):
        pass

    def interpret_classes(self, symbols):
        pass

    def interpret_rooms(self, symbols):
        pass


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
