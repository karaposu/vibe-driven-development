## The Archaeology Pattern: Creating DevDocs for Existing Projects

Retrofitting DevDocs onto an existing codebase is different from starting fresh. You're reverse-engineering understanding from code that may have evolved organically over months or years.

This pattern provides a systematic approach to create DevDocs for projects already in certain developed stage.


Creating DevDocs for existing projects is like archaeological excavation - you're uncovering layers of decisions, patterns, and evolution. When documenting the existing state we must also document the reason the codebase evolved in such way. Otherwise we risk AI simplifiying the architecture into already invalidated state due to edge cases or requirements. 


We again start by data dumb and giving AI all external documentations to consume. 

#### step 0 Creating Root Docs 


Just like normal devdocs pattern we aim to create project_description.md,  philosophy.md, known_requirements.md files

To do that we ask AI to inspect the code files as well.

(If our codebase is evolved enough and in a at least partial working state )




#### Step 2: Project to concepts

and then next step is to create concepts. 

we again create  devdocs/concepts.md 

but as an addition we ask AI to generate

concept_mappings.md file where each concept is mapped to (if it exists in the codebase) codebase and relevant modules/services/classes

with these explanations

 - how much relevant code covers the concept's realization
 - what vital things are missing
 - explain why relevant code is designed in the way it is but not in other way. 
 

and then we use this concept_mappings.md to create 

project_state.md file where project state is explained and summed up 


#### Step 3: Document the Gotchas

Every existing project has landmines:

```
"Search for:
- TODO/FIXME/HACK comments
- Try-catch blocks with specific errors
- Workarounds (strings like 'workaround', 'temporary', 'fix')
- Complex conditional logic

Document these in devdocs/gotchas.md"
```


The Honest Documentation Principle

DevDocs for existing projects must be honest:

- Document what IS, not what SHOULD BE
- Include the hacks and workarounds
- Explain why bad patterns exist
- Admit what you don't understand

This honesty makes DevDocs trustworthy and actually useful, turning your existing project from a mysterious legacy system into a well-understood, AI-navigable codebase.









