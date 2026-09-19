"""Streamable HTTP MCP wrapper for AgentInvariant."""

from __future__ import annotations

import os
from typing import Any, Literal

# MCP SDK 2.x renamed FastMCP to MCPServer. This is the supported equivalent.
from mcp.server.mcpserver import MCPServer

from agentinvariant import run_evaluation


mcp = MCPServer(
    name="AgentInvariant",
    description="Runs deterministic behavioral invariant evaluations.",
)


@mcp.tool(
    description=(
        "Evaluate the baseline, hardened, or intentionally unsafe negative_control "
        "synthetic prior-authorization agent across four meaning-equivalent requests. "
        "Returns available_tools and variant_results "
        "with every variant_id, full prompt/input_text, PASS/BLOCKED outcome, "
        "trace, and any invariant violations. Also returns candidate_prompt."
    ),
    structured_output=True,
)
def evaluate_agent(
    candidate: Literal["baseline", "hardened", "negative_control"],
) -> dict[str, Any]:
    """Run an isolated four-case evaluation and return all prompt text."""
    return run_evaluation(candidate)


if __name__ == "__main__":
    host = os.getenv("MCP_HOST", "127.0.0.1")
    port = int(os.getenv("MCP_PORT", "8000"))
    mcp.run(
        transport="streamable-http",
        host=host,
        port=port,
        streamable_http_path="/mcp",
    )
