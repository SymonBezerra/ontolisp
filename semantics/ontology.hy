(import rdflib [Namespace Literal XSD])

(import ontolisp.concept [concept])
(import ontolisp.relation [relation])

(setv gufo (Namespace "http://purl.org/nemo/gufo#"))

(setv f1 (Namespace "http://example.com/F1#"))

;; CONCEPTS

;; usage:
;; (setv test-event (event :subj "TestEvent"))
(setv event (concept
    :ns gufo :iri "Event" :label "Event" :comment "An event is a happening that occurs in a specific place and time."))

(setv situation (concept
    :ns gufo :iri "Situation" :label "Situation" :comment "A situation is a set of circumstances or conditions that exist at a particular time."))

(setv role (concept
    :ns gufo :iri "Role" :label "Role"
    :comment "A role is a type that both bears an identity principle and is rigid (i.e. applies necessarily to its instances), defined by relational instantiation conditions."))

(setv grand-prix (concept
    :ns f1 :iri "GrandPrix" :label "Grand Prix"
    :comment "A Grand Prix is a major motor racing event." :parent event))

(setv driver (concept
    :ns f1 :iri "Driver" :label "Driver"
    :comment "A driver is a person who operates a motor vehicle." :parent role))

(setv season (concept
    :ns f1 :iri "Season" :label "Season"
    :comment "A season is a period of time during which a series of races are held." :parent event))

(setv grand-prix-position (concept
    :ns f1 :iri "GrandPrixPosition" :label "Grand Prix Position"
    :comment "A Grand Prix position is a specific placement or ranking achieved by a driver in a Grand Prix race." :parent situation))

;; RELATIONS
;; usage:
;; (setv gp-start (starts-gp :subj "TestDriver" :obj "TestGrandPrix"))

(setv starts-gp (relation
    :ns f1 :iri "startsGP" :label "startsGP"
    :comment "Indicates that a Driver has started a Grand Prix."))

(setv takes-place-in-season (relation
    :ns f1 :iri "takesPlaceInSeason" :label "takes place in season"
    :comment "Indicates that a Grand Prix takes place in a specific Season."))

(setv has-driver (relation
    :ns f1 :iri "hasDriver" :label "has driver"
    :comment "Indicates that a GrandPrixPosition is associated with a specific Driver."))

(setv has-grand-prix (relation
    :ns f1 :iri "hasGrandPrix" :label "has grand prix"
    :comment "Indicates that a GrandPrixPosition is associated with a specific Grand Prix."))

(setv has-position (relation
    :ns f1 :iri "hasPosition" :label "has position"
    :comment "The finishing position of the driver in the Grand Prix."
    :guardrails {"obj" (fn [position] (Literal position :datatype XSD.integer))}))