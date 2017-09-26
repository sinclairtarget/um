% UM(1)
% Sinclair Target `<sinclairtarget@gmail.com>`
% September 26, 2017
# NAME
um -- Create your own man pages

# SYNOPSIS
**um** [-t *topic* | --topic *topic*] *pagename*\
**um** [-h | --help] [-v | --version]
**um** *subcommand* [OPTIONS ...]

# DESCRIPTION
**um** helps you create and manage your own personal collection of man pages.
These custom man pages are called um pages, though by default they look exactly
like man pages and are indeed viewed using the **man** utility. You can record
what you know about a command in an um page so that you can refer back to it
later without wading through all the information in the offical man page for
that command.

**um** can be invoked on its own or in conjunction with a subcommand. Invoking
**um** on its own is equivalent to invoking **um read**. You must provide a
*pagename* argument that tells **um** which page you want to display.

For more information about the available subcommands, refer to the SEE ALSO
section below.

# OPTIONS
These options are accepted by **um** when no subcommand is specified:

-v, --version
: Display the version number, or 'unknown' if the version is not known.

-h, --help
: Display help information, including a list of subcommands.

-t, --topic
: Set the topic for this invocation of **um**. **um** will then assume that
*pagename* refers to a page under this topic.

# FILES
**um** can be configured using a configuration file stored at
**~/.um/umconfig**. See README.md for more information about how to set
configuration options. See um-config(1) for information about how to view the
current configuration.

**um** can also make use of template files stored under **~/.um**. See
README.md for more information about template files.

# ENVIRONMENT
See um-config(1) for more information about the environment variables accessed
by **um**.

# SEE ALSO
um-config(1), um-help(1), um-list(1), um-edit(1), um-read(1), um-topic(1),
um-topics(1), um-rm(1)
