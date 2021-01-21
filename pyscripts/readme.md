# pyscripts

## `interpretation.py`

use the `interpretation.py` script as follows:

`python interpretation.py [space seperated asp files] number-of-models`

e.g. `python interpretation.py test.asp test2.lp 3`

to let clingo solve for as much as `number-of-models` stable models using the given files.

`number-of-models` cannot be omitted.

It is going to create/overwrite the content inside a `solutions` folder in the same directory as the script.  
It will contain one numerated folder for each solution which is split into timetables for each class, teacher and room.
There is also going to be an `asp` file which contains the whole timetable.

## `util/csvhandler.py`

use the `util/csvhandler.py` script as follows:

`python csvhandler.py folder/containing/csvs file.asp`

where the given folder has to contain the same `csv` files as in `bsp1` with the same formatting.  
It will print the corresponding `asp` atoms, rules, etc to the specified file.

## `reschedule.py`

use the `reschedule.py` script as follows:

`python reschedule.py folder/containing/asps solution.asp`

where the given folder has to contain `knowledgeBase.asp`, `timetableConstrains.asp` and `timetableOptimization.asp` and
the `solution.asp` has to be the file containing the timetable asp file currently in use.  
It will create a subfolder `rescheduled` containing the newly found timetables with the user-defined restrictions.
