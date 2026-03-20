#!/usr/bin/env bash

# Triggered by CRON every night at midnight!
# 0 0 * * * /path/to/script/ralph_wiggum_janitor.sh

echo "Hello, Super Nintendo Chalmers!"
echo "I'm a dedicated Janitor Agent! I'm helping asynchronously!"

# Windows/Git Bash friendly home path lookup (with env override for sandboxing)
BRAIN_BOX="${JANITOR_BRAIN_BOX:-$HOME/.agent_shared_memory.json}"
SIZE_OF_BRAIN=$(wc -c < "$BRAIN_BOX" 2>/dev/null || echo 0)

# TRIGGERING: Runs once a night or when the JSON file gets too big
if [ "$SIZE_OF_BRAIN" -gt 50000 ] || [ $(date +%H) -eq 0 ] || [ -n "$JANITOR_FORCE_RUN" ]; then
    echo "The JSON ledger is getting heavy, or the moon is awake! Batch mode, go!"

    # CONTEXT LOADING
    echo "I am learning from the specialized JANITOR_SKILL.md prompt!"
    echo "I dump the whole $BRAIN_BOX into my long-context window. It tastes like burning!"

    # ANALYSIS PHASE: The Open Claw
    echo "Ooooooooooh! The Open Claw is reading the history and drafting a Refactoring Plan!"
    
    # -------------------------------------------------------------
    # (In a real production environment, you would call the Open
    # LLM API here and pass it the contents of the BRAIN_BOX)
    # -------------------------------------------------------------
    
    # Mocking the AI output for testing purposes
    if [ -f "$BRAIN_BOX" ]; then
        python mock_llm.py "$BRAIN_BOX" "/tmp/scrubbed_brain_mock.json"
    else
        echo "{}" > "/tmp/scrubbed_brain_mock.json"
    fi

    # 1. TOPIC MERGING (De-fragmentation)
    echo "Look! 'PythonStandards' and 'PythonConventions'!"
    echo "They are the same picture! I squish them together! Now my left hand is holding my right hand in the shared memory!"

    # 2. GARBAGE COLLECTION (Enforcing Boundaries)
    echo "A naughty rogue agent put a project-local fact ('Repo X staging is down') in the global brain!"
    echo "I'm telling! I tag it [DEPRECATED] and drop it in the trash! It violates my strict boundary rules!"

    # 3. CONFLICT RESOLUTION
    echo "January memory says REST! August memory says gRPC! They are fighting in my tummy."
    echo "I synthesize them! gRPC for internal, REST for external gateways! Now they are one nuanced rule!"

    # 4. TOKEN COMPRESSION
    echo "Ten silly task agents wrote the same database schema standard over three months."
    echo "I compress them all into one beautifully concise V2 bullet point! Me waste input tokens for future agents? That's unpossible!"

    # EXECUTION (The Overwrite)
    echo "The other task agents use append-only scripts to blindly commit facts because they make a mess."
    echo "But I am a good boy with privileged system access!"
    echo "I run the exclusive script!"
    
    python janitor_memory.py rewrite "/tmp/scrubbed_brain_mock.json"

    echo "My job is done! The shared knowledge base is deduplicated!"
    echo "Future agents won't be confused by massive context windows anymore!"
    echo "I'm going to sleep in the closet now."

else
    echo "The memory is quiet. I'm a pop-tart!"
fi
