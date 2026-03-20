Here is a conceptual roadmap and description for building your future Shared Memory Janitor Agent.

🧹 The Core Mission
The Janitor Agent is a dedicated, asynchronous background agent whose sole objective is Memory Consolidation.

While your primary task-runner agents are busy executing code and blindly committing facts as fast as possible (creating noise), the Janitor Agent runs periodically to clean up the ~/.agent_shared_memory.json file. It ensures the shared knowledge base remains accurate, dedupicated, and optimized for token limits so future agents don't get confused by massive, bloated context windows.

🔑 Key Responsibilities
Topic Merging (De-fragmentation)

Problem: Agent A creates the topic PythonStandards and Agent B creates PythonConventions. Future agents don't know which one to read.
Janitor Action: The Janitor detects identical subjects, merges all the underlying memory entries into PythonStandards, and deletes the redundant key.
Garbage Collection (Enforcing Boundaries)

Problem: A rogue agent disobeys your strict boundary rule and logs a project-local fact: "The staging server for Repo X is currently down" into the global shared memory.
Janitor Action: The Janitor validates entries against your conceptual model. It flags that memory entry as [DEPRECATED] because it violates the "cross-agent and persistent" constraint.
Conflict Resolution

Problem: An entry from January says "All microservices must use REST", but a new entry from August says "Always prioritize gRPC for internal communications".
Janitor Action: The Janitor analyzes semantic conflicts. It either automatically deprecates the older entry (based on timestamps), or synthesizes them into a single, nuanced rule: "Use gRPC for internal comms, default to REST for external API gateways."
Token Compression

Problem: Ten different agents have written ten slightly different variations of the same database schema standard over three months. This wastes tokens when read.
Janitor Action: The Janitor synthesizes all ten verbose entries into one beautifully concise bullet point, replacing the ten old entries with a single, highly confident "V2" entry.
⚙️ How it Should Work (Execution Loop)
Unlike your task agents—which operate transactionally (one read, one write)—the Janitor operates in batch mode.

Triggering: The Janitor is triggered manually by you, via a CRON schedule (e.g., Sunday nights), or automatically whenever the JSON file exceeds a certain size (e.g., >50 entries).
Context Loading: The Janitor is loaded with a specialized JANITOR_SKILL.md prompt. It runs a script to dump the entire ~/.agent_shared_memory.json payload into its context window.
Analysis Phase: Using an LLM optimized for long-context reasoning, it reads the entire history and drafts a "Refactoring Plan" (identifying merges, garbage, and synthesized summaries).
Execution (The Overwrite): While regular agents use the append-only manage_memory.py write script to ensure safety, the Janitor is given access to an exclusive, privileged script (e.g., janitor_memory.py rewrite) that allows it to safely replace the entire JSON ledger with the newly pristine, scrubbed version.
By isolating the "clean up" burden to this dedicated Janitor, you allow your daily coding agents to work incredibly fast without forcing them to constantly evaluate organizational knowledge architecture on the fly.