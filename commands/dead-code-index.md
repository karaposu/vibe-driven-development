# /dead-code-index — Dead Code Inventory

Scan the codebase and identify unused code candidates. This is an inventory — nothing gets deleted.

## Additional Input/Instructions

$ARGUMENTS

---

## Instructions

Scan the entire codebase and identify unused code candidates:

1. **Unreferenced files and modules** — files that no other file imports or requires
2. **Dead code paths** — functions, methods, or classes that are defined but never called
3. **Commented-out code blocks** — substantial blocks of commented code (not explanatory comments)
4. **Duplicate implementations** — multiple implementations of the same logic
5. **Abandoned features** — partially built features that are unreachable from any entry point
6. **Orphaned test files** — tests for code that no longer exists
7. **Orphaned configuration** — config entries that reference nothing in the codebase

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
- **Mark for removal in future?** — (leave empty — human marks "yes" to approve future removal)

Do NOT delete anything. This is an inventory only.

### Output

Write the results to `devdocs/archaeology/dead_code_index.md` (create the directory if needed). If the file already exists, overwrite it completely — rewrite fresh, don't patch.
