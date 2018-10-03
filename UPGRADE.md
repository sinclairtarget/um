# Upgrading to 4.0
`um` now uses the Kramdown gem to convert Markdown files into roff man pages.
On the one hand, this is great, because Pandoc was a heavy external dependency.
On the other hand, the Kramdown flavor of Markdown is not the same as the
Pandoc flavor.

If you have a lot of um pages written in Markdown and you are happy using
Pandoc, **I encourage you not to upgrade to 4.0.** You will have to revise your
um pages to make them work with Kramdown. `um` is an extrememly simple program
and is unlikely to change in the future, so you aren't missing anything. The
switch to Kramdown just makes `um` easier to package.

If you want to learn more about how Kramdown expects a Markdown man page to
look, see [this guide](https://kramdown.gettalong.org/converter/man.html).

The old Pandoc format is documented in the Pandoc user's manual, [available
here](https://pandoc.org/MANUAL.html#pandocs-markdown).
