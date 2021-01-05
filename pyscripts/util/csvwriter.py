import csv
import os


def write(path, file_name, content, fieldnames):
    os.makedirs(path, exist_ok=True)
    with open(os.path.join(path, file_name), 'w', newline='') as csv_file:
        writer = csv.DictWriter(csv_file, delimiter=';', fieldnames=fieldnames)

        writer.writeheader()
        writer.writerows(content)
