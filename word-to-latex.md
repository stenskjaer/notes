- [Prelude for the uninitiated](#prelude-for-the-uninitiated)
- [Original document must be .docx format](#original-document-must-be-.docx-format)
- [Navigate to the directory of the document](#navigate-to-the-directory-of-the-document)
- [Convert the Word document with Pandoc](#convert-the-word-document-with-pandoc)
  - [Installing Pandoc](#installing-pandoc)
  - [Running Pandoc and create a tex master file](#running-pandoc-and-create-a-tex-master-file)
- [Setup the document for the critical text](#setup-the-document-for-the-critical-text)
- [Insert \pstart &#x2026; \pend and convert headings](#insert-\pstart-&#x2026;-\pend-and-convert-headings)
  - [Different headings](#different-headings)
- [Convert footnotes to critical notes](#convert-footnotes-to-critical-notes)
  - [The *apparatus fontium*](#the-*apparatus-fontium*)
  - [The *apparatus criticus*](#the-*apparatus-criticus*)
  - [Post-processing](#post-processing)
  - [Misc. notes](#misc.-notes)
- [Additional conversions](#additional-conversions)
  - [Structural numbering schemes](#structural-numbering-schemes)
  - [Folio numbers](#folio-numbers)
- [Wrapping up](#wrapping-up)

# Prelude for the uninitiated<a id="orgheadline1"></a>

This procedure makes use of the so-called *command line* (aka Terminal in Mac OS
X) for running different conversion functions. If you have newer before used the
Terminal application, here is a short crash course.

The terminal is an interface where you can give the computer directions without
having to use the Graphical User Interface of windows that you usually navigate
through with the mouse.

Open the Terminal application by opening Finder, open the Applications directory
and locate the Utilities directory where you will find the Terminal app. *Or*
you can click the Spotlight icon in the top right corner and search for Terminal
and press enter.

All in this guide that need to be executed in the command line look like this:

```shell
$ terminal command
```

The "$" indicates that the content is a terminal command. Other code examples
(such as LaTeX code) are also shown in the same frames, but unless it is
preceeded by the "$", don't put it into the command line.

The content of these boxes must be pasted into the Terminal and followed by
Enter.

Sometimes you will need to replace some values in the commands. These variable
values are marked with `<brackets>` in the commands, like so:

```shell
$ perl -p -i.backup -e 's/(.+)\n/\\pstart\n\1\n\\pend\n/g' "<file name>.tex"
```

# Original document must be .docx format<a id="orgheadline2"></a>

If your file is in `.doc`-format, you can convert it by something like the
following:

-   Open the file
-   Choose `File > Save as ...`
-   In “Format” choose “Word document (.docx)”
-   Save the file

This creates a new file in the same location as the old one.

# Navigate to the directory of the document<a id="orgheadline3"></a>

Use the `cd`-command in the command line to navigate to the documente directory
(you might want to look up the use of `cd` and other basic commands in a
[handy guide](https://www.davidbaumgold.com/tutorials/command-line/)).

For example, if you want to go to the directory `editions/old Word cruft/My
great edition` in your `Documents` directory, write:

```shell
$ cd ~/Documents/editions/old\ Word\ cruft/My\ great\ edition/
```

A handy tip: To avoid writing the whole path of the directory, you can just
write ~cd ~ in the Terminal and drag and drop the directory you want to go to
from the Finder onto the Terminal window, and it will write out the directory
for you.

# Convert the Word document with Pandoc<a id="orgheadline6"></a>

The utility we will use for converting the Word file to LaTeX is the incredible
library of document conversion [Pandoc](http://pandoc.org).

## Installing Pandoc<a id="orgheadline4"></a>

If you have never used Pandoc before, you will need to install it (to test if
you have it installed, try running `pandoc` in the command line, if it returns
something like “Command not found: pandoc”, you need to install it).

On Mac OS X you can

-   either install it with a typical installation package from
    [the download page](https://github.com/jgm/pandoc/releases).
-   or install it with the very practical package manager *Homebrew*. If you have
    that installed, simply run `brew install pandoc` from the command line.

## Running Pandoc and create a tex master file<a id="orgheadline5"></a>

With this conversion we don't want to create a standalone document, as that will
make all the subsequent transformations more difficult. In stead the created
document should then be read by a master tex document containing a preamble.

In the directory of the document, run:

```shell
$ pandoc --from=docx --to=latex --wrap=none --output=./output.tex <document-title>.docx
```

To include this in a master tex file, use the `\input`-macro:

Create a master file with this structure in the same directory as the
`output.tex` that *Pandoc* has just created:

```latex
\documentclass{book}

% All your preambular material

\begin{document}

\input{output}

\end{document}
```

Alternatively, `\include{}` can be used in the same way. This adds appropriate
pagebreaks before the included document and makes the use of `\includeonly{}` in
the preamble possible.

If you run the master file in LaTeX, it should output a document with your
edition.

# Setup the document for the critical text<a id="orgheadline7"></a>

First, include reledmac in the preamble of the master file:

```latex
\documentclass{book}
\usepackage{reledmac}
% All your other preambular material

\begin{document}

\input{output}

\end{document}
```

You will probably also need to set the language (if not English) with *Polyglossia*:

```latex
\documentclass{book}
\usepackage{reledmac}
\usepackage{polyglossia}
\setmainlanguage{english}
\setotherlanguage[variant=medieval]{latin}
% All your other preambular material

\begin{document}

\begin{latin}
\input{output}
\end{latin}

\end{document}
```

You might also want to move any possible title material (author, title etc.)
of the edition from the converted tex file (`output.tex`) to the master file if
you don't want those lines numbered.

In the converted text (here called `output.tex`) you need to add
`\beginnumbering` before the first text paragraph and `\endnumbering` after the
last. It could be done automatically, but it is simpler to do it manually.

# Insert \pstart &#x2026; \pend and convert headings<a id="orgheadline9"></a>

For *Reledmac* to create the paragraphs correctly, they should be wrapped in
`\pstart` and `\pend`. This could usually be done like this:

```shell
$ perl -p -i.backup -e 's/(.+)\n/\\pstart\n\1\n\\pend\n/g' "output.tex"
```

However, if you have an edition where headings are not marked with a separate
typographical class in the Word, your headings will also be part of the text
wrapped in `\pstart` and `\pend`. If however they can be identified with a
unique pattern, we can skip those in this process and change them into headings
later.

For instance, assume that the two first levels look like this:

-   **Level 1:** “<~LECTIO 1~>” (the ~ is a unbreakable space that Pandoc inserts).
-   **Level 2:** “< Proeomium >”

We skip those in the processing by replacing the above command with this:

```shell
$ perl -p -i.backup -e 'm/\\textless\{\}[~ A-Za-z0-9]+\\textgreater\{\}/ ? s/(.+)/\1/ : s/((?<!\\textless\{\}~\w).+)\n/\\pstart\n\1\n\\pend\n/g' "output.tex"
```

This command is a bit complex, but what it basically says is “for each line, if
this line starts with the specified heading pattern, skip it, otherwise wrap it
in `\pstart` and `\pend`.” Now let's convert those headings too.

## Different headings<a id="orgheadline8"></a>

Before we get started, we must get the objective straight. We want to convert
the different levels of headings to the appropriate LaTeX commands, and since
headings can't be in a numbered environment, we will also have to wrap the
sections in `\endnumbering` and `\beginnumbering`.

So, to match the first level, we can use the following regex
`\\textless\{\}~([A-Z0-9 ]+)~\\textgreater\{\}`.

Some short notes:

-   Some charactes have special functions in regex, so if you want to match those,
    they much be escaped with the "\\". This explains "\\\\", "\\{", and "\\}".
-   The text of the heading is matched with the "[A-Z0-9 ]". The "[" and "]" open
    and close so-called character classes. This means it matches all the
    characters designated by the brackets. Here it means "all uppercase letters
    from A to Z", "all numbers between 0 and 9" as well as all spaces (notice the
    " " in the brackets). The subsequent "+" means "one or more times". So any
    combination of spaces, uppercase letters and numbers will be matched.
-   The matched text is surrounded by parentheses. This means that the content of
    the match can be referred in the substitution pattern. The content of each
    consecutive parenthesis is numbered according to its location in the string.
    There is only one here, so it will be printed by writing "\\1" in the
    substitution pattern.

If we want the substitution to create a `\section*{}`, we can do like this:
`\\section\*\{\1\}`.

Now we assemble it in the substitution command in perl. The syntax is the
following: `s/<match pattern>/<substitution pattern/g`. The initial "s" tells
the program that we want it to Subsitute the first pattern by the second. The
final *modifier* "g" signify that the match is Global (substitution more
than one instance in a line).

The complete command thus looks like this:
='s/\\\textless\\{\\}~(.+?)~\\\textgreater\\{\\}/\\\section\\\*\\{\\1\\}/g'=

To run this substitution from the command line, add `perl -p -i.backup -e`
before the pattern and the filename after the pattern. The pattern itself should
be enclosed in quotation marks.

So all told, it looks like this:

```shell
$ perl -p -i.backup -e 's/^\\textless\{\}~([A-Z0-9 ]+)~\\textgreater\{\}/\n\\endnumbering\n\\section\*\{\1\}\n\\beginnumbering\n/g' output.tex
```

This will convert something like this:

```latex
\textless{}~LECTIO I~\textgreater{}
```

Important note: If you are at the top of the document (before the main text and
the first `\beginnumbering` that you inserted manually, you should delete the
`\endnumbering` and `\beginnumbering` that wrap the first headings. They should
only wrapt the headings *inside* the main text.

**The level two headings**

Applying the same principle to the second level, the match pattern could look
like this: `\\textless\{\} ([A-Za-z0-9 ]+) \\textgreater\{\}`. To make the whitespace
facultative, we can add a "?" after it in the pattern: `\\textless\{\} ?(.+?)
?\\textgreater\{\}`. Notice that we add lowercase letters as a character class.

We will make this a subsection in the document with the following complete
command:

```shell
$ perl -p -i.backup -e 's/^\\textless\{\} ?([A-Za-z0-9 ]+) ?\\textgreater\{\}/\\endnumbering\n\\subsection\*\{\1\}\n\\beginnumbering/g' output.tex
```

Now we have converted the headings, and if you run the document, it should build
without any errors.

This also made it up for a short *Perl regular expressions 101*. For much more
on the perl regular expression capabilities, see [the documentation](http://perldoc.perl.org/perlre.html).

# Convert footnotes to critical notes<a id="orgheadline14"></a>

*A technical aside:*
This is the tricky part as the successful conversion of the footnotes is
contingent upon the following [regular expressions](https://en.wikipedia.org/wiki/Regular_expression) (or regex's). This means you
might have to fiddle with the regex's to make the match the way your footnotes
are formatted. This might require a bit of study to get that working. Some
resources if that gets necessary:

-   <http://regexr.com/>: Test and experiment with regex's interactively.
-   <http://perldoc.perl.org/perlrequick.html>: A somewhat in depth quick guide to
    regex's in Perl.
-   <http://perldoc.perl.org/perlre.html>: The documentation of regular expressions
    in Perl. Comprehensive, but good.
-   <http://www.rexegg.com/>: Fun with Rex.
-   Finally: The incredible *Mastering Regular Expressions* by Jeffrey E.F. Friedl
    is the goto place, if you want to go deep. See
    <http://shop.oreilly.com/product/9780596528126.do>.

## The *apparatus fontium*<a id="orgheadline10"></a>

Now, first we create the *apparatus fontium*, as the *apparatus criticus* might
catch some of the *fontium* matches as false positives (as that regex is more
voracious).

In the match pattern, the values separated by "|" after "footnote{(" is a list
of possible abbreviated authority names that constitute a fontium reference. All
footnotes beginning with one of those strings will be converted to *fontium*
entries.

These following expressions are complex.
They take the following possibilities into consideration:

-   variable whitespace in different parts of the footnote,
-   punctuation and command characters (.,;:?! and {}[]) following the text. This
    is moved after the edtext command.
-   In the footnote any level of LaTeX commands will be included (in case the note
    contains `\emph{}`, `\textbf{}` and what not.

```bash
$ perl -p -i.backup -e 's/(\w+)([.,;:?!{}\[\]]+)?\\footnote{(Boeth|Arist.*?)((?:\{(?-1)\}|[^{}]++)*)}/\\edtext{\1}{\\lemma{}\\Bfootnote{\3\4}}\2/gi' "output.tex"
```

## The *apparatus criticus*<a id="orgheadline11"></a>

Now, we can try to convert the remaining ~\footnote{}~s to critical notes,
regardless of whether there is a lemma marker ("]") or not. The assumption is
that the lemma of the text is also contained in the footnote.

```bash
$ perl -p -i.backup -e 's/(.+)([.,;:?!{}\[\]]+)?\\footnote{\1 ?(?:{\]})? ?((?:\{(?-1)\}|[^{}]++)*)}/\\edtext{\1}{\\Afootnote{\3}}\2/gi' "output.tex"
```

Note that this conversion does not handle references that are not to a specific
lemma in the text. For example, if a witness contains an edition that the editor
chooses not to include in the established text, it cannot be referenced in the
apparatus. Often that would be solved with a note along the lines of
“significante *post* impositionis *add. M in marg./”. These empty lemmata are
handled by /reledmac* by the following encoding:
`\edtext{}{\lemma{}\Afootnote{significante \emph{post} impositionis \emph{add. M
in marg.}}`.

To avoid extra space and lemma markers (such as for instance “]”) after empty
lemmata, the following commands can be used in the preamble:

```latex
\Xnolemmaseparator[A] % Only applies to the Afootnote-series
\Xinplaceoflemmaseparator{0pt}
```

If you have many of these empty lemma notes, and they are formatted in a
relatively consistent way, you can cook up a regex to handle those situations.

TODO:

-   Pattern that will substitute long lemmata with `<first word> \dots{} <last
      word>` or something similar.

## Post-processing<a id="orgheadline12"></a>

After running these commands, you are not done.

Some footnotes will probably not be caught by the substitution patterns. This
might lead to tinkering with the regex's, but it cannot catch unpredictable
notes, so don't expect to get everything.

You might also want to update the lemmata of your *apparatus fontium* entries,
as it only refers to the line where the footnote was placed, while you might
want it to refer to an extended reference or quotation.

## Misc. notes<a id="orgheadline13"></a>

Lav fodnoter med &#x2026; om til formatet med hele passagen i \edtext:
søg efter (1+ ord), en udefineret mængde, (1+ ord) som gengives i \\1
&#x2026; \\2. ; med ]
Det skal have lookback.

```bash
perl -p -e 's/((\w+ \b\w+).*?(\w+))([.,:;?!])?\\footnote{ ?\2 \.\.\. \3\] ((?:\{(?-1)\}|[^{}]++)*)}/ \\edtext{\1}{\\lemma{\2 \\dots{} \3}\\Afootnote{\5}}\4/gi' "testing.tex"

perl -p -e 's/((\w+ \b\w+).*?(\w+))([.,:;?!])?

(\\footnote{ ?)(\w+) \.\.\. (\w+)\] ((?<=\2\1)(?<=.*?)(?<=\3))

((?:\{(?-1)\}|[^{}]++)*)}/ \\edtext{\1}{\\lemma{\2 \\dots{} \3}\\Afootnote{\5}}\4/gi' "testing.tex"
```

Der mangler en version uden ].

Tjek for "{plus " og "{minus " som laver fejl, og indsæt {} inden
plus/minus (utestet!)

```bash
perl -p -i.backup -e 's/{ ?(plus|minus)/{{}\1/g'
```

Til at konvertere \footnote{ lemma note} til \edtext{lemma}{lemma
note}
Tager også højde for tilføjelse af post eller ante før lemma (i \textit{})

```bash
perl -p -i.backup -e 's/\b([\w ]+)([.,;:?!])?\\footnote{ ?(\\textit\{(?:post|ante) \}) ?\1( ?(?:\{(?-1)\}|[^{}]++)*)}/\\edtext{\1}{\\Afootnote{\3\1\4}}\2/gi' "Burley De somno edition til Michael.tex"
```

Fjern tomme tags

```bash
perl -p -i.backup -e 's/\\[\w]+\{\s+\}/ /ig' filename
```

# Additional conversions<a id="orgheadline17"></a>

Some additional transformations might be in place. You might want to distinguish
other structural units. This naturally requires some custom regular expressions,
but some examples can be given here.

## Structural numbering schemes<a id="orgheadline15"></a>

Let's say we also add some helpful structural numbers in the format “<1.>” or
“<1.3.2>” representing different structural levels of a text.

We could convert this to a custom macro called `\no{}` like this:

```shell
$ perl -p -i.backup -e 's/\\textless\{\} ?([0-9. ]+) ?\\textgreater\{\}/\\no{\1\}/g' output.tex
```

The matched characters will be all numbers between 0 and 9, "." and " ".

Now we just need a custom macro to format these structural additions. The this
to your preamble

```latex
\newcommand{\no}[1]{\textless{}#1\textgreater{}\quad}
```

## Folio numbers<a id="orgheadline16"></a>

Let's say we mark changes in a witness folio with the following formatting: “|
42rb |”. How do we make those marks into marginal notes?

Converted in Pandoc, the folio mark would probably look (something) like this:
`\textbar{}~42ra~\textbar{}`

We want to convert it into this command `\textbar{}\ledsidenote{42ra}`.

We match the pattern like this: `/\\textbar\{\}~([0-9rvab]+)~\\textbar\{\}/`.
The brackets with the character classes only contain what is relevant for a
folio reference, that is all numbers and one or more of the letters "abrv".
There is no reason for risking overcapturing

But oddly enough, Pandoc sometimes marks the non-breakable space as bold
(`\textbf{}`), which we also want to match:
`/\\textbar\{\}(\textbf\{)?~\}?[0-9abrv]+(\textbf\{)?~\}?\\textbar\{\}/`.
Here the parenthesis around `\\textbf\{` makes it into a demarcated group (like
in maths) which the following question mark makes optional.

But we also want to capture the content of the folio reference, and this is also
done with the parentheses. So to avoid having to count parentheses that we don't
need as match groups, we can make some a parenthesis “anonymous” by adding `?:`
to its beginning. Then it won't be available as a reference group. Of course, we
don't do this with the relevant parenthesis, that matches the content of the
reference, so it looks like this:
`\\textbar\{\}(?:\textbf\{)?~\}?([0-9abrv]+)(?:\\textbf\{)?~\}?\\textbar\{\}`.

Finally, we also want to capture those instances of the reference where we were
a bit inconsistent ad wrote the folio side and column in superscript. Hold on,
because now it gets a bit hairy:
`\\textbar\{\}(?:\textbf\{)?~\}?([0-9]+)(:?\\textsuperscript\{)?([abrv]+)\}?(?:\\textbf\{)?~\}?\\textbar\{\}`.

Although this looks like gibberish, it actually works! For more material on
matching and non-matching groups and backreferencing, see [the Perl documentation](http://perldoc.perl.org/perlretut.html#Non-capturing-groupings)
where you can also read about named match groups and much more.

Piecing it together with a substitution pattern, we can do like this:

```shell
perl -p -i.backup -e 's/\\textbar\{\}(?:\textbf\{)?~\}?([0-9]+)(?:\\textsuperscript\{)?([abrv]+)\}?(?:\\textbf\{)?~\}?\\textbar\{\}/\\textbar\{\}\\ledsidenote{\1\2} /g' output.tex
```

And even better, since we distinguished the folio numbers from the side and
column, we can make the consistently superscript, if we want:

```shell
perl -p -i.backup -e 's/\\textbar\{\}(?:\textbf\{)?~\}?([0-9]+)(?:\\textsuperscript\{)?([abrv]+)\}?(?:\\textbf\{)?~\}?\\textbar\{\}/\\textbar\{\}\\ledsidenote{\1\\textsuperscript\{\2\}} /g' output.tex
```

# Wrapping up<a id="orgheadline18"></a>

This conversions might not be sufficient for your needs, and it is not unlikely
that there is still a lot of work to be done with the apparatus. But at least
this will get you started and get your old Word editions into the infinitely
more flexible (although maybe also a bit more complex) format of LaTeX.

Of course you are also just getting started configuring your *reledmac* setup
and going through the critical apparatus.

Stiching it all together in a script can be tempting. But we will leave that as
an individual assignment.
