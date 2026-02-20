Okay your task for now is to improve a prompt

We have such prompt for Generating the critic.md agaisnt created implementation plan. 
With created critic.md how we usually plan and improve the plan later on so it is vital that critic catches problems and correct ones, the ones that matter. 

----
Now based on the feature implementation plan (reread it ully)

I want you ultrathink and  and Identify ERRORs, compatibility ISSUES, RISKS and CONFLICTS with respect to whole codebase's work logic. Check if this implementation plan causes:
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

Rate each risk as: Low/Medium/High
Suggest mitigation strategies for Medium/High risks.

Analyze how this feature will interact with the existing codebase:

1. Read all relevant module interfaces and implementations
2. Create devdocs/enhancements/db_indexing/stage1/critic.md

----


but this prompt is too generic and doesnt cover well our current active task  which is Frontend related

ANd it matters that critic prompt should be created using already existing codebase. 

and create me a better critic prompt which asks the correct questions for this given implementation plan 

output the prompt here