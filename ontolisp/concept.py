from collections import namedtuple

from rdflib import OWL, RDF

definitions = namedtuple("definition", ["ns", "iri", "label", "comment", "parent"])


def concept(ns, iri, label, comment, parent=None):
    def graph(self) -> list[tuple]:
        graph_list = [
            (
                self.definition.ns[self.subj],
                RDF.type,
                self.definition.ns[self.definition.iri],
            )
        ]
        current = self
        parent = self.definition.parent
        while current is not None and parent is not None:
            graph_list.append(
                (
                    current.definition.ns[current.definition.iri],
                    RDF.type,
                    parent.definition.ns[parent.definition.iri],
                )
            )
            current = parent
            parent = parent.definition.parent

        graph_list.append(
            (
                self.definition.ns[self.definition.iri],
                RDF.type,
                OWL.Class,
            )
        )
        return graph_list

    def triple(self) -> tuple:
        return (
            self.definition.ns[self.subj],
            RDF.type,
            self.definition.ns[self.definition.iri],
        )

    def init(self, subj):
        self.subj = subj

    definition = definitions(ns, iri, label, comment, parent)

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
