(import rdflib [Graph])

(import graph [build-graph])

(setv ontology-agent (build-graph))

(when (= __name__ "__main__")
  (setv ontology-graph (Graph))
  (ontology-graph.parse "semantics/ontology.ttl" :format "turtle")
  (setv fetch-url "http://en.wikipedia.org/wiki/2008_Australian_Grand_Prix")
    (setv state (ontology-agent.invoke {"hypertext_url" fetch-url "graph" ontology-graph}))
    (setv graph (state.get "graph"))
    (graph.serialize "result.ttl" :format "turtle"))
