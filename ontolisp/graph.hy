(import os [getenv])
(import requests)

(import box [Box])
(import hy [mangle])
(import langchain_google_genai [ChatGoogleGenerativeAI])
(import langgraph.graph [END START])
(import markdownify [markdownify :as md])
(import yaml)

(import agent [HyCalls builder])
(import semantics [ontology])
(import utils [normalize-kwarg])

; kebab naming conventions for builder
(setv add-edge builder.add_edge)
(setv add-node builder.add_node)
(setv compile-graph builder.compile)

(with [f1 (open "semantics/prompts.yaml")]
  (setv prompts (Box (yaml.safe_load f1))))

(with [f2 (open "semantics/ontology.ttl")]
  (setv ontology-turtle (f2.read)))

(with [f3 (open "semantics/ontology.hy")]
  (setv lisp-grammar (f3.read)))

(setv llm (ChatGoogleGenerativeAI :model "gemini-2.5-flash" :api-key (getenv "GOOGLE_API_KEY")))

(defn hypertext-fetch [state]
  (setv hypertext-url (get state "hypertext_url"))
  (setv headers {"User-Agent" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3"})
  (setv response (requests.get hypertext-url :headers headers))
  (return {"hypertext" (md response.text)}))

(defn gg-extract [state]
    (setv hypertext (state.get "hypertext"))
    (setv gg-llm (llm.with_structured_output HyCalls))
    (setv messages [
        {"role" "system"  "content" (prompts.extract.format :ontology ontology-turtle :grammar lisp-grammar)}
        {"role" "user"  "content" hypertext}
    ])
    (setv response (gg-llm.invoke messages))
    (setv hy-calls response.calls)
    (return {"hy_calls" hy-calls}))

(defn gg-apply [state]
  (setv hy-calls (state.get "hy_calls"))
  (setv graph (state.get "graph"))
  (for [hy-call hy-calls]
    (setv predicate (getattr ontology (mangle hy-call.name)))
    (setv result-args (dict(map normalize-kwarg (hy-call.args.items))))
    (setv result (predicate #** result-args))
    (setv triple result.triple)
    (graph.add triple))
  (return {"graph" graph}))

(defn build-graph []
  (add-node "hypertext-fetch" hypertext-fetch)
  (add-node "gg-extract" gg-extract)
  (add-node "gg-apply" gg-apply)
  (add-edge START "hypertext-fetch")
  (add-edge "hypertext-fetch" "gg-extract")
  (add-edge "gg-extract" "gg-apply")
  (add-edge "gg-apply" END)
  (return (compile-graph)))
