% UM-TOPIC(1)
% Sinclair Target `<sinclairtarget@gmail.com>`
% September 26, 2017
# NAME
um-topic -- Get and set the current um topic

# SYNOPSIS
**um topic** [-h | --help] [-d | --default] [topic]

# DESCRIPTION
The current topic determines which set of um pages are in use.

When run without any options or arguments, **um topic** prints the current um
topic.

When a topic is provided as an argument, the current topic is changed to the
provided topic.

# OPTIONS
-h, --help
: Displays help information for this subcommand.

-d, --default
: Sets the topic to the default topic ("shell").

# SEE ALSO
um(1), um-config(1), um-help(1), um-list(1), um-edit(1), um-read(1),
um-topics(1), um-rm(1)
