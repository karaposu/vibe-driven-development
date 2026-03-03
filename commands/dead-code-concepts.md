# /dead-code-concepts — Dead Concept Inventory

Analyze dead code at a concept level. While `/dead-code-index` identifies unused code, this identifies unused *ideas* — higher-level patterns, frameworks, business logic, or architectural decisions that no longer serve the codebase.

Requires `/dead-code-index` to have been run first.

## Additional Input/Instructions

$ARGUMENTS

---

## Instructions

Read `devdocs/archaeology/dead_code_index.md`. If it doesn't exist, tell the user to run `/dead-code-index` first.

A concept is anything categorizable in a meaningful way: technical framework usage, business logic domain, design pattern, architectural approach, methodology, or convention.

Group the dead code candidates by the concepts they belong to. A concept is dead when all or most of its implementing code is unused — not just one orphaned function, but an entire idea that the codebase has moved past.

Look for:
1. **Dead technical concepts** — frameworks partially adopted then abandoned, libraries imported but unused, patterns started but never completed
2. **Dead business concepts** — feature domains with no live code paths, business rules that nothing enforces, workflows that are unreachable
3. **Dead design concepts** — abstractions that nothing uses, interfaces with no implementations, patterns applied inconsistently and abandoned in parts
4. **Dead architectural concepts** — layers that are bypassed, modules that exist structurally but serve no purpose, conventions followed in some files but ignored everywhere else
5. **Dead methodology artifacts** — test strategies that cover nothing live, documentation patterns that reference removed code, config structures for defunct processes

For each dead concept, document:
- **Concept name** — short descriptive name
- **Category** — technical framework / business logic / design pattern / architecture / methodology / convention
- **Dead code entries** — which entries from dead_code_index.md belong to this concept (reference by file and location)
- **Coverage** — what percentage of this concept's code is dead (all / most / partial)
- **Assumed story** — what likely happened? Was it abandoned mid-implementation, replaced by something else, or made obsolete by a design change? Inference, not fact.
- **Still alive parts** — if any code from this concept is still live, list it. This prevents accidentally removing something that's partially in use.

### Output

Write the results to `devdocs/archaeology/dead_concepts_index.md` (create the directory if needed). If the file already exists, overwrite it completely — rewrite fresh, don't patch.
