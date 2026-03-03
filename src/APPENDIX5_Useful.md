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

---

## Dead Code Indexer

Use this to identify unused code before cleanup. Never delete immediately — code that looks unused might be loaded dynamically, referenced in configuration, used by external systems, or kept for compliance reasons.

```
Scan the entire codebase and identify unused code candidates:

1. Unreferenced files and modules — files that no other file imports or requires
2. Dead code paths — functions, methods, or classes that are defined but never called
3. Commented-out code blocks — substantial blocks of commented code (not explanatory comments)
4. Duplicate implementations — multiple implementations of the same logic
5. Abandoned features — partially built features that are unreachable from any entry point
6. Orphaned test files — tests for code that no longer exists
7. Orphaned configuration — config entries that reference nothing in the codebase

For each candidate, document:
- **File and location** (file path + line range)
- **What it is** (function, class, file, config entry, etc.)
- **Imported by** — up to 3 files that import this, or "none"
- **Called by** — up to 3 callers, or "none"
- **Used in configs** — up to 3 config files that reference this, or "none"
- **Possible dynamic loading** — yes/no (plugin systems, reflection, string-based imports, registries, etc.)
- **Attached concepts** — short tags for what domain/area this belongs to (e.g. `payment system`, `auth`, `db connection`, `test`)
- **Why it appears unused** — natural language summary of the above fields
- **Assumed intent** — based on the code's content (naming, structure, fields, parameters), what was this likely meant to do? What direction was it heading? This is inference, not fact — label it as such.
- **Confidence** (Definite / Likely / Uncertain)
- **Search command** — a ready-to-run `grep -rn` command to find all mentions of this code in the codebase

Do NOT delete anything. This is an inventory only.

Write the results to devdocs/archaeology/dead_code_index.md
```

---

## Dead Concept Indexer

Use this after running the Dead Code Indexer. While dead code identifies unused *code*, dead concepts identifies unused *ideas* — higher-level patterns, frameworks, business logic, or architectural decisions that no longer serve the codebase.

A concept is anything categorizable in a meaningful way: technical framework usage, business logic domain, design pattern, architectural approach, methodology, or convention.

```
Read devdocs/archaeology/dead_code_index.md and analyze the dead code entries at a concept level.

Group the dead code candidates by the concepts they belong to. A concept is dead when all or most of its implementing code is unused — not just one orphaned function, but an entire idea that the codebase has moved past.

Look for:
1. Dead technical concepts — frameworks partially adopted then abandoned, libraries imported but unused, patterns started but never completed
2. Dead business concepts — feature domains with no live code paths, business rules that nothing enforces, workflows that are unreachable
3. Dead design concepts — abstractions that nothing uses, interfaces with no implementations, patterns applied inconsistently and abandoned in parts
4. Dead architectural concepts — layers that are bypassed, modules that exist structurally but serve no purpose, conventions followed in some files but ignored everywhere else
5. Dead methodology artifacts — test strategies that cover nothing live, documentation patterns that reference removed code, config structures for defunct processes

For each dead concept, document:
- **Concept name** — short descriptive name
- **Category** — technical framework / business logic / design pattern / architecture / methodology / convention
- **Dead code entries** — which entries from dead_code_index.md belong to this concept (reference by file and location)
- **Coverage** — what percentage of this concept's code is dead (all / most / partial)
- **Assumed story** — what likely happened? Was it abandoned mid-implementation, replaced by something else, or made obsolete by a design change? Inference, not fact.
- **Still alive parts** — if any code from this concept is still live, list it. This prevents accidentally removing something that's partially in use.

Write the results to devdocs/archaeology/dead_concepts_index.md
```
