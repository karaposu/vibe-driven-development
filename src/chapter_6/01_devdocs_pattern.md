# The DevDocs Pattern

This is most common vibe coding pattern. And the reason is it fills common pitfalls when it comes to vibe coding. And extremely helpful. 

If you have a specific vision on your mind it is not good idea to let ai go rogue for hours and create something different. It is really important to be on the same page of what is being created. But development is such process where most of the concepts will evolve over time and even though you have a good beginning documentation it is easy to get lost and introduce wrong concepts. 

This is why devdocs pattern is used. It is the realtime projection of AI's mind in format of markdown documents. 

And also without devdocs pattern. When we ask AI to do/implement something, it will include hidden task of planning
as well and due to context limitations memory state might be missing vital info and doing planning and implementation in one step will usuall introduce errors and hallucinations. 

Just like humans, it is easier for AI to focus on one task. This is why we will offload complexity by enforcing a separation between planning phase and implementation phase. 

So Devdocs pattern basically 

1.  we want know what AI thinks before we allow it to do the implemention, in every major step. 
2.  we Let AI document what he should implement before it implements it. 
3.  As a human in the loop we update the documentation according to our vision. 
4.  Devdocs documentation includes active development logic and therefore part of the source code. 



Devdocs include various documents which can be categorized into 3 main categories

- generic project documentation
- dev related documentatiion 
- runing logic documentation 



Here is how sample devdocs folder would look 



## The DevDocs Structure

```
project-root/
└── src/
    ├── devdocs/
    │   ├── project_description.md
    │   ├── philosophy.md
    │   ├── known_requirements.md
    │   ├── concepts.md
    │   ├── simplified_concepts.md
    │   ├── concept_clarifications/
    │   ├── simplified_concept_clarifications/
    │   ├── decisions.md
        ├── enhancements
                  debug_enhancement_proposal.md
    │   └── modules/
    │       └── module_a/
    │           ├── what_is_this_for.md
    │           ├── interfaces_and_endpoints.md
    │           ├── integration_points.md
    │           ├── integration_requirements.md
    │           ├── limitations.md
    │           ├── possible_use_cases.md
    │           ├── edge_cases_covered.md
    │           └── example_usage.md
                └── summary.md
            
        issues/
            solved
                01_issue_tg_connection
                        explaination.md (includes when this issue occurs, and why it is problem in context of whole app) 
                        what_i_learned.md (explains what was done wrongly and why and what was the solition about this issue )
            unsolved
            relevant_to_future
    |
```


Lets start going through the each document and reason why we are having it






### what_I_learned.md

Includes implementation details where AI learned/uncovered things through testing and not obvious from start

This documentation is particularly useful for external package use. Lots of packages/APIs do miss some implementation
details and just like any developer AI also can identify these and it is nice idea to save them to not go through rediscovering them. 
 






## Using DevDocs with AI

### Starting a Session
```
"Please read all files in src/devdocs/ to understand the project context.
Pay special attention to philosophy.md for our core principles."
```

### Working on a Module
```
"I need to work on authentication. Please read:
1. src/devdocs/modules/auth/*.md for module context
2. src/devdocs/simplified_concepts.md for current scope"
```

### Preventing Drift
```
"This suggestion seems complex. Let's check if it aligns with 
our philosophy.md and the limitations.md for this module."
```

## The Living Documentation Principle

DevDocs aren't static:
- Update decisions.md after architectural choices
- Add to explorations.md when trying new approaches
- Expand module docs as understanding deepens
- Mark completed concepts in concepts.md

## Benefits of DevDocs Pattern

1. **AI Alignment**: Every session starts with shared context
2. **Decision History**: Why we built it this way
3. **Scope Control**: Clear boundaries prevent creep
4. **Module Clarity**: Each part knows its role
5. **Evolution Tracking**: See how project developed

## Common Pitfalls

### Over-Documentation
Don't document every function. Document concepts, boundaries, and decisions.

### Under-Documentation
"I'll remember why" - You won't. AI definitely won't.

### Stale Documentation
Update as you build. Outdated docs are worse than no docs.

### Skipping Module Docs
Each module needs its own context. Don't assume it's obvious.

## Quick Start Checklist

- [ ] Create src/devdocs/ structure
- [ ] Write three foundation documents
- [ ] Add decisions.md, explorations.md, notes.md
- [ ] Extract concepts from requirements
- [ ] Create detailed clarifications
- [ ] Simplify for prototype
- [ ] Create module folders as you build
- [ ] Document each module's purpose and boundaries

DevDocs pattern transforms AI from code generator to thoughtful collaborator who understands not just what to build, but why and how it fits together.



















## Concepts Documentation
 
### concepts.md & concept_clarifications

Extract key technical concepts from requirements

"""
Using these project_description.md, philosophy.md,  known_requirements.md
 create me 
   - `concepts_to_implement.md`  by extracting the key
technical concepts (needed ones only and core ones. )

and then for each concept in concepts_to_implement.md create me a clarification markdown file
which includes answer to these questions:
    
    For each concept write
    - clear short explanation what it is and why it matters
    - How this concept helps the overall project
    - How this concept limits the overall project
    - What kind of information this concept needs as input
    - What kind of process this concept should use
    - What kind of information this concept outputs or relays
    - explain the good expected outcome of realizing this concept
    - explain the bad unwanted outcome of realizing this concept

Put 1_ 2_ 3_ like prefix of each file to order them and make sure priotize the core concepts when you are ordering them. and do this in devdocs/concept_clarifications/
"""

### simplified_concepts.md & simplified_concept_clarifications/


The concept_clarifications dir contains many concepts. And implementing each of them with their full scope is not a good idea.  And there is a high chance when you read all 
these full scope concepts you felt overwhelmed and it will be same for ai too. Our job as a human in the loop is to 
make AI do the work in a modular gradual increments.  

So at first we want to create a working prototpye and then expand this prototype to MVP over time. 
This is why first we will ask AI to create simplified_concepts_to_implement.md file. 

But when it is simplifiying these features it must not oversimplify the concept that in the end when we are going to expand the features we would need full rewrite of databases and submodules. 

This is a step where you get to be human in the loop and actually do some real work. It is vital for the rest of the development that you edit the these simplified concept files. Make sure you read them and clarify anything which doesnt make sense. 


"""
I want you to create simplified_concepts_to_implement.md using concepts_to_implement.md and the goal is to trim the features but the core ones for each concept so we can still have these concepts but they are more about prototype. 

And make sure you follow these rules during simplification
        - do not oversimplify the concept to the point underlying architecture is oversimplified and does not support the original concept
        - if a concept has a support for multi subconcept, do not binarize it but diminish the number of supported subconcepts by priotizing the most important ones. 

And then for each concept in simplified_concepts_to_implement.md create me a clarification markdown file
which includes answer to these questions:

 For each concept write
    - clear short explanation what it is and why it matters
    - How this concept helps the overall project
    - How this concept limits the overall project
    - What kind of information this concept needs as input
    - What kind of process this concept should use
    - What kind of information this concept outputs or relays
    - explain the good expected outcome of realizing this concept
    - explain the bad unwanted outcome of realizing this concept

Put 1_ 2_ 3_ like prefix of each file to order them and make sure priotize the core concepts when you are ordering them. and do this in devdocs/simplified_concept_clarifications/

"""













