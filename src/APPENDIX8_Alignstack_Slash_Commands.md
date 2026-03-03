# APPENDIX 8: ALIGNSTACK SLASH COMMANDS

## What Are Slash Commands?

Slash commands are reusable prompts packaged as markdown files. In Claude Code, you type `/command-name` and the contents of the corresponding `.md` file get injected as a prompt — with your input substituted in.

They turn multi-paragraph prompts you'd otherwise type (or copy-paste) every time into one-word shortcuts. Each command is self-contained: one prompt in, one artifact out.

Slash commands live as `.md` files in a `commands/` directory:
- **Project-level**: `.claude/commands/` — available only in that project
- **Global**: `~/.claude/commands/` — available in every project

## Installation

Install all AlignStack slash commands globally with one line:

```bash
curl -sL https://raw.githubusercontent.com/karaposu/alignstack/main/commands/install.sh | bash
```

This downloads all slash commands and hooks into `~/.claude/` so they're available in every project you open with Claude Code.

To install for a single project only, copy the `commands/` folder contents into `.claude/commands/` in your project root.

### Activating the devdocs metadata hook

The installer downloads the `devdocs_metadata_appender.sh` hook to `~/.claude/hooks/`. To activate it, add this to your `.claude/settings.json` (project) or `~/.claude/settings.json` (global):

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/devdocs_metadata_appender.sh"
          }
        ]
      }
    ]
  }
}
```

This automatically prepends a metadata header (date, branch, commit, author) to every file written under `devdocs/`. See Appendix 9 for the metadata format.

---

## Core Commands

These four commands form the primary AlignStack workflow. Each produces an artifact that the next can consume, but all work independently.

```
/elaborate → /task-desc → /task-plan → /critic
```

`/elaborate` and `/task-desc` serve different purposes: `/elaborate` takes messy input and makes it readable — no structure imposed, just clarity. `/task-desc` takes that clear input and shapes it into a formal feature description with problem statement, success criteria, and scope. One tidies, the other structures for implementation.

### `/elaborate`

Take messy, scattered input and make it tidy — structured, clear, and easy to read. Accepts raw text, file paths, images or all. Saves the output as markdown and flags important ambiguities.

The primary goal is clarity, not task analysis. Alignment verification is a side effect.

**Input**: Raw text, file path, or file path + additional text
**Output**: Structured rephrasing saved as markdown + printed in conversation

[View full command](../commands/elaborate.md)

---

### `/task-desc`

Generate a structured feature description (`desc.md`) with problem statement, user value proposition, success criteria, scope boundaries, and priority level.

Follows the project's existing `devdocs/` folder conventions for output location. Confirms where to save before writing.

**Input**: Feature description, `/elaborate` output, or raw notes
**Output**: `desc.md` at confirmed location

[View full command](../commands/task-desc.md)

---

### `/task-plan`

Generate a step-by-step implementation plan (`step_by_step_plan.md`) based on a feature description. Reads all relevant code to understand existing patterns before writing.

If multiple `desc.md` files exist, lists them and asks which feature to plan for.

**Input**: `desc.md` file path, `/elaborate` output, or direct description
**Output**: `step_by_step_plan.md` in the same directory as the `desc.md`

[View full command](../commands/task-plan.md)

---

### `/critic`

Analyze an implementation plan and identify errors, risks, conflicts, and compatibility issues. Produces a `critic.md` with each risk rated by severity, with ELI5 explanations and mitigation strategies.

If multiple plans exist, lists them and asks which to critique before proceeding.

**Input**: `step_by_step_plan.md` file path or direct plan description
**Output**: `critic.md` in the same directory as the plan

[View full command](../commands/critic.md)

---

### `/critic-d`

Dynamic variant of `/critic`. Instead of using a generic checklist, it first generates a tailored critic prompt based on the specific plan and codebase context, saves it as `dynamic_critic_prompt.md` for inspection, then executes it after user confirmation.

Two-phase process:
1. Generate and save the dynamic prompt — user reviews it
2. Execute the prompt and write `critic.md` — only after user confirms

**Input**: `step_by_step_plan.md` file path or direct plan description
**Output**: `dynamic_critic_prompt.md` + `critic.md` in the same directory as the plan

[View full command](../commands/critic-d.md)

---

## Analysis & Sensemaking

### `/sense-making`

Run the Structural Sensemaking Framework against any input. Transforms vague or complex input into stable understanding through five phases: anchor extraction, perspective checking, ambiguity collapse, degrees-of-freedom reduction, and conceptual stabilization. Produces six progressive Sense Versions (SV1–SV6).

**Input**: Raw text, file path, or file path + additional text
**Output**: Full sensemaking analysis saved as markdown

[View full command](../commands/sense-making.md)

---

## Archaeology Commands

These commands are for understanding existing codebases. They read code (not documentation) and produce honest assessments of what the project actually is and how it's built.

### `/arch-small-summary`

Read all code files and produce a non-technical summary of the project — what it does, what state it's in, who would use it. Based purely on code behavior, not what docs claim.

**Input**: Optional `-n` flag (no save)
**Output**: Saves to `devdocs/archaeology/small_summary.md` + prints in conversation

[View full command](../commands/arch-small-summary.md)

---

### `/arch-intro`

Produce a high-level architecture introduction covering data flow paths, main abstractions, and top-level design patterns. Written as if onboarding a new engineer on their first day.

**Input**: Optional `-n` flag (no save)
**Output**: Saves to `devdocs/archaeology/intro2codebase.md` + prints in conversation

[View full command](../commands/arch-intro.md)

---

### `/arch-traces`

Trace every internal interface and submodule-level interaction end-to-end. Creates one file per trace with core sections (entry point, execution path, resource management, error path, performance, observable effects, design rationale) and assessment sections (incomplete, vulnerable, bad design — each with ELI5, impact, and fixes).

**Input**: None
**Output**: One file per trace in `devdocs/archaeology/traces/`

[View full command](../commands/arch-traces.md)

---

### `/arch-top-improvements`

Based on existing traces, identify the 5 highest-impact improvements for the codebase. For each, explains why it matters, what it affects, and a plausible reason it hasn't been done yet (respecting that there may be undocumented decisions behind the current state).

Requires `/arch-traces` to have been run first.

**Input**: None
**Output**: `devdocs/archaeology/top_improvements.md`

[View full command](../commands/arch-top-improvements.md)

---

### `/dead-code-index`

Scan the codebase and inventory all unused code candidates — unreferenced files, dead code paths, commented-out blocks, duplicate implementations, abandoned features, orphaned tests and configs. Each candidate gets structured fields (imported by, called by, used in configs, dynamic loading, attached concepts, assumed intent, confidence) plus a ready-to-run grep command for manual verification.

Does not delete anything — inventory only.

**Input**: None
**Output**: `devdocs/archaeology/dead_code_index.md`

[View full command](../commands/dead-code-index.md)

---

### `/dead-code-concepts`

Analyze dead code at a concept level. Groups dead code entries from `/dead-code-index` into higher-level concepts — technical frameworks, business logic, design patterns, architecture, methodology, conventions — and identifies which ideas the codebase has moved past entirely.

Requires `/dead-code-index` to have been run first.

**Input**: None
**Output**: `devdocs/archaeology/dead_concepts_index.md`

[View full command](../commands/dead-code-concepts.md)

---

## Quick Reference

| Command | What it does | Output |
|---------|-------------|--------|
| `/elaborate` | Tidy up messy input | Markdown file(s) + conversation |
| `/task-desc` | Structured feature description | `desc.md` |
| `/task-plan` | Step-by-step implementation plan | `step_by_step_plan.md` |
| `/critic` | Risk/error/conflict analysis (generic) | `critic.md` |
| `/critic-d` | Risk analysis (dynamic, two-phase) | `dynamic_critic_prompt.md` + `critic.md` |
| `/sense-making` | Structural sensemaking analysis | Markdown file(s) |
| `/arch-small-summary` | Non-technical project summary | `devdocs/archaeology/small_summary.md` + conversation |
| `/arch-intro` | Architecture introduction | `devdocs/archaeology/intro2codebase.md` + conversation |
| `/arch-traces` | End-to-end interaction traces | `devdocs/archaeology/traces/` |
| `/arch-top-improvements` | 5 highest-impact improvements | `devdocs/archaeology/top_improvements.md` |
| `/dead-code-index` | Inventory unused code candidates | `devdocs/archaeology/dead_code_index.md` |
| `/dead-code-concepts` | Group dead code into dead concepts | `devdocs/archaeology/dead_concepts_index.md` |

## Hooks

| Hook | What it does | Trigger |
|------|-------------|---------|
| `devdocs_metadata_appender.sh` | Auto-injects metadata header (date, branch, commit, author) into devdocs files | `PreToolUse` on `Write` |

[View hook script](../hooks/devdocs_metadata_appender.sh)
