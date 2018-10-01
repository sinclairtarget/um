# um-rm(1) -- Remove um pages
{:data-date="September 26, 2017"}

## SYNOPSIS
**um rm** [-t *topic* | --topic *topic*] *pagename* \\
**um rm** [-h \| --help]

## DESCRIPTION
This subcommand deletes um pages. It will ask you for confirmation before
actually deleting any files.

## OPTIONS
-h, --help
: Displays help information for this subcommand.

-t, --topic
: Override the current topic for this invocation of **um**. **um** will then
assume that *pagename* refers to a page under this topic.

## SEE ALSO
um(1), um-config(1), um-help(1), um-list(1), um-read(1), um-edit(1),
um-topic(1), um-topics(1)

## AUTHORS
Sinclair Target `<sinclairtarget@gmail.com>`.
