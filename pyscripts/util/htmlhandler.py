import os

html_table = '<style>' \
             'table, th, td {' \
             'border: 1px solid black;' \
             'border-collapse: collapse;' \
             '}' \
             '</style>\n' \
             '<table><thead>\n' \
             '<tr><td>slot</td><td>Mo</td><td>Di</td><td>Mi</td><td>Do</td><td>Fr</td></tr>\n' \
             '</thead><tbody>\n' \
             '<tr><td>1</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td></tr>\n' \
             '<tr><td>2</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td></tr>\n' \
             '<tr><td>3</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td></tr>\n' \
             '<tr><td>4</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td></tr>\n' \
             '<tr><td>5</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td></tr>\n' \
             '<tr><td>6</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td></tr>\n' \
             '<tr><td>7</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td></tr>\n' \
             '<tr><td>8</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td></tr>\n' \
             '<tr><td>9</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td><td>$$$</td></tr>\n' \
             '</tbody></table>'

html_teachers = '<style>' \
                'table, th, td {' \
                'border: 1px solid black;' \
                'border-collapse: collapse;' \
                '}' \
                '.inlineTable {' \
                'display: inline-block;' \
                '}' \
                '<button onclick="collapse(\'{}\')">{}</button>' \
                '<table id=t{} class="inlineTable">' \
                '<thead><tr><td>teachers</td></tr></thead>' \
                '{}' \
                '</table>'


def write_group(path, file_name, dicts):
    os.makedirs(path, exist_ok=True)
    with open(os.path.join(path, file_name), 'w', newline='') as html_file:
        # TODO dynamic range
        h = html_table
        for slot in range(1, 10):
            for weekday in range(1, 6):
                t = dicts.get(slot, {}).get(weekday, None)
                if t:
                    cell = '{} {}<br>{}<br>{}<br>{}'.format(
                        t['grade'], t['class'], t['subject'], t['teacher'], t['room']
                    )
                    h = h.replace('$$$', cell, 1)
                else:
                    h = h.replace('$$$', '', 1)
        html_file.write(h)


"""
def write_index(path):
    os.makedirs(path, exist_ok=True)
    with open(os.path.join(path, 'index.html'), 'w', newline='') as index:
        for sub in next(os.walk(path))[1]:
            teachers = os.path.join(sub, 'teachers', 'html')
            classes = os.path.join(sub, 'classes', 'html')
            rooms = os.path.join(sub, 'rooms', 'html')
            '<a href="{}/html/"'
"""

if __name__ == '__main__':
    pass

"""
def html_structure(solutions_path):
    _, folders, _ = os.walk(solutions_path)
    for folder in folders:
        abs_folder = os.path.join(solutions_path, folder)

"""
