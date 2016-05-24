# um
`um` is a command-line utility for creating and maintaining your own set of `man`-like help pages. 

### Why?
Have you seen how long `curl`'s man page is? How many times have you gone through it trying to figure out 
how to make a POST request?

Man pages are written to be comprehensive, but what humans really need are the bullet points. Use `um`
to write your own `man`-like help pages that reflect what you've learned about a command so far.
That way you have an easy reference for the things you already know are useful.

### An Example
Say you've just reminded yourself how `grep` works for the third time this month. You'd like to hold on to that precious knowledge so you don't have to go digging through the `grep` man page again. You can do that with `um`:
```
$ um edit grep
```
That will open your text editor, allowing you to record everything you want to remember about `grep`. Once you've saved what you've written, you can pull it up again as easily as you would any man page:

```
$ um grep
```
That will open your pager with whatever you might have for `grep`, say:
```
grep - Print lines matching a pattern

grep [options ...] pattern [file ...]
=======================================================================

REGEX SYNTAX
.  	Matches any character.
^  	Anchors pattern to beginning of line.
$  	Anchors pattern to end of line.
[]  Character set. ^ for negation, - for range.

OPTIONS
-r  Recursively search listed directories.

-E  Force grep to behave as egrep, accepting extended REGEXes.

...
```

`um` supports several additional sub-commands. Among them are:
* `um list`, which lists all the um pages you already have. 
* `um rm`, which removes an existing um page. 
* `um topic`, which switches between topic namespaces for your pages, allowing you to keep a separate set of um pages for
css properties, for example.

## Installation
You can install `um` via [Homebrew](http://brew.sh/):
```
$ brew install sinclairtarget/wst/um
```

A bash completion script for `um` is installed to `/usr/local/etc/bash_completion.d`, assuming you're using the default
`brew` prefix. You may need to add the following lines to your `~/.bash_profile` to enable the completion:
```
if [ -f $(brew --prefix)/etc/bash_completion.d/um-completion.sh ]; then
  . $(brew --prefix)/etc/bash_completion.d/um-completion.sh
fi
```

## Help
Refer to `um help` for comprehensive documentation of the sub-commands and options available for `um`.

## Configuration
You can configure `um` using a file called `umconfig` placed in a folder called `.um` in your home directory. The
syntax for setting an option is as follows:
```
<option> = <value>
e.g.
pager = less
```

You can set values for `pager`, `editor`, `default_topic`, and `pages_directory`. The defaults for these options are
`less`, `vi`, `shell`, and `~/.um`, respectively. Before falling back to the defaults, `um` will attempt to read 
the values for `pager` and `editor` from the shell environment (i.e. the `PAGER` and `EDITOR` environment variables) 
if they are not specified in `umconfig`.

So if you wanted to store your um pages in your Dropbox folder, and you prefer emacs to vim, your config file might look
like the following:
```
editor = emacs
pages_directory = /Users/myusername/Dropbox/um
```

## Page Templating
If you place a file called `template.txt` in `~/.um`, that file will serve as the basis for any new um pages you create.
The template is preprocessed so that the following variables are replaced before the file is opened in your editor:
```
$name     (Replaced with the name of the page, which you specify when you call `um edit <page name>`)
$topic    (Replaced with the name of the current topic)
$time     (Replaced with the current time in RFC2822 format)
```

## Tips
If you want to reset the topic to its default whenever you start a new shell,
you can place the following line in your `.bash_profile` or `.bashrc`:
```
um topic -d
```
