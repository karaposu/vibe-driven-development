

Based on the provided data, please explain what this project is, what it aims to achieve, and what goals and outcomes are desired. 
Please provide a comprehensive overview without diving into technical implementation details or code. 
Focus on clear articulation and ensuring mutual understanding of the project's purpose and scope.

After that, use your comprehensive explanation to create the following documentation files in the root directory:
- project_description.md - A clear overview of what we're building
- philosophy.md - The core principles and approach
- known_requirements.md - All identified requirements at this stage



if not existent create a devdocs folder, this folder will contain all future development related documentations


and also using these project_description.md, philosophy.md,  known_requirements.md
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


```
Please propose the most suitable architecture for this project. Keep in mind that we'll be developing iteratively, 
evolving from a simple prototype to more complex versions over time.

Key considerations:
- Avoid over-engineering or excessive complexity at this stage
- The architecture will evolve as we progress, so maintain flexibility
- Focus on high-level concepts that can accommodate the project's core requirements
- Present a design that balances simplicity with extensibility
- Make sure to use proper design patterns (e.g., repository pattern for DB related operations)

Please save your architectural proposal as architecture.md


Based on the project description and architecture, please generate:

1. A comprehensive list of core modules with detailed explanations for each:
   - Primary purpose and functionality
   - Core responsibilities
   - Integration points with other modules
   
2. A complete folder structure for the project that reflects this modular organization

Please ensure the modules are properly decoupled to facilitate independent development and testing.




