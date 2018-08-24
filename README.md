# um
`um` is a command-line utility for creating and maintaining your own set of
`man`-like help pages.

### Why?
Have you seen how long `curl`'s man page is? How many times have you gone
through it trying to figure out how to make a POST request?

Man pages are written to be comprehensive, but what humans really need are the
bullet points. Use `um` to write your own `man`-like help pages that reflect
what you've learned about a command so far.  That way you have an easy
reference for the things you already know are useful.

### An Example
Say you've just reminded yourself how `grep` works for the third time this
month. You'd like to hold on to that precious knowledge so you don't have to go
digging through the `grep` man page again. You can do that with `um`:
```
$ um edit grep
```
This will open your text editor, allowing you to record everything you want to
remember about `grep`. Once you've saved what you've written, you can pull it
up again as easily as you would any man page:

```
$ um grep
```
This will open your pager with whatever you might have for `grep`, say:
```

GREP(shell)                        Um Pages                        GREP(shell)


NAME
       grep -- Print lines matching a pattern

SYNOPSIS
       grep [options ...] [file ...]

REGEX SYNTAX
       .      Matches any character.

       ^      Anchors pattern to beginning of line.

       $      Anchors pattern to end of line.

       []     Character set.  ^ for negation, - for range.

OPTIONS
       -r     Recursively search listed directories.

       -E     Force grep to behave as egrep, accepting extended REGEXes.



Um Pages                      September 26, 2017                   GREP(shell)
```

`um` supports several additional sub-commands. Among them are:
* `um list`, which lists all the um pages you already have.
* `um rm`, which removes an existing um page.
* `um topic`, which switches between topic namespaces for your pages, allowing
  you to keep a separate set of um pages for css properties, for example.

### Um Page Format
Man pages were [historically typeset using the `roff` typesetting
system](http://twobithistory.org/2017/09/28/the-lineage-of-man.html). `roff`
was basically an early LaTeX. Writing man pages using `roff` today is not very
fun or intuitive.

Happily, `pandoc` can be used to convert Markdown documents to `roff`-like man
pages. By default, `um` expects you to write your um pages in Markdown so that
it can convert them and pass them to the `man` program to view. You can,
however, elect to just write your um pages as `.txt` files and view them
without going through the `man` program.

Below is the Markdown source that produced the `grep` listing above. Except for
the first three lines, it's all just Markdown:
```markdown
% GREP(shell) Um Pages | Um Pages
%
% September 26, 2017
<!-- ^ The Pandoc "title block" which provides metadata about the page. -->

# NAME <!-- Top-level Markdown headings become man section headings. -->
grep -- Print lines matching a pattern

# SYNOPSIS
**grep** [options ...] <pattern> [file ...]

# REGEX SYNTAX
<!-- Here we're using a "definition list" to get that man page look. -->
.
: Matches any character.

^
: Anchors pattern to beginning of line.

$
: Anchors pattern to end of line.

[]
: Character set. ^ for negation, - for range.

# OPTIONS
-r
: Recursively search listed directories.

-E
: Force grep to behave as egrep, accepting extended REGEXes.

```

See [Configuration](#config) below for more information on changing the default um
page format. See the [Pandoc
Manual](https://pandoc.org/MANUAL.html#pandocs-markdown) for more information
about Pandoc's flavor of Markdown and the formatting options available to you
when you are writing a man page in Markdown.

`um`'s own [man pages](/doc) are written in Markdown and converted using
Pandoc, so they could also make a good reference.

## Installation
`um` is currently available only for MacOS.

You can install `um` via [Homebrew](http://brew.sh/):
```
$ brew install sinclairtarget/wst/um
```

A bash completion script for `um` is installed to
`/usr/local/etc/bash_completion.d`, assuming you're using the default `brew`
prefix. You may need to add the following lines to your `~/.bash_profile` to
enable the completion:
```
if [ -f $(brew --prefix)/etc/bash_completion.d/um-completion.sh ]; then
  . $(brew --prefix)/etc/bash_completion.d/um-completion.sh
fi
```

## Help
Refer to `um help` for comprehensive documentation of the sub-commands and
options available for `um`. Man pages are also available.

<a name="config"></a>
## Configuration
You can configure `um` using a file called `umconfig` placed in a folder called
`.um` in your home directory. The syntax for setting an option is as follows:
```
<option> = <value>
e.g.
pager = less
```

You can set values for `pager`, `editor`, `default_topic`, `pages_directory`,
and `pages_ext`. The defaults for these options are `less`, `vi`, `shell`,
`~/.um`, and `.md` respectively. Before falling back to the defaults, `um` will
attempt to read the values for `pager` and `editor` from the shell environment
(i.e.  the `PAGER` and `EDITOR` environment variables) if they are not
specified in `umconfig`.

Option | Default | Meaning
--- | --- | ---
`pager` | `less` | "Use this pager to view um pages."
`editor` | `vi` | "Use this editor to edit um pages."
`default_topic` | `shell` | Current topic if none is set.
`pages_directory` | `~/.um` | Where to store um pages.
`pages_ext` | `.md` | Unless `.md`, just the extension for your um pages.

The `pager` configuration option is only used when `pages_ext` is not `.md`
(the default). When `pages_ext` is `.md`, then `um` runs the pages through
`pandoc` before passing them to `man`. The pager used by `man` is determined by
the `PAGER` and `MANPAGER` environment variables. See the man page for `man`
for more information.

So, if you wanted to store your um pages in your Dropbox folder, and you prefer
emacs to vim, your config file might look like the following:
```
editor = emacs
pages_directory = /Users/myusername/Dropbox/um
```

You can print the current configuration using `um config`.

Finally, if you want to store your umconfig file in a different location, you
can specify a new `.um` directory using the `UMCONFIG_HOME` environment
variable. Adding `export UMCONFIG_HOME = ~/foo/bar` to your `.bash_profile`,
for example, will cause `um` to look for a file called `umconfig` under
`~/foo/bar` instead of the default `~/.um`.

Specifying `UMCONFIG_HOME` also changes where `um` looks for template files
(see next section).

## Page Templating
If you place a file called `template.md` in `~/.um`, that file will serve as
the basis for any new um pages you create (when `pages_ext` is set to `.md`).
If you have `pages_ext` set to something else, perhaps `.txt`, then you should
create a template file called `template.txt`.

The template file is preprocessed so that the following variables are replaced
before the file is used to create a new um page:

Variable | Substitution
--- | ---
`$name` | The name of the page, which you specify when you call `um edit <page name>`.
`$NAME` | The same as above, but uppercase.
`$topic` | The name of the current topic.
`$time` | The current time in RFC2822 format.
`$date` | The current date as _Month_ _Day_, _Year_.

If you do not have an appropriate template in your `~/.um` directory, `um`
falls back to using its default templates. `um` ships with a default template
for `.md` um pages and `.txt` um pages.

## Tips
If you want to reset the topic to its default whenever you start a new shell,
you can place the following line in your `.bash_profile` or `.bashrc`:
```
um topic -d
```

## Contributing
You must have `pandoc` installed to convert the Markdown man pages (for `um`
itself, that is) to the `roff` format readable by `man`. See
[Rakefile](Rakefile).
