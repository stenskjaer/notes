<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#org2c6b5a8">1. Prelude for the uninitiated</a></li>
<li><a href="#orge585f23">2. Original document must be .docx format</a></li>
<li><a href="#orgb1093b8">3. Navigate to the directory of the document</a></li>
<li><a href="#org03f13ba">4. Convert the Word document with Pandoc</a>
<ul>
<li><a href="#org0e3a5a8">4.1. Installing Pandoc</a></li>
<li><a href="#org2e87e5f">4.2. Running Pandoc and create a tex master file</a></li>
</ul>
</li>
<li><a href="#org3c00385">5. Setup the document for the critical text</a></li>
<li><a href="#org0634a70">6. Insert \pstart &#x2026; \pend</a></li>
<li><a href="#org96c6f56">7. Convert footnotes to critical notes</a>
<ul>
<li><a href="#orge9bc6b6">7.1. The <i>apparatus fontium</i></a></li>
<li><a href="#orgaaba5c6">7.2. The <i>apparatus criticus</i></a></li>
<li><a href="#org6081fa3">7.3. Post-processing</a></li>
<li><a href="#org278d0a0">7.4. Misc. notes</a></li>
</ul>
</li>
</ul>
</div>
</div>

<a id="org2c6b5a8"></a>

# Prelude for the uninitiated

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

    > terminal command

The ">" indicates that the content is a terminal command. Other code examples
(such as LaTeX code) are also shown in the same frames, but unless it is
preceeded by the ">", don't put it into the command line.

The content of these boxes must be pasted into the Terminal and followed by
Enter.

Sometimes you will need to replace some values in the commands. These variable
values are marked with \`<brackets>\` in the commands, like so:

    > perl -p -i.backup -e 's/(.+)\n/\\pstart\n\1\n\\pend\n/g' "<file name>.tex"


<a id="orge585f23"></a>

# Original document must be .docx format

If your file is in \`.doc\`-format, you can convert it by something like the
following:

-   Open the file
-   Choose \`File > Save as &#x2026;\`
-   In “Format” choose “Word document (.docx)”
-   Save the file

This creates a new file in the same location as the old one.


<a id="orgb1093b8"></a>

# Navigate to the directory of the document

Use the \`cd\`-command in the command line to navigate to the documente directory
(you might want to look up the use of \`cd\` and other basic commands in a
[handy guide](https://www.davidbaumgold.com/tutorials/command-line/)).

For example, if you want to go to the directory \`editions/old Word cruft/My
great edition\` in your \`Documents\` directory, write:

    > cd ~/Documents/editions/old\ Word\ cruft/My\ great\ edition/

A handy tip: To avoid writing the whole path of the directory, you can just
write \`cd \` in the Terminal and drag and drop the directory you want to go to
from the Finder onto the Terminal window, and it will write out the directory
for you.


<a id="org03f13ba"></a>

# Convert the Word document with Pandoc

The utility we will use for converting the Word file to LaTeX is the incredible
library of document conversion [Pandoc](http://pandoc.org).


<a id="org0e3a5a8"></a>

## Installing Pandoc

If you have never used Pandoc before, you will need to install it (to test if
you have it installed, try running \`pandoc\` in the command line, if it returns
something like “Command not found: pandoc”, you need to install it).

On Mac OS X you can

-   either install it with a typical installation package from
    [the download page](https://github.com/jgm/pandoc/releases).
-   or install it with the very practical package manager *Homebrew*. If you have
    that installed, simply run \`brew install pandoc\` from the command line.


<a id="org2e87e5f"></a>

## Running Pandoc and create a tex master file

With this conversion we don't want to create a standalone document, as that will
make all the subsequent transformations more difficult. In stead the created
document should then be read by a master tex document containing a preamble.

In the directory of the document, run:

    > pandoc --from=docx --to=latex --wrap=none --output=./output.tex <document-title>.docx

To include this in a master tex file, use the \`\input\`-macro:

Create a master file with this structure in the same directory as the
\`output.tex\` that *Pandoc* has just created:

    \documentclass{book}
    
    % All your preambular material
    
    \begin{document}
    
    \input{output}
    
    \end{document}

Alternatively, \`\include{}\` can be used in the same way. This adds appropriate
pagebreaks before the included document and makes the use of \`\includeonly{}\` in
the preamble possible.

If you run the master file in LaTeX, it should output a document with your
edition.


<a id="org3c00385"></a>

# Setup the document for the critical text

First, include reledmac in the preamble of the master file and add
\`\beginnumbering\` and \`\endnumbering\` around the included document:

    \documentclass{book}
    \usepackage{reledmac}
    % All your other preambular material
    
    \begin{document}
    
    \beginnumbering
    \input{output}
    \endnumbering
    
    \end{document}

You will probably also need to set the language (if not English) with *Polyglossia*:

    \documentclass{book}
    \usepackage{reledmac}
    \usepackage{polyglossia}
    \setmainlanguage{english}
    \setotherlanguage[variant=medieval]{latin}
    % All your other preambular material
    
    \begin{document}
    
    \begin{latin}
    \beginnumbering
    \input{output}
    \endnumbering
    \end{latin}
    
    \end{document}

You might also want to move any possible title material (author, title etc.)
of the edition from the converted tex file (\`output.tex\`) to the master file if
you don't want those lines numbered.


<a id="org0634a70"></a>

# Insert \pstart &#x2026; \pend

For *Reledmac* to create the paragraphs correctly, they should be wrapped in
\`\pstart\` and \`\pend\`

    perl -p -i.backup -e 's/(.+)\n/\\pstart\n\1\n\\pend\n/g' "output.tex"


<a id="org96c6f56"></a>

# Convert footnotes to critical notes

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


<a id="orge9bc6b6"></a>

## The *apparatus fontium*

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
    contains \`\emph{}\`, \`\textbf{}\` and what not.

    > perl -p -i.backup -e 's/(\w+)([.,;:?!{}\[\]]+)?\\footnote{(Boeth|Arist.*?)((?:\{(?-1)\}|[^{}]++)*)}/\\edtext{\1}{\\lemma{}\\Bfootnote{\3\4}}\2/gi' "output.tex"


<a id="orgaaba5c6"></a>

## The *apparatus criticus*

Now, we can try to convert the remaining \`\footnote{}\`s to critical notes,
regardless of whether there is a lemma marker ("]") or not. The assumption is
that the lemma of the text is also contained in the footnote.

    > perl -p -i.backup -e 's/(.+)([.,;:?!{}\[\]]+)?\\footnote{\1 ?(?:{\]})? ?((?:\{(?-1)\}|[^{}]++)*)}/\\edtext{\1}{\\Afootnote{\3}}\2/gi' "output.tex"

TODO:

-   Pattern that will be able to handle entries without any lemmata in the text.
-   Pattern that will substitute long lemmata with \`<first word> &hellip; <last
    word>\` or something similar.


<a id="org6081fa3"></a>

## Post-processing

After running these commands, you are not done.

Some footnotes will probably not be caught by the substitution patterns. This
might lead to tinkering with the regex's, but it cannot catch unpredictable
notes, so don't expect to get everything.

You might also want to update the lemmata of your *apparatus fontium* entries,
as it only refers to the line where the footnote was placed, while you might
want it to refer to an extended reference or quotation.


<a id="org278d0a0"></a>

## Misc. notes

Lav fodnoter med &#x2026; om til formatet med hele passagen i \edtext:
søg efter (1+ ord), en udefineret mængde, (1+ ord) som gengives i \\1
&#x2026; \\2. ; med ]
Det skal have lookback.

    perl -p -e 's/((\w+ \b\w+).*?(\w+))([.,:;?!])?\\footnote{ ?\2 \.\.\. \3\] ((?:\{(?-1)\}|[^{}]++)*)}/ \\edtext{\1}{\\lemma{\2 \\dots{} \3}\\Afootnote{\5}}\4/gi' "testing.tex"
    
    perl -p -e 's/((\w+ \b\w+).*?(\w+))([.,:;?!])?
    
    (\\footnote{ ?)(\w+) \.\.\. (\w+)\] ((?<=\2\1)(?<=.*?)(?<=\3))
    
    ((?:\{(?-1)\}|[^{}]++)*)}/ \\edtext{\1}{\\lemma{\2 \\dots{} \3}\\Afootnote{\5}}\4/gi' "testing.tex"

Der mangler en version uden ].

Tjek for "{plus " og "{minus " som laver fejl, og indsæt {} inden
plus/minus (utestet!)

    perl -p -i.backup -e 's/{ ?(plus|minus)/{{}\1/g'

Til at konvertere \footnote{ lemma note} til \edtext{lemma}{lemma
note}
Tager også højde for tilføjelse af post eller ante før lemma (i \textit{})

    perl -p -i.backup -e 's/\b([\w ]+)([.,;:?!])?\\footnote{ ?(\\textit\{(?:post|ante) \}) ?\1( ?(?:\{(?-1)\}|[^{}]++)*)}/\\edtext{\1}{\\Afootnote{\3\1\4}}\2/gi' "Burley De somno edition til Michael.tex"

Fjern tomme tags

    perl -p -i.backup -e 's/\\[\w]+\{\s+\}/ /ig' filename

