import json
import os
import sys
import shutil
from datetime import datetime

MEMORY_FILE_PATH = os.environ.get("JANITOR_BRAIN_BOX", os.path.expanduser("~/.agent_shared_memory.json"))
BACKUP_DIR = os.environ.get("JANITOR_BACKUP_DIR", os.path.expanduser("~/.agent_shared_memory_backups"))

def backup_memory():
    """Takes a backup of the current memory before replacing it."""
    if not os.path.exists(BACKUP_DIR):
        os.makedirs(BACKUP_DIR)
    
    if os.path.exists(MEMORY_FILE_PATH):
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        backup_path = os.path.join(BACKUP_DIR, f"shared_memory_backup_{timestamp}.json")
        shutil.copy2(MEMORY_FILE_PATH, backup_path)
        print(f"Backed up current memory to: {backup_path}")

def rewrite_memory(new_payload_path):
    """Overwrites the global JSON ledger with the newly scrubbed object."""
    try:
        with open(new_payload_path, 'r', encoding='utf-8') as f:
            new_data = json.load(f)
    except json.JSONDecodeError as e:
        print(f"Error: The new payload is not valid JSON. {e}")
        sys.exit(1)
    except FileNotFoundError:
        print(f"Error: Could not find new payload file at {new_payload_path}")
        sys.exit(1)
    except Exception as e:
        print(f"Error reading new payload: {e}")
        sys.exit(1)

    backup_memory()

    with open(MEMORY_FILE_PATH, 'w', encoding='utf-8') as f:
        json.dump(new_data, f, indent=4)
    print("SUCCESS: Safely scrubbed and rewritten the shared memory ledger!")

def main():
    if len(sys.argv) < 2:
        print("Usage: python janitor_memory.py rewrite <path_to_new_json>")
        sys.exit(1)
        
    command = sys.argv[1]
    
    if command == "rewrite":
        if len(sys.argv) < 3:
            print("Error: Must provide the path to the newly scrubbed JSON file to write.")
            sys.exit(1)
        new_payload_path = sys.argv[2]
        rewrite_memory(new_payload_path)
    else:
        print(f"Unknown privileged command: {command}")
        sys.exit(1)

if __name__ == "__main__":
    main()
