import os


def write_classes(path, file_name, dicts):
    os.makedirs(path, exist_ok=True)
    with open(os.path.join(path, file_name), 'w', newline='') as html_file:
        pass
