# Appendix 5: Useful Prompts

A collection of prompts for common AlignStack workflows.

---

## Gap Analysis Before Implementation

Use this before starting any implementation to identify unknowns.

### Step 1: Identify Knowledge Gaps

```
Before we start implementation, let's increase our understanding.

Identify what needs to be thoroughly inspected and what confirmations we need regarding:
- Generic logic patterns
- Providers and external services
- Frameworks and libraries
- Code execution result types
- Use cases and edge cases

Document this in:
devdocs/enhancements/[enhancement_name]/gaps_to_fill/gap_list.md
```

### Step 2: Resolve Gaps via Code Inspection

```
For each item in the gap list, find ones resolvable by inspecting existing code.

For each resolvable gap:
- Analyze the relevant code
- Document your understanding
- Do NOT implement anything yet

Put answers in:
devdocs/enhancements/[enhancement_name]/gaps_to_fill/answers/

For gaps that cannot be resolved by code inspection alone
(requires external dependency info, data files, etc.), add them to:
devdocs/enhancements/[enhancement_name]/gaps_to_fill/help_needed_gap_list.md
```

---

## Output Structure

```
devdocs/enhancements/[enhancement_name]/
├── gaps_to_fill/
│   ├── gap_list.md              # All identified gaps
│   ├── help_needed_gap_list.md  # Gaps requiring human input
│   └── answers/                 # Resolved gaps
│       ├── gap_1_answer.md
│       ├── gap_2_answer.md
│       └── ...
```

---

---

## File Relevance Mapping

Use this to identify which files are relevant to a task before starting work.

### Prompt Template

```
Based on the given task definition, explore the codebase and generate a file relevance map.

Use tree command (only include code and config files) and output the results
in devdocs/[task_name]/relevant_files.md

Mark each file with a tier:

🔴 HOT - Will be actively changed during this task
🟡 WARM - Relevant for understanding, mostly read-only reference
⚪ COLD - Irrelevant to this task

Example output format:

src/
├── 🔴 auth/
│   ├── 🔴 login.py          # Main file to modify
│   └── 🟡 session.py        # Need to understand session handling
├── 🟡 models/
│   └── 🟡 user.py           # Reference for user schema
├── ⚪ utils/
│   └── ⚪ helpers.py        # Not relevant
└── 🔴 tests/
    └── 🔴 test_auth.py      # Tests to update

Task definition:
[INSERT TASK HERE]
```

### Why This Matters

Before touching code, you need to know:
- What files you'll modify (HOT)
- What files provide context (WARM)
- What files to ignore (COLD)

This prevents:
- Missing important dependencies
- Wasting time reading irrelevant code
- Breaking things you didn't know were connected

---

## Why This Matters

Rushing into implementation without understanding leads to:
- Incorrect assumptions baked into code
- Rework when assumptions prove wrong
- AI drift from actual requirements

Taking time to identify and resolve gaps upfront saves significant time downstream.
