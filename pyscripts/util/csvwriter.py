import csv
import os

from clingo import Number


def write(path, file_name, content):
    fieldnames = [Number(1), Number(2), Number(3), Number(4), Number(5)]
    os.makedirs(path, exist_ok=True)
    with open(os.path.join(path, file_name), 'w', newline='') as csv_file:
        writer = csv.DictWriter(csv_file, delimiter=';', fieldnames=fieldnames)

        writer.writeheader()
        writer.writerows(content)
