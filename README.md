# um
`um` is a command-line utility for creating and maintaining your own set of man-like help pages. 

### Why?
Have you seen how long curl's man page is? How many times have you gone through it trying to figure out 
how to make a POST request?

Man pages are written to be comprehensive, but what humans really need are the bullet points. Use `um`
to write your own man-like help pages that reflect what you have learned about a command so far.
That way you have an easy reference for the things you already know are useful.

### An Example
`man` is easy and quick. `um` tries to be the same:
```
$ um grep
```
That will open your pager with whatever you might have for `grep`:
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

`um` supports several sub-commands, git-style. `um set netstat` will create or edit the um page for netstat. `um list` will
list all the um pages you already have. `um topic css` will set the current topic to "css", because you don't
have to use um exclusively for shell commands.

## Installation
You can install `um` via [Homebrew](http://brew.sh/):
```
brew install sinclairtarget/wst/um
```

## Help
Refer to `um help` for comprehensive documentation of the sub-commands and options available for `um`.

## Configuration
You can configure `um` using a file called `umconfig` placed in a folder called `.um` in your home directory. The
syntax for setting an option as follows:
```
<option> = <value>
e.g.
pager = less
```

You can set values for `pager`, `editor`, `default_topic`, and `pages_directory`. The defaults for these options are
`less`, `vi`, `shell`, and `~/.um`, respectively. Before falling back to the defaults, `um` will attempt to read 
the values for `pager` and `editor` from the shell environment if they are not specified in `umconfig`.

If you place a file called `template.txt` in `.um`, that file will serve as the basis for any new um pages you create.
The template is preprocessed and the following variables will be replaced before the file is opened in your editor:
```
$name     (Replaced with the name of the page, which you specify when you call `um set <page name>`)
$topic    (Replaced with the name of the current topic)
$time     (Replaced with the current time in RFC2822 format)
```

## Tips
If you want to reset the topic to its default whenever you start a new shell,
you can place the following line in your `.bash_profile` or `.bashrc`:
```
um topic -d
```

## Known Issues
If ruby complains about `Config` being obsolete and deprecated...
```
/usr/local/Cellar/um/1.1/lib/um/config.rb:1:in `<top (required)>': Use RbConfig instead of obsolete and deprecated Config.
```
...make sure to update your version of ruby.
