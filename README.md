# OntoLisp: Ontologies as Generative Grammars

## Introduction

In a computational sense, ontologies are representations of knowledge as is. In this age of generative artificial intelligence, ontologies are also one of the strategies to better prompt AI models in order to extract more specific output. On the other hand, ontologies and linked data are also time-consuming to create and validate, which can render this as an expensive alternative to avoiding the so-called "hallucinations" of AI. There is also the need for domain expertise and high techincal skills for ontology engineering, which can hinder the process of generating and maintaning linked data.

Formal, generative grammars describe language through a given, and have also been used in computer science to describe programming languages. They are, however, primarily a powerful tool to describe language as a human evolutive capacity, or what linguistics call "Universal Grammar", or UG. However, language not only an evolutive ability of humans, it is also a political development of societies (NEWMAN, c2007) in itself. The capacity to describe language in its structure can also be an aid to create, refine and describe ontologies while being explicitations of a formal conceptualization (GUARINO, 2009).

Recently, with the advent of LLMs, many studies have proposed ways to enhance ontology engineering using such models, which can assist a process that is otherwise slow, complex and expensive. This study proposes not only a strategy that can be used with artificial intelligence, but hopefully can help human scientists to create linked data in a way that is already natural for every human being, like speaking their own mother tongue.

## Generative Grammars

The word generative (or the term generative-transformational) is one of the many terms that have been used to describe the linguistic theories of Noam Chomsky. For Chomsky's theories, syntax — which is defined as the organization of words into phrases and sentences (CARNIE, 2013) — is primordial (BAUER, 2021), since it is also a cognitive science. One of the theory's core affirmations is that syntax is a set of procedures that generate what is considered language. Generative linguistics is also applied to free-of-context languages in computer science (SIPSER, 2005), which demonstrates that such concepts are not as foreign to the field as they may look on face value.

In this case, generative means that language is generated through these set of mental procedures. We can represent that with the following directives:

$\text{S} \rightarrow \text{NP VP}$
$\text{NP} \rightarrow \text{Det Noun | Noun}$
$\text{VP} \rightarrow \text{Verb NP}$

With such a grammar, we could easily generate sentences like "the dog bites the man", or even ungrammatical sentences in the English language (i.e. unnacceptable to the native speaker) like "the car buys the man". Semantics, or the translation of sentences into thoughts and ideas (CARNIE, op. cit.), can only be assessed after syntax is defined (BAUER, op. cit.). That said, one could think of ontologies as languages and axioms as grammatical rules.

This study proposes a prompting strategy, not only for LLMs, but also for human ontology engineers, that represents ontologies as generative grammars, that is, a set of rules that generate data. Based on Guarino's definition (GUARINO, 2009) of ontologies as a computational artifact that models a formal structure into relations and entities, we propose generative grammars as a formal representation of the observation rules that must be employed when modelling any system or domain.

## LLMs and Ontologies

Various approaches have been recently developed with distinct objectives regarding the mixed usage of LLMs and ontologies/linked data. Cheung (2026) has developed a framework for ontology-based content generation — in his case, tabletop board games. This study uses a pipeline of agents and subsystems guided by an ontology to generate content, with the ontology working as a contractual validation. An interesting affirmation made by this study is that the constraints make creativity possible, what is (for us, conveniently) called Grammar Paradox. However, one drawback of this study is the reliance on Python libraries, namely DSPy and Pydantic, to create this pipeline.

Aggarwal et al. (2025), when assessing various LLMs for creating ontologies for knowledge organization systems, affirm that these models excel in concept extraction and identification of hierarchical relationships. However, the production of comprehensive and detailed ontologies for them is still an open challenge. Lippolis et al. (2025), affirming that prompt engineering stands out for its simplicity and efficiency, evaluate a couple of LLM prompting strategies for the use of LLMs in assisting ontology engineers in the process, especially novice ones. Kampars et al. (2025) studied the use of LLMs within an ontology building framework, where the model suggested canonical forms where they were missing in the datasets, acting as a semantic reductor.

Our study proposes generative grammars both as a prompting strategy and building framework: while a powerful tool for LLM reasoning, it stands out as a human-comprehensible way to represent ontological axioms, reducing the complexity of ontology building, and paving the path for domain experts — not only linguists, hopefully — to explore the enormous potentiality of linked data for sharing knowledge in an interdisciplinary way. Being a prompting strategy in itself, ontologies as generative grammars can provide means to leverage the natural language processing (NLP) capabilities of LLMs.

## Ontologies as Grammars

Ontologies are generally modelled as triples in the RDF specification (W3C, 2014). These triples are comprised of a subject, a predicate and an object. Using this format, axioms are then laid out for semantic purposes, and the RDF triples model the relations between meta-elements. An ontology class, using gUFO (ALMEIDA et al., 2019) as its upper level ontology, would be as follows:

```rdf
:Computer rdf:type owl:Class ;
    rdfs:label "Computer" ;
    rdfs:comment "A type that comprises machine with Turing-complete capabilities." ;
    rdfs:subClassOf gufo:Kind .
```

However, RDF triples are, by nature, less descriptive. Generative grammars, on the other hand, are descriptive by nature, since they inherently describe language, or at least parts of it. By proposing ontology axioms as a grammar, while preserving the subject-predicate-object relation, we can define a grammar layout for said axioms. Using a syntax based on the Elm programming language for creating our grammars, we can define gUFO's Kind metatype as follows:


```elm
type Subject = String

kind : Subject -> String

kind subject =
    subject ++ "is an endurant type that is both sortal and rigid."

computer : Subject -> String
computer subject = 
    kind subject ++ " It is a type that comprises machines with Turing-completes capabilities."
```

This is an excellent choice for both LLMs and humans, for a number of reasons. First, it draws its syntax from a functional programming language, heavily based on -calculus, that's well known to LLMs and closely resembles widely known mathematical principles, i.e. functions. It also makes possible for RDF schema relations to be defined arbitrarily (which is admittedly one of its weaknesses as well), that is, the relationship between a function and its RDF triple equivalent must be defined elsewhere and bears no influence on the function definition. Last, but not least, generative grammars renders ontologies more as a language problem than a philosophical one. This makes the method suitable also for non-experts in the ontology field, and a methodological alternative for dealing with interdisciplinary teams.

Concerning ontologies as formal grammars for LLM prompting, this study suggests their use as an Elm-based syntax, containing its `rdfs:comment` and lowercased `rdfs:label` as the function's name, receiving arguments that are either `Subject` or `Object` (both being types aliases of the `String` type), and returning a `String`. The equivalent triples and their definitions must be defined on another piece of code, which we will provide an example in the next section. An example of a grammar function that receives an `Object` argument could be one that is equivalent to an `owl:ObjectProperty`, such as:

```elm
type Subject = String

type Object = String

role : Subject -> String

role subject =
    subject ++ " is a type that is both sortal and anti-rigid, but relationally dependant."

functionality : Subject -> String
functionality subject =
    role subject ++ " It is a functionality of a Computer"

hasFunctionality : Subject -> Object -> String
hasFunctionality subject object =
    computer subject ++ " It has the following functionality: " ++ functionality object
```

## OntoLisp concept

One limitation about the syntax describe above is that it only represents the axiomatic definition of the ontology's types, that is, we need to use a more complex pattern than a pure function to describe both the graph and axiomatic definitions. However, the Elm language is purely functional and does not integrate well with existing tooling for ontologies yet. Its place shall be taken by the **Lisp** programming language, which is both functional — allowing us to define the generative functions of language as above — and multiparadigm, enabling the representation of the RDF graph itself. For this example, this work has chosen the **Hy** (or Hylang) dialect of Lisp (HERRERA, c2026 <!--link for Hylang homepage, MIT Licensed on GitHub-->), which is implementend within the Python runtime. This choice will allows us to integrate existing ontology and LLM toolings in the Python language, using the Hy code both as a prompt and as a runtime functionality.

OntoLisp is set on the principle that every programmatic axiom should be represented by its labels and definitions (or comments), but also should carry on the necessary elements to represent the RDF triples, in a single data structure. This is achieved, on OntoLisp, through the Factory pattern, where constructors are defined for classes (here called *concepts*) and object properties (here called *relations*), creating instances that carry the ability to transform into RDF triples (compatible with Python's `rdflib` library), and also containing elements that are descriptive enough to represent the axioms for an LLM or even a human being. That said, an OntoLisp script serves as both a runtime import and a prompt for the language model (e.g. Gemini).

OntoLisp's defintions for prompting (and runtime execution) are as follows:

```clj
;; Definitions of gufo:Event and gufo:hasBeginPointInXSDDateTimeStamp

;; Definition of owl:Class (a.k.a. Concept)
(setv event (concept
    :ns gufo :iri "Event" :label "Event" :comment "An event is a happening that occurs in a specific place and time."))

;; Definiton of owl:ObjectProperty (a.k.a. Relation) with typed literal
;; import of `rdflib`'s `Literal` and `XSD` implied here class implied here
(setv has-begin-point-in-xsd-date-time-stamp (relation
    :ns gufo :iri "hasBeginPointInXSDDateTimeStamp" :label "hasBeginPointInXSDDateTimeStamp"
    :comment "Determines the begin point of a gufo:ConcreteIndividual, using a xsd:dateTimestamp literal."
    :guardrails {"obj" fn [timestamp] (Literal timestamp :datatype XSD.dateTimeStamp)}))

;; Note: guardrails are optional
```

The main objective of OntoLisp is to serve as a prompt for transforming (hyper)texts — i.e. texts with non-linear access reading, into linked data. Using a generative grammar-based approach, it can auxiliate both humans and AI models into creating instances of axiomatic types, using a rationale that is familiar enough to both and based on core, well established linguistic principles. This work hopes that OntoLisp serves as a basic ontology building and engineering tool for the future.

## Experimentation

For testing our prototype, we've created an agent based on the **LangGraph** framework, using **rdflib** as an auxiliary for serializing ontology triples in the *Turtle* format. For these purposes, a lightweight application ontology was defined for the **Formula 1 World Championship** using **gUFO** as its upper level ontology. This choice was motivated by the choice of gUFO itself to represent examples using sports data.

The graph will have the following functionalities, orchestrated in a directed acyclic graph (or DAG): (1) extract hypertext from a Wikipedia link into Markdown format, (2) prompt the AI using the ontologies definitions in the Turtle and OntoLisp format to produce OntoLisp functions calls with their respective arguments, (3) import the OntoLisp defined functions and use the AI-given arguments with the OntoLisp functions to create a *rdflib* graph.

The ontology defined for F1 is described below, in Turtle format:

```turtle
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix gufo: <http://purl.org/nemo/gufo#> .
@prefix f1: <http://example.org/formula1#> .
@prefix : <http://example.org/ex#> .

###### TYPES ######

f1:GrandPrix rdf:type owl:Class ;
    rdfs:label "GrandPrix" ;
    rdfs:comment "A Grand Prix is a major motor racing event." ;
    rdfs:subClassOf gufo:Event .

f1:Driver rdf:type owl:Class ;
    rdfs:label "Driver" ;
    rdfs:comment "A Driver is a person who competes in motor racing events." ;
    rdfs:subClassOf gufo:Role .

f1:Season rdf:type owl:Class ;
    rdfs:label "Season" ;
    rdfs:comment "A Season is a period during which a series of Grand Prix events take place." ;
    rdfs:subClassOf gufo:Event .

f1:GrandPrixPosition rdf:type owl:Class ;
    rdfs:label "GrandPrixPosition" ;
    rdfs:comment "Represents the finishing position of a driver in a Grand Prix." ;
    rdfs:subClassOf gufo:Situation .

###### PROPERTIES ######

f1:startsGP rdf:type owl:ObjectProperty ;
    rdfs:label "startsGP" ;
    rdfs:comment "Indicates that a Driver has started a Grand Prix." ;
    rdfs:subPropertyOf gufo:participatesIn ;
    rdfs:domain f1:Driver ;
    rdfs:range f1:GrandPrix .

f1:takesPlaceInSeason rdf:type owl:ObjectProperty ;
    rdfs:label "takesPlaceInSeason" ;
    rdfs:comment "Indicates that a Grand Prix takes place in a specific Season." ;
    rdfs:domain f1:GrandPrix ;
    rdfs:range f1:Season .

f1:hasDriver rdf:type owl:ObjectProperty ;
    rdfs:label "hasDriver" ;
    rdfs:comment "Indicates that a GrandPrixPosition is associated with a specific Driver." ;
    rdfs:domain f1:GrandPrixPosition ;
    rdfs:range f1:Driver .

f1:hasGrandPrix rdf:type owl:ObjectProperty ;
    rdfs:label "hasGrandPrix" ;
    rdfs:comment "Indicates that a GrandPrixPosition is associated with a specific Grand Prix." ;
    rdfs:domain f1:GrandPrixPosition ;
    rdfs:range f1:GrandPrix .

f1:hasPosition rdf:type owl:DatatypeProperty ;
    rdfs:label "hasPosition" ;
    rdfs:comment "The finishing position of the driver in the Grand Prix." ;
    rdfs:domain f1:GrandPrixPosition ;
    rdfs:range xsd:integer .
```

The results have shown that the model can identify the triples successfully, not resorting to any hallucinations, modelling data succesfully within the given axioms. The same data found in the generated linked data may be found in other datasets, such as the F1 dataset found in Kaggle ([link here](https://www.kaggle.com/datasets/rohanrao/formula-1-world-championship-1950-2020)). However, one clear limitation is the context window for output tokens, which can hinder the results if the hypertext is rather dense in its contents.

## References (ABNT Portuguese)

GUARINO, Nicola; OBERLE, Daniel; STAAB, Steffen. What is an ontology? In: STAAB, Steffen; STUDER, Rudi (ed.). Handbook on ontologies. 2nd ed. Berlin: Springer, 2009. p. 1-17. (International Handbooks on Information Systems). Available at: https://doi.org/10.1007/978-3-540-92673-3_0.

NEWMAN, John Henry. An essay on the development of Christian doctrine. London: Longmans, Green, and Co., 1878. Chap. 5, Notes of genuine and corrupt developments. Available at: https://www.newmanreader.org/works/development/chapter5.html. Accessed on: Aug. 10, 2026.

BAUER, Laurie. The linguistics student's handbook. 2nd ed. Edinburgh: Edinburgh University Press, 2021.

CARNIE, Andrew; SATO, Yosuke; SIDDIQI, Daniel (ed.). The Routledge handbook of syntax. London: Routledge, 2013.

CHEUNG, Benny. Generative ontology: when structured knowledge learns to create. arXiv, 2026. Disponível em: https://arxiv.org/abs/2602.05636. Acesso em: 10 ago. 2026.

AGGARWAL, Tanay; SALATINO, Angelo; OSBORNE, Francesco; MOTTA, Enrico. Leveraging large language models for generating research topic ontologies: a multi-disciplinary study. arXiv, 2025. Disponível em: https://arxiv.org/abs/2508.20693. Acesso em: 10 ago. 2026.

LIPPOLIS, Anna Sofia; SAEEDIZADE, Mohammad Javad; KESKISÄRKKÄ, Robin; ZUPPIROLI, S.; CERIANI, M.; GANGEMI, Aldo; BLOMQVIST, Eva; NUZZOLESE, Andrea Giovanni. Ontology generation using large language models. In: EUROPEAN SEMANTIC WEB CONFERENCE, 2025. Proceedings [...]. Berlin: Springer, 2025. p. 321-341.

KAMPARS, Jānis; MOSĀNS, Guntis; JOGI, Tushar; ROTERS, Franz; VAJRAGUPTA, Napat. LLM-supported collaborative ontology design for data and knowledge management platforms. Frontiers in Big Data, v. 8, e1676477, 2025. DOI: 10.3389/fdata.2025.1676477.

LÉVY, Pierre. As tecnologias da inteligência: o futuro do pensamento na era da informática. Tradução de Carlos Irineu da Costa. Rio de Janeiro: Ed. 34, 1993. Cap. 2, O hipertexto, p. 28-42. (Coleção TRANS).

HYLANG. The Hy programming language. [2024-2026]. Disponível em: https://hylang.org/. Acesso em: 10 ago. 2026.