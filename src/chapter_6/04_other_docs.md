

## Other Devdoc Files

### decisions.md

this document is to log architectural decisions with their reasons. 
This is important to anchor our development progress cross sessions. 
Sometime we come across a bug or edge case scenario where we are spend hours coming up with an elegant solution design or architecture tweak to solve it. But such solution is not clear from the very beginning and if AI somehow
loses the context then when it looks at this design without the edge case in mind it can decide this is something uncessary and break the delecate solution. 


Each entry in this document explains 
    - what is current bottleneck/issue
    - what are the options considered
    - what option is selected and why
    - Explain in a high level what consequences this change might cause 

it looks like this:

```markdown
# Architectural Decisions

## 2024-01-15: Use SQLite for local storage
- Considered: JSON files, SQLite, Realm
- Chose SQLite for: SQL queries, proven reliability, zero config
- Trade-off: Slightly larger app size

## 2024-01-20: Monolith over microservices
- Keeps deployment simple
- Single user app doesn't need service separation
- Can split later if needed
```



