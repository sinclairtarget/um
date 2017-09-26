% UM-READ(1)
% Sinclair Target `<sinclairtarget@gmail.com>`
% September 26, 2017
# NAME
um-read -- Read an um page

# SYNOPSIS
**um read** [-t *topic* | --topic *topic*] *pagename*\
**um read** [-h | --help]

# DESCRIPTION
This subcommand searches for an um page matching *pagename* and displays it.

If the um page is a markdown file with the **.md** extension, then **um** will
first convert the markdown file to **troff** man format before displaying the
page using the **man** command.

Otherwise **um** will simply display the file using the configured pager. See
um-config(1).

# OPTIONS
-h, --help
: Displays help information for this subcommand.

-t, --topic
: Override the current topic for this invocation of **um**. **um** will then
assume that *pagename* refers to a page under this topic.

# SEE ALSO
um(1), um-config(1), um-help(1), um-list(1), um-edit(1), um-topic(1),
um-topics(1), um-rm(1)
