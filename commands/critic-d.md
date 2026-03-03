# /critic-d — Dynamic Critic (Two-Phase)

Generate a context-aware critic prompt tailored to a specific implementation plan, save it for review, then execute it. Unlike `/critic`, this doesn't use a generic checklist — it builds a custom one based on your codebase and plan.

## Additional Input/Instructions

$ARGUMENTS

## Instructions

### Step 0: Resolve Which Plan to Critique

Use your understanding of the already developed context or given Additional Input/Instructions (can be about codebase workspace, or past conversation regarding this topic etc) to interpret what is the relevant step by step plan path, 

If multiple plans are referred in past recent messages (check last 4,5 messages)  — present them as a numbered list and ask the user to confirm which one to critique. Do NOT proceed until the user confirms.

**If only one plan exists** — show the user which plan you found and ask for a quick confirmation before proceeding.


**Only after the user confirms**, continue to Phase 1.

---

### Phase 1: Generate the Dynamic Critic Prompt




Okay your task in Phase 1 is to improve a prompt

We have a prompt for generating `critic.md` against an already created implementation plan. Since the critic drives how we revise and improve the plan, it is vital that it catches the right problems — the ones that actually matter.

Here prompt starts:
----
Now based on the implementation plan

I want you ultrathink and Identify ERRORs, compatibility ISSUES, RISKS and CONFLICTS with respect to whole codebase's work logic. Check if this implementation plan causes:
- Existing features that might break
- Performance implications
- API contract changes
- Database schema impacts
- Security considerations

Document:
- Potential conflicts or breaking changes or errors.
- API contract changes required
- Which existing features might be affected
- Database schema impacts
- Security considerations
- Required refactoring before implementation
- Performance implications (latency, memory, storage)

Rate each risk (severity) as: Low/Medium/High
For each Medium/High risk, suggest three levels of mitigation: a quick fix, a robust fix, and a long-term fix.
Each Item should have impact field (possible effects of this Risk Item ), ELI5 field (non technical explanaition),

Analyze how this feature will interact with the existing codebase:

1. Read all relevant module interfaces and implementations
2. Create critic.md in relevant devdocs folder (same folder as our step by step plan file )

----

But this prompt is too generic — it doesn't account for the specifics of the current task.
The critic prompt should be generated dynamically, informed by the concepts of existing codebase. It needs to ask the right questions for this particular implementation plan, not just a generic checklist.


Based on context you have of the codebase, task itself and step by step plan; generate an improved critic prompt tailored to the given codebase and feature itself

 - Make sure generated custom critic is still generic enough but also questions are towards correct and relevant concepts of the feature and the codease, otherwise next phase might miss undocumented details. We want custom critic to be custom tailored to the concepts of the codebase and the feature itself and not to implementation details.    

 - Make sure generated prompt includes output instructions "Create a `critic.md` file in the same directory as the implementation plan. And this output file has high level summary on top". 

 - Make sure generated prompt includes:

 """
## Output Format

For each risk found, document:

Desc, Risk Desc, Severity (| Low / Medium / High |), Impact, ELI5 desc, Affected areas,  Mitigation** (Medium/High only) and Category (| Breaking change / Import error / Circular import / Package discovery / Stale cache / Missing file / Phase ordering |)

 """

  - Save the generated prompt** as `dynamic_critic_prompt.md` in the same directory as the `step_by_step_plan.md`.
 - Print the generated prompt** in the conversation so the user can read it.
 - Ask the user: *"Here's the dynamic critic prompt I generated. Should I run it now?"*

**Do NOT proceed to Phase 2 until the user confirms.**



---

### Phase 2: Execute the Dynamic Critic Prompt

1. Execute the saved `dynamic_critic_prompt.md` against the implementation plan and codebase.
2. Write the results to `critic.md` in the same directory as the plan.

---

## Output Format (for the generated critic.md)

For each identified risk item, document:

| Field | Description |
|-------|-------------|
| **Risk** | What could go wrong |
| **Category** | Breaking change / Performance / Security / API contract / Schema / Compatibility...|
| **Severity** | Low / Medium / High |
| **Impact** | Possible effects if this risk materializes |
| **ELI5** | Non-technical explanation anyone can understand |
| **Affected areas** | Which existing features, modules, or endpoints are affected |
| **Mitigation** (Medium/High only) | Three levels: quick fix, robust fix, long-term fix |

## Phase 2 Guidelines

- Be specific. "This might cause performance issues" is useless. "Adding a full table scan in `getUsers()` on a table with 100k+ rows will degrade response time from ~50ms to ~2s" is useful.
- Only flag real risks. Don't pad the document with low-severity noise that obscures actual problems.
- Every Medium/High risk must have actionable mitigation — not just "be careful."

