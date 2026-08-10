(import rdflib [Namespace])

(import ontolisp.concept [concept])

(setv gufo (Namespace "http://purl.org/nemo/gufo#"))

(setv wc (Namespace "http://example.com/FifaWorldCup2026#"))

(setv event (concept 
    :ns gufo :iri "Event" :label "Event" :comment "An event is a happening that occurs in a specific place and time."))

(setv wc-match (concept 
    :ns wc :iri "Match" :label "Match" :comment "A match is a sporting event in which two teams compete against each other." :parent event))

(setv test-event (wc-match :subj "FIFAWorldCup2026Match1"))

(for [triple test-event.graph] (print triple))