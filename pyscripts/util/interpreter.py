import os
from pyscripts.util import csvhandler


class Interpreter:
    def __init__(self, model, directory):
        self.directory = directory

        self.symbols = model.symbols(shown=True)

        self.model_n = model.number

        self.teachers = Interpreter.group_teachers(self.symbols)
        self.classes = Interpreter.group_classes(self.symbols)
        self.rooms = Interpreter.group_rooms(self.symbols)

        self.teachers_csv = Interpreter.interpret_group(self.teachers)
        self.classes_csv = Interpreter.interpret_group(self.classes)
        self.rooms_csv = Interpreter.interpret_group(self.rooms)

    @staticmethod
    def group_teachers(terms):
        teachers = {}
        for term in terms:
            if term.match('timetable', 7):
                teacher = term.arguments[2]
                if teacher not in teachers:
                    teachers[teacher] = set()
                teachers[teacher].add(term)

        return teachers

    @staticmethod
    def group_classes(terms):
        classes = {}
        for term in terms:
            if term.match('timetable', 7):
                class_ = (term.arguments[3], term.arguments[4])
                if class_ not in classes:
                    classes[class_] = set()
                classes[class_].add(term)

        return classes

    @staticmethod
    def group_rooms(terms):
        rooms = {}
        for term in terms:
            if term.match('timetable', 7):
                room = term.arguments[6]
                if room not in rooms:
                    rooms[room] = set()
                rooms[room].add(term)

        return rooms

    @staticmethod
    def interpret_group(group):
        _csv = {}
        for grouped, rules in group.items():
            timetable_csv = [{}, {}, {}, {}, {}, {}, {}, {}, {}]
            for term in rules:
                t = term.arguments
                row_n = int(str(t[1])) - 1
                if t[0] not in timetable_csv[row_n]:
                    new_str = str(term)
                else:
                    new_str = timetable_csv[row_n][t[0]] + ' ' + str(term)
                timetable_csv[row_n][t[0]] = new_str
            _csv[grouped] = timetable_csv

        return _csv

    def write_full(self):
        self.write_teachers()
        self.write_classes()
        self.write_rooms()

    def write_teachers(self):
        for teacher, content in self.teachers_csv.items():
            csvhandler.write_csv(os.path.join(self.directory, 'csv', str(self.model_n), 'teachers'),
                                 'teacher_' + str(teacher) + '.csv',
                                 content)

    def write_classes(self):
        for (grade, class_), content in self.classes_csv.items():
            csvhandler.write_csv(os.path.join(self.directory, 'csv', str(self.model_n), 'classes'),
                                 'class_' + str(grade) + '_' + str(class_) + '.csv',
                                 content)

    def write_rooms(self):
        for room, content in self.rooms_csv.items():
            csvhandler.write_csv(os.path.join(self.directory, 'csv', str(self.model_n), 'rooms'),
                                 'room_' + str(room) + '.csv',
                                 content)
