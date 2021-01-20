import os

HTML_HEAD = [
    '<style>',
    'table, th, td {',
    'border: 1px solid black;',
    'border-collapse: collapse;',
    'padding: 0.5em;',
    '}',
    'th {'
    'font-weight: bold;'
    '}',
    '</style>',
    '<table><thead>',
    '<tr><td>Slot</td><td>Mo</td><td>Di</td><td>Mi</td><td>Do</td><td>Fr</td></tr>',
    '</thead><tbody>',
]
HTML_FOOT = [
    '</tbody></table>',
]


def write_group(path, file_name, dicts):
    os.makedirs(path, exist_ok=True)
    with open(os.path.join(path, file_name), 'w', newline='') as html_file:
        rows = list()
        # The slots are the keys of the "dicts" dict, we want to iterate from 1 to last slot
        for slot in range(1, max(dicts.keys())+1):
            # Cells of a row for every day of the week
            row = [str(slot)]
            for weekday in range(1, 6):
                try:
                    t = dicts[slot][weekday]
                    cell = f"{t['grade']}{t['class']}<br/><b>{t['subject']}</b><br/>{t['teacher']}<br/>{t['room']}"
                except KeyError:
                    cell = ""
                row.append(cell)
            # Row to string
            rows.append("<tr><td>" + "</td><td>".join(row) + "</td></tr>")
        doc = "\n".join(HTML_HEAD) + "\n" + "\n".join(rows) + "\n" + "\n".join(HTML_FOOT)
        html_file.write(doc)


"""
def html_structure(solutions_path):
    _, folders, _ = os.walk(solutions_path)
    for folder in folders:
        abs_folder = os.path.join(solutions_path, folder)

"""
