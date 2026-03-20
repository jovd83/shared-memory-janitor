# Shared Memory Janitor

## Overview
The Shared Memory Janitor is a dedicated, asynchronous background agent designed to keep your persistent global knowledge base (`~/.agent_shared_memory.json`) clean, coherent, and optimized. While your task-runner agents work quickly appending facts to memory, the Janitor runs periodically to consolidate this shared memory so that your future agents do not get bogged down by massive, bloated, or contradictory context windows.

## The Core Mission
The sole objective of this agent is **Memory Consolidation**. Unlike task-runner agents, which usually operate transactionally (one read, one write), the Janitor operates in batch mode. It steps back to evaluate the overall organizational knowledge architecture and scrubs the ledger for efficiency.

## Key Responsibilities

1. **Topic Merging (De-fragmentation)**
   - **Problem:** Different agents create slightly different topics for the same concept over time (e.g., `PythonStandards` vs. `PythonConventions`).
   - **Janitor Action:** Detects identical subjects, merges all the underlying memory entries into a single well-named key, and deletes the redundant ones.

2. **Garbage Collection (Enforcing Boundaries)**
   - **Problem:** An agent disobeys strict boundaries and logs a temporary or project-local fact (e.g., "The staging server for Repo X is currently down") into the persistent global memory.
   - **Janitor Action:** Validates entries against your architectural boundaries and flags temporary, local facts as `[DEPRECATED]` or removes them completely.

3. **Conflict Resolution**
   - **Problem:** Existing entries contradict new entries written months later.
   - **Janitor Action:** Analyzes semantic conflicts. It will either automatically deprecate older entries based on timestamps or synthesize both entries into a single, nuanced rule.

4. **Token Compression**
   - **Problem:** Multiple agents write similar variations of the same standard, leading to verbose files that waste input tokens over time.
   - **Janitor Action:** Synthesizes verbose, repetitive entries into beautifully concise bullet points, returning massive efficiency to your entire agent fleet.

## How it Works (Execution Loop)

1. **Triggering:** The Janitor is automatically triggered via a CRON schedule (e.g., Sunday nights) or whenever the JSON file exceeds a size threshold (e.g., >50 entries).
2. **Context Loading:** It runs a script to dump the entire `~/.agent_shared_memory.json` payload into its context window, aided by a specialized `JANITOR_SKILL.md` prompt.
3. **Analysis Phase:** Using an LLM optimized for long-context reasoning, it reads the entire history and drafts a "Refactoring Plan" (identifying merges, garbage, and synthesized summaries).
4. **Execution (The Overwrite):** It leverages an exclusive, privileged script (e.g., `janitor_memory.py rewrite`) to safely overwrite the entire unstructured JSON ledger with the newly pristine, scrubbed version.
