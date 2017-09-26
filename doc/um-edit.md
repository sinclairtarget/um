% UM-EDIT(1)
% Sinclair Target `<sinclairtarget@gmail.com>`
% September 26, 2017
# NAME
um-edit -- Edit an um page

# SYNOPSIS
**um edit** [-t *topic* | --topic *topic*] *pagename*\
**um edit** [-h | --help]

# DESCRIPTION
This subcommand searches for an um page matching *pagename* and opens it in the
configured editor. See um-config(1) for more information about configuring the
editor.

If no page already exists matching *pagename*, then this command creates a new
file based on the template for the currently configured **pages_ext**. See
um-config(1) for more information about this configuration option. See
README.md for more information on page templating.

# OPTIONS
-h, --help
: Displays help information for this subcommand.

-t, --topic
: Override the current topic for this invocation of **um**. **um** will then
assume that *pagename* refers to a page under this topic.

# SEE ALSO
um(1), um-config(1), um-help(1), um-list(1), um-read(1), um-topic(1),
um-topics(1), um-rm(1)
