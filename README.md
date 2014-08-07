cd+
===

Change directories like a pro.

Functionality
-------------

Falls back to `cd` except in the following extra cases:

Jump up to a named parent:

    cd ..name

This jumps up to the first parent with `name` in its name.

Jump to the nearest named directory:

    cd ,name

Performs a search around your current location for the nearest directory (by jumps on the file tree) called `name`. This is pretty slow but should work well whne the distance is low, such as when you're deep inside some source code directory structure.

Installation
------------

Put `cd.sh` somewhere on your system, and add this line to your `.bashrc`:

    alias cd=". cd.sh"
