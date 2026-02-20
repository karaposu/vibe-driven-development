Okay your task for now is to improve a prompt

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
The critic prompt should be generated dynamically, informed by the existing codebase. It needs to ask the right questions for this particular implementation plan, not just a generic checklist.


Based on context you have of the codebase, task itself and step by step plan; generate an improved critic prompt tailored to the given implementation plan and output it below.

