from typing import Annotated, TypedDict

from langgraph.graph import StateGraph
from langgraph.graph.message import add_messages
from pydantic import BaseModel, Field
from rdflib import Graph


class HyCall(BaseModel):
    name: str = Field(description="The name of the Hy callablle")
    args: dict[str, str] = Field(description="The arguments for the Hy callable")


class HyCalls(BaseModel):
    calls: list[HyCall]


class AgentState(TypedDict):
    hypertext_url: str
    messages: Annotated[list, add_messages]
    hypertext: str
    hy_calls: HyCalls
    graph: Graph


builder = StateGraph(AgentState)
