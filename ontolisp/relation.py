from collections import namedtuple

from rdflib import OWL, RDF, RDFS

definitions = namedtuple(
    "definition", ["ns", "iri", "label", "comment", "parent", "guardrails"]
)


def relation(ns, iri, label, comment, parent=None, guardrails=None):
    def graph(self) -> list[tuple]:
        graph_list = [
            (
                self.definition.ns[self.subj],
                self.definition.ns[self.definition.iri],
                self.definition.ns[self.obj],
            )
        ]
        current = self
        parent = self.definition.parent
        while current is not None and parent is not None:
            graph_list.append(
                (
                    current.definition.ns[current.definition.iri],
                    RDFS.subPropertyOf,
                    parent.definition.ns[parent.definition.iri],
                )
            )
            current = parent
            parent = parent.definition.parent
        graph_list.append(
            (
                self.definition.ns[self.definition.iri],
                RDF.type,
                OWL.ObjectProperty,
            )
        )
        return graph_list

    def triple(self) -> tuple:
        if self.definition.guardrails is None:
            subj = self.definition.ns[self.subj]
            obj = self.definition.ns[self.obj]
        else:
            subj_guardrail = self.definition.guardrails.get("subj")
            obj_guardrail = self.definition.guardrails.get("obj")
            subj = (
                self.definition.ns[self.subj] if subj_guardrail is None else self.subj
            )
            obj = self.definition.ns[self.obj] if obj_guardrail is None else self.obj
        return (
            subj,
            self.definition.ns[self.definition.iri],
            obj,
        )

    def init(self, subj, obj):
        if self.definition.guardrails is None:
            self.subj = subj
            self.obj = obj
        else:
            subj_guardrail = guardrails.get("subj")
            obj_guardrail = guardrails.get("obj")
            self.subj = subj_guardrail(subj) if subj_guardrail else subj
            self.obj = obj_guardrail(obj) if obj_guardrail else obj

    definition = definitions(ns, iri, label, comment, parent, guardrails)

    return type(
        label,
        (),
        {
            "definition": definition,
            "__init__": init,
            "graph": property(graph),
            "triple": property(triple),
        },
    )
