# pyscripts

use the `interpretation.py` script as follows:

`python interpretation.py /path/to/first/file.asp ... /path/to/last/file/lastfile.lp number-of-models`

to let clingo solve for as much as `number-of-models` stable models using the given files.

`number-of-models` cannot be omitted.

It is going to create/overwrite the content inside a `csv` folder in the same directory as the script.
