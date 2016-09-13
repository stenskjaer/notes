# A Framework for digital editions and translations


Executive summary:

> My work within digital editing and translation theory aims at establishing a
> framework that will make it possible to establish born digital critical
> editions and research translations in an easy, robust and distributed manner.
> These efforts should make the creation and curation of such texts more
> flexible and systematic, while completely new avenues of analysing and
> interacting with such texts will be opened up.


## Goal and elements
The goal is a framework for creating born digital critical editions
and translations of philosophical texts. This goal will be pursued both
conceptually and practically.

The conceptual development involves describing the special considerations and
challenges associated with creating digital editions and translations of
philosophical material. Here, considerations on analysis and categorization of
terminology, the development of references and arguments within and across
traditions, and the particular genres and structures of philosophical texts are
all central.

The practical development involves implementing a suite of software that makes
the production of born digital editions in accordance with the special
considerations of philosophical texts (1) easier, (2) more robust, and (3)
distributed.

The production is made easier by formalizing a schema according to which
documents encoded in TEI P5 compliant XML-files can be validated and confirmed
to conform to a stylesheet that takes the special elements of this type of texts
into considerations.

Robustness is sought for by establishing a general workflow for creating
editions and translations according to a unambiguous versioning system, ensuring
that although a digital edition of a text keeps evolving after the initial
publication of the text, it is still possible to make stable references to a
specific version of the text, reflecting that status of the text at the time of
the reference. Furthermore, it must also be possible to retrieve any given
version of a text at will.

Finally, distributed creation of editions and translations is a goal. By
applying the advanced tools of modern software development in the production of
textual editions and translations, the co-production of editions across
geographical and temporal boundaries can be improved significantly. These tools
also enable unambiguous attribution of editorial credit and responsibility at a
much more fine grained scale than what is possible in traditional printing
systems. Finally, enabling the production of partial editions should increase
the availability of texts, as the production is no longer encumbered by the
often daunting task of creating a complete edition or translation of a whole
text.


## Within the *Representation and Reality* project

This work fits into the the framework of the Representation and Reality project
at two levels:

1.  Dissemination and creation of awareness, and
2.  demonstration of application.

Concerning dissemination: As the development of the theoretical and practical
aspects of this framework matures, I can discuss and demonstrate the
possibilities of the approach to the project group at large. To the extent that
it is of interest to the members of the group, I could facilitate training in
these technologies. But it may be posited that the technological revolution that
has taken place since the mid 20th century makes a fundamental rethinking of how
we create, store, analyze and interact with text. If that is granted, it is
imperative that the development of such methods must be disseminated within the
wider network of textual scholars. The Representation and Reality project is a
nexus of the three main language traditions within ancient and medieval
philosophy, and is therefore a perfect venue for spreading an awareness and
knowledge of these new possibilities.

Concerning practical demonstrations: In my own PhD dissertation I will include a
range of editions of Latin commentaries on De anima. These will, of course, be
part of the dissertation in the form of traditional print editions, but it would
also be possible to show them in a more interactive web interface where
different aspects of the texts (the critical apparatus, a single witness or my
editorial comments, for instance) can be toggled interactively. Both
representations of the text will be made on the basis of the same encoded files,
which are made within this framework. My practical application will not make use
of all of the possibilities that this born digital approach makes possible,
partly due to time constraints, partly due to the relatively small extent of the
edited corpus.


### Application examples

Let me sketch some examples of possible uses that would be relevant within a
context like that of the Representation and Reality project. Imagine a tradition
with a range of commentaries on texts that are included in the project, to
Aristotelian works such as *De anima*, *De sensu*, *De somno et vigilia*, *De
insomniis*, *De divinatione* (across all the language traditions). Some of the
following applications could be envisioned:

-   The collection of texts would together constitute a highly curated corpus of
    texts relevant to a researcher within this tradition. Interaction would be
    possible across a range of interfaces: Online digital editions, abstract
    visualization of relations in the set, automated machine interaction, as well
    as traditional print editions. This would all be based on the same textual
    foundation. One set of files, a whole range of applications.
-   Advanced searching possibilities would be enabled. Imagine searching for the
    term 'intentio' on just early 14th century commentaries on *De somno*, or
    'scientia' in all prologues and initial questions across the whole tradition,
    to investigate a question within the medieval philosophy of science.
-   We could trace the reference to and interpretation of a given passage in
    Aristotle across our known texts by showing all the passages where such a
    reference is made.
-   By the same approach, it would be possible to show the interpretative context
    of a passage in Aristotle (or any other part of the tradition) by showing all
    the *other* passages that are also referenced within a paragraph with a
    reference to the original passage.
-   It would be possible to create a print ready and online interactive anthology
    of philosophical commentaries dealing with the concept of visual perception
    across all three traditions or within a specific tradition, say the Latin
    commentaries from the late 13th century.

In the context of the Representations and Reality project, these possibilities
are still at the level of speculation, as the integration of editions already
published or under publication would would lie outside the scope of the project.
Furthermore, realizing all of these possibilities would in effect be a different
and separate project in its own right. But the development of the terminology,
methodology and usable prototypes are a first necessary step towards that end,
while the dissemination of knowledge about these possibilities and a heightened
awareness within the broader scholarly community is a second, but just as
necessary step.


## Collaboration

I am, fortunately, not alone in this. I have established a collaboration with Dr
Jeffrey C. Witt, Assistant Professor of Philosophy, Loyola University Maryland.
Together with Dr Nicolas Vaughan, Assistant Professor, Universidad de
los Andes we develop a standard for how to mark up digital editions of
scholastic literature and an associated schema for validating a document
according to that standard. We are preparing the publication of the first 1.0
version of the schema (see
<https://github.com/lombardpress/lombardpress-schema/tree/develop>) during this
fall.

Dr Jeffrey Witt and I regularly discuss edition infrastructure in relation to a
database system that he has started under the name SCTA, Scholastic Commentaries
and Text Archive (see
<http://lombardpress.org/2016/08/02/bcht-scta-lbp-overview/>). That database makes
it possible to make use of and analyse scholastic texts at a scale and across a
wide range of text that if often practically difficult, and in some respects
impossible withing a traditional publishing framework.

Finally I collaborate with Dr David Bloch, Professor of Classics, University of
Copenhagen, on the further development of these ideas of born digital texts
within translation theory and practice. Soon I hope to make a short write up of
some of the possibilities and ideas within that closely related domain.
