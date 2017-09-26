% UM-CONFIG(1)
% Sinclair Target `<sinclairtarget@gmail.com>`
% September 26, 2017
# NAME
um-config -- View the current um configuration

# SYNOPSIS
**um config** [-h | --help] [*option_key*]

# DESCRIPTION
When run without arguments, this subcommand prints the entire configuration
environment.

You can supply the name of a particular option to get only the value set for
that option.

See README.md for more information about the configuration options that can be
set and how to set them.

# OPTIONS
-h, --help
: Display help information for this subcommand.

# ENVIRONMENT
When loading the configuration environment, **um** will check the PAGER and
EDITOR environment variables before falling back to defaults for the **pager**
and **editor** configuration options.

If the **pager** and **editor** configuration options are set explicitly in the
umconfig file, then the PAGER and EDITOR environment variables are ignored.

**um** uses the **man** program to view markdown files that have been converted
to the **troff** man format. In this case the **pager** configuration option is
not consulted. See man(1) for information about how **man** chooses a pager.

# SEE ALSO
um(1), um-help(1), um-list(1), um-edit(1), um-read(1), um-topic(1),
um-topics(1), um-rm(1)
