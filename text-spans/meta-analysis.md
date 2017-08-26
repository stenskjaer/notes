
# Annotating analysis of spans

In this model there is the base transcription file and then an arbitrary number
of analyses that can be applied to the base transcription.

So say I want to apply the content of one particular analysis file to the
transcription and produce a representation of the text that incorporeates that
analysis in pdf (via a TeX-file). This would require the following steps.
1. Create XML transcription file according to the LBP schema.
2. Create an analysis file according to some particular format, indicating which
   spans of the transcription should receive which annotations.
3. Apply the content of the analysis file to the base transcription, resulting
   in an intermediary XML with embedded annotations.
4. The intermediary file is then converted to a TeX file as you would usually
   with any other LBP XML.
5. Convert the TeX file to PDF.

The challenge is here mainly step 3. Another problem is how the annotated XML
gets properly processed into any given representation (which will have
challenges in itself).


## An example passage

Take this more or less randomly chosen example text:

```
Praeterea per Philosopum in quinto duplex est actio, una quae manet in agente,
alia quae transit in rem extrinsecam; unde dicit quod intelligere est actio
manens in agente, sed in tali actione oportet id quod agitur esse unitum cum
agente, illud ergo quod intelligitur oportet esse unitum ipsi intellectui; sed
non esset seperatum ab intellectu, nam eius actio transiret in aliud, quod negat
Philosophus; cum igitur intellectus sit maxime sibi unus, et eius intelligere
recipitur in ipso maxime, ergo erit quod intelligitur et per consequens
intelligibile.
```

This contains (as far as I have managed to analyse this) one syllogism where the
major contains a full nested syllogism. I think I would analyse it as follows: 

- Lvl 1, major: duplex est actio, una quae manet in agente, alia quae transit in
  rem extrinsecam; 
    - lvl 2, major: intelligere est actio manens in agente, 
    - lvl 2, minor: sed in tali actione oportet id quod agitur esse unitum cum
      agente, 
    - lvl 2, conclusion: illud ergo quod intelligitur oportet esse unitum ipsi
      intellectui;
- Lvl 1, minor: sed non esset seperatum ab intellectu, nam eius actio transiret
  in aliud, quod negat Philosophus; 
- Lvl 1, conclusion: cum igitur intellectus sit maxime sibi unus, et eius
  intelligere recipitur in ipso maxime, ergo erit quod intelligitur et per
  consequens intelligibile.
  
In the major premise of the top level syllogism the main statement of the
premise is the conclusion of the contained syllogism, that that which is
understood need to be united with the intellect itself ("illud ergo quod
intelligitur oportet esse unitum ipsi intellectui")


## XML annotation

In regular LBP markup this could look like this (at least that's what it looks
like in my preliminary draft transcription):

```xml
<p xml:id="da-348-l3q15-bbg0a9">
  Praeterea per
  <cit>
    <ref>
      <name ref="#Aristotle">Philosopum</name>
      in quinto
    </ref>
    <quote>
      duplex est actio, una quae manet in agente, alia quae transit in
      rem extrinsecam
    </quote>
    <note>
      Locus non inventus, sed num ad <name
      ref="#Aristotle">Arist.</name> <title
      ref="#Arist.Metaph">Metaph.</title> IX.8 1050a30--b2 aspicit?
    </note>
  </cit>
  ; unde dicit quod intelligere est actio manens in agente, sed in
  tali actione oportet id quod agitur esse unitum cum agente, illud
  ergo quod intelligitur oportet esse unitum ipsi intellectui; sed non
  esset seperatum ab intellectu, nam eius actio transiret in aliud,
  quod negat Philosophus; cum igitur intellectus sit maxime sibi unus,
  et eius intelligere <unclear>recipitur</unclear> in ipso maxime,
  ergo erit quod intelligitur et per consequens intelligibile.
</p>
```

## An external analysis file

Now if I wanted to describe the syllogistic structure from above, I could create
an XML file (or another format, for that matter. JSON maybe?) that can describe
the syllogistic structure as follows:

```xml
<syllogism>
  <major>
    <span>
      <start>
        <id>da-348-l3q15-bbg0a9</id> <!-- The paragraph xml:id -->
        <pos>6</pos>                 <!-- Token number in the paragraph-->
        <word>duplex</word>          <!-- Token content for error checking -->
      </start>
      <end>
        <id>da-348-l3q15-bbg0a9</id>
        <pos>49</pos>
        <word>intellectui</word>
      </end>
    </span>
  </major>
  <minor>
    <!-- Data on the minor here -->
  </minor>
  <conclusion>
    <!-- Data on the conclusion here -->
  </conclusion>
</syllogism>
```

The content of the nested syllogism would be similar. See the analysis.xml file
for the full example.

A possible alternative structure is the more flat approach of
the [annotations.xml](annotations.xml) file.


## The intermediary XML

When this meta-analysis is applied to the base transcription, it could for
example produce the following exceprt of an intermediary file:

```xml
<p xml:id="da-348-l3q15-bbg0a9">
  Praeterea per
  <cit>
    <ref>
      <name ref="#Aristotle">Philosopum</name>
      in quinto
    </ref>
    <quote>
      <w xml:id="da-348-l3q15-bbg0a9-syll-3k9b6h-maj-start">duplex</w>
      est actio, una quae manet in agente, alia quae transit in rem
      extrinsecam
    </quote>
    <note>
      Locus non inventus, sed num ad <name
      ref="#Aristotle">Arist.</name> <title
      ref="#Arist.Metaph">Metaph.</title> IX.8 1050a30--b2 aspicit?
    </note>
  </cit>
  ; unde dicit quod intelligere est actio manens in agente, sed in tali
  actione oportet id quod agitur esse unitum cum agente, illud ergo quod
  intelligitur oportet esse unitum ipsi
  <w xml:id="da-348-l3q15-syll-3k9b6h-maj-end">intellectui</w>;
  <w xml:id="da-348-l3q15-syll-3k9b6h-min-start">sed</w>
  non esset seperatum ab intellectu, nam eius actio transiret in aliud,
  quod negat
  <w xml:id="da-348-l3q15-syll-3k9b6h-min-end">Philosophus</w>;
  <w xml:id="da-348-l3q15-syll-3k9b6h-con-start">cum</w>
  igitur intellectus sit maxime sibi unus,
  et eius intelligere <unclear>recipitur</unclear> in ipso maxime, ergo
  erit quod intelligitur et per consequens
  <w xml:id="da-348-l3q15-syll-3k9b6h-con-end">intelligibile</w>.
  <spanGrp type="syllogism" xml:id="da-348-l3q15-syll-3k9b6h">
    <span from="da-348-l3q15-syll-3k9b6h-maj-start"
          to="da-348-l3q15-syll-3k9b6h-maj-end">major</span>
    <span from="da-348-l3q15-syll-3k9b6h-min-start"
          to="da-348-l3q15-syll-3k9b6h-min-end">minor</span>
    <span from="da-348-l3q15-syll-3k9b6h-con-start"
          to="da-348-l3q15-syll-3k9b6h-con-end">conclusion</span>
  </spanGrp>
</p>
```

Only the top level syllogism is annotated here, to keep it just somewhat
readable. But the nested syllogism would be annotated according to the same
principles.

The idea of not just writing the spans directly into the text but instead use
anchors is to remedy the very likely problem of conflicting structures. 


## A LaTeX representation

So how could this look like in a TeX file? Let's say we want to have a
representation where every element in a syllogism is written in the text with
the following format "{<int>.<string>}" where the "{" and "}" mark or surround
the concept of added editorial meta-text such as the syllogism analysis. The
<int> should be a number indicating the level at which the element occurs within
a possibly nested structure. The <string> should indicate which argument element
we are dealin with.

This could be encoded as follows in TeX (in a reduced excerpt):

```tex
\pstart%
Praeterea per \edtext{\name{Philosopum\index[persons]{}} in quinto
  \enquote{\syll{1.Maj} duplex est actio, una quae manet in agente, alia quae
    transit in rem extrinsecam}}{\lemma{}\Afootnote[nosep]{Locus non inventus,
    sed num ad Arist.\index[persons]{} \worktitle{Metaph.}\index[works]{} IX.8
    1050a30--b2 aspicit?}}; \syll{2.Maj} unde dicit quod intelligere est actio
manens in agente, \syll{2.Min} sed in tali actione oportet id quod agitur esse
unitum cum agente, \syll{2.Con}illud ergo quod intelligitur oportet esse unitum
ipsi intellectui; \syll{1.Min} sed non esset seperatum ab intellectu, nam eius
actio transiret in aliud, quod negat Philosophus; \syll{1.Con} cum igitur
intellectus sit maxime sibi unus, et eius intelligere \emph{recipitur [?]} in
ipso maxime, ergo erit quod intelligitur et per consequens intelligibile.%
\pend
```

See the full tex-file in [tex/base.tex](./tex/base.tex). See the output
in [tex/base.pdf](./tex/base.pdf).

## XSLT for conversion

This is maybe the hard (or at least the least conceptual and most practical)
part. I haven't thought this through yet, but suggestions are welcome...


# Concluding thoughts

The intermediary file should be a LBP compliant file (I think). So in a sense
one could just manually annotate these things directly into the file. 
I think that has two drawbacks:
1. It is difficult to combine a range of different meta-analysis and selectively
   choose which should be represented, and which should be ignored.
2. The readability and writeability of such encodings would be pretty bad (which
   I think this example already illustrates).


