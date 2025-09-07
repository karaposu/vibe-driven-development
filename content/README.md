# Vibe Coding Guidelines for GPT5 & Claude Code

I've been vibe coding with LLMs since GPT-4, and now extensively with Claude Code. These guidelines represent hard-won insights from real-world projects.

### 0. Establish Ground Rules

Before starting any project, establish these ground rules with AI:

- Avoid mocks/stubs unless absolutely necessary for external dependencies
- For each file you generate put the relative path as comment at the top
- During active development, skip legacy compatibility concerns - you can add them later if needed
- If git is initialized, use it to commit changes with proper commit messages in suitable times

```
For this project, please follow these development guidelines:
1. Avoid using mocks or stubs unless absolutely necessary for external dependencies
2. Include # filepath: path/to/file at the top of every code file you create
3. Focus on modern implementation patterns without legacy compatibility concerns
4. When making changes, provide git commit messages in conventional format (e.g., "feat:", "fix:", "docs:")


```

### 1. Data Dump

Before writing any code, thoroughly brief AI on your project. Share all documentation including project description, existing code files, goals and desired outcomes, and non-technical specifications.

Request AI to comprehensively explain:
- What this project is and what it aims to achieve
- What are the core challenges for this project
- The core philosophy and known requirements
- Explicitly ask AI to prevent code generation at this stage and focus on clear articulation

Then ask AI to create comprehensive documentation files: `project_description.md`, `philosophy.md`, and `known_requirements.md` 

Prompt Sample:

```
Based on the provided data, please explain what this project is, what it aims to achieve, and what goals and outcomes are desired. 
Please provide a comprehensive overview without diving into technical implementation details or code. 
Focus on clear articulation and ensuring mutual understanding of the project's purpose and scope.

After that, use your comprehensive explanation to create the following documentation files in the root directory:
- project_description.md - A clear overview of what we're building
- philosophy.md - The core principles and approach
- known_requirements.md - All identified requirements at this stage


```

Make sure to read these 4 files and correct any misunderstandings or overdefinitions.



### 2. "devdocs" Design Pattern 
devdocs pattern is one of the core design patterns for vibe coding. 
The idea is to use excessive documentation as a source of truth together with code.
Devdocs matters because during development "why" can matter as much as "how" and to keep track of 
both context is really important.

"""
create a devdocs folder, this folder will contain all future development related documentations
"""

### 3. Concept Clearification 

"""
and also using these project_description.md, philosophy.md,  known_requirements.md
 create me 
   - `concepts.md`  by extracting the key
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



### 4. Concept Simplification 

The concept_clarifications dir contains many concepts. And implementing each of them with their full scope is not a good idea.  And there is a high chance when you read all 
these full scope concepts you felt overwhelmed and it will be same for ai too. Our job as a human in the loop is to 
make AI do the work in a modular gradual increments.  

So at first we want to create a working prototpye and then expand this prototype to MVP over time. 
This is why first we will ask AI to create simplified_concepts_to_implement.md file. 

But when it is simplifiying these features it must not oversimplify the concept that in the end when we are going to expand the features we would need full rewrite of databases and submodules. 

This is a step where you get to be human in the loop and actually do some real work. It is vital for the rest of the development that you edit the these simplified concept files. Make sure you read them and clarify anything which doesnt make sense. 

"""
I want you to create simplified_concepts.md using concepts.md and the goal is to trim the features but the core ones for each concept so we can still have these concepts but they are more about prototype. 

And make sure you follow these rules during simplification
        - do not oversimplify the concept to the point underlying architecture is oversimplified and does not support the original concept
        - if a concept has a support for multi subconcept, do not binarize it but diminish the number of supported subconcepts by priotizing the most important ones. 

And then for each concept in simplified_concepts.md create me a clarification markdown file
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


### 2. Creating a Vague Decoupled Architecture

Architecture should be intentionally fuzzy at first to compensate for missing requirements
- Avoid getting too complex or too specific early
- Let the design solidify naturally through next steps
- Focus on high-level concepts that can handle the project's requirements
- Save the result to architecture.md


Prompt Sample:

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
```

### 3. Critique the Architecture

The resulting architecture is probably adequate, but during implementation AI may miss or forget how requirements relate to architecture.

- Ask AI to perform a compatibility check between architecture.md and all project data, improving it and saving it back to architecture.md
- Again, remind AI to avoid getting too complex or too specific early
- Ask AI to create requirements_and_architecture.md showing how each known requirement maps to the architecture

Prompt Sample:

```
Please review architecture.md and perform a comprehensive compatibility check against all project data and requirements.
If you identify any significant issues or gaps, please update architecture.md accordingly.

Additionally, create requirements_and_architecture.md that maps each known requirement to its corresponding 
architectural component, demonstrating how the architecture addresses each requirement.

Remember to maintain appropriate simplicity - we're aiming for a lean, evolvable architecture, not an over-engineered solution.
```

### 4. Designate Core Modules and Define Folder Structure

- Decoupled core modules enable isolated testing, which is essential for vibe coding success
- We want AI to test modules individually, then integrate them, then test the integration. While this adds extra steps, it generates cleaner code and provides early warnings for design issues

```
Based on the project description and architecture, please generate:

1. A comprehensive list of core modules with detailed explanations for each:
   - Primary purpose and functionality
   - Core responsibilities
   - Integration points with other modules
   
2. A complete folder structure for the project that reflects this modular organization

Please ensure the modules are properly decoupled to facilitate independent development and testing.
```

### 5. Implement One Module as Starting Point

- Choose tool-like helper modules first
- The Gradual Integration principle follows this order: Peripherals → Core → Integration
- The goal is to build peripherals before integrators
- Ask AI for all files and contents for your chosen module
- If more than 5 files are generated, this signals the module should be refactored into submodules

```
I'd like to begin implementation with the [module_name] module. Based on our previous discussions and documentation, 
please provide:

- Complete file list with their respective directory paths
- Full implementation for each file
- All necessary code to make this module functional

Please ensure all files include appropriate headers and follow our established conventions.
```

### 6. Document Dependencies and Interfaces

- After implementing a module in step 5, evaluate its interface - this is essential for future integration tests
- Ask AI "What external libraries does this module need?" and save the response as external_dependencies.md in the module folder
- Then ask "What are the interfaces to other modules?" and save as interface.md in the same folder
- These interface.md files and all other docs should be updated as the codebase evolves, especially after step 8

```
Now that we have implemented [module_name], please analyze its dependencies and interfaces:

1. External Dependencies Analysis:
   - What external libraries does this module require?
   - Please document these in external_dependencies.md within the module folder

2. Module Interface Documentation:
   - What are the public interfaces this module exposes to other modules?
   - How should other modules interact with this one?
   - Please document these in interface.md within the module folder

Ensure both documents are comprehensive and will serve as clear contracts for future integration work.
```

### 7. Design Smoke Tests

- Smoke tests are an excellent way to validate implementation integrity
- In this step, we design the tests without writing them yet
- Ask AI to design at least 5 smoke test files
- Tests should progress from initialization through increasingly complex features
- Each file should contain ~5 subtests
- Ask AI to detail what each test validates and why it matters
- If any test lacks detail, ask AI to expand or divide it
- Save the complete test design to smoke_test_design.md

```
Let's design comprehensive smoke tests to validate our implementation. 
Please create smoke_tests folder if it doesnt exists. and Please create a test plan with the following structure:

- 5 test files, each containing 5 focused test cases
- File naming convention: test_01_[test_focus_area].py, test_02_[next_focus_area].py, etc.
- For each test file, provide:
  - Clear description of what aspect it tests
  - Why this testing area is critical
  - Brief outline of each test case within the file
- these tests shouldnt use any testing frameworks. Make the outputs verbose enough so you can see what exactly does not work 

```

### 8. Implement and Run the First Smoke Test

- Ask AI to read smoke_test_design.md and implement the first smoke test in the smoke_tests folder within the module
- Ask AI to run the test and fix either the test or the implementation code as needed
- Here we want AI to enter an **Iterative Verification** loop, using a test-fix-verify cycle until code pieces grow into compatible implementations
- **Manual Verification:** Always run tests yourself and review terminal output - AI may miss subtle errors or warnings

```
Please read smoke_test_design.md and implement the first test file in the smoke_tests folder within this module.

After implementation:
1. Run the test and identify any failures
2. Fix either the test or the implementation code as needed
3. Ensure all tests pass before proceeding

Important guidelines:
- Avoid using mocks when real components are available
- Pay special attention to edge cases that might cause integration issues later
- Include appropriate logging for debugging purposes
```

### 9. Update Documentation to Reflect Changes

- Since code or tests may have changed during implementation, ask AI to update all relevant documents to stay current

```
Excellent! Now that this smoke test suite is passing, please review and update all relevant documentation 
to reflect any changes made during implementation and testing.

Specifically, please update:
- interface.md if any interfaces changed
- external_dependencies.md if new dependencies were added
- Any other documentation that may have become outdated

This ensures our documentation remains accurate and synchronized with the actual implementation.
```

### 10. Develop Remaining Modules Following Steps 5-9

- Maintain the same rigorous process for each module
- Keep modules as independent and isolated as possible
- When a module uses another module, ensure it references interface.md during implementation and smoke tests
- Continue creating all modules using this consistent approach

### 11. The Refactor Checkpoint

With working modules and passing tests, it's time to refine the architecture and clean the code. Ask AI to identify one core abstraction that would significantly improve code clarity and maintainability.

- Have AI document the proposal in architecture_improvement.md
- Review to determine if refactoring is worthwhile
- If yes, implement the refactor and rerun all smoke tests

Prompt Samples:

```
Now that we have working modules with passing smoke tests, let's step back and evaluate our architecture holistically.

If you were to identify ONE core abstraction that would significantly improve code clarity and maintainability, 
what would it be? Consider:
- Current code duplication or patterns
- Complexity points that could be simplified
- Opportunities for better separation of concerns

Please provide a detailed explanation and save your architectural improvement proposal in architecture_improvement.md
```

```
Please review both architecture.md and architecture_improvement.md, then proceed with the refactoring:

1. Implement the proposed architectural improvements across the codebase
2. Update all affected smoke tests to work with the new structure
3. Run all tests and fix any issues until they all pass
4. Update relevant documentation to reflect the new architecture

This refactoring should result in cleaner, more maintainable code while preserving all existing functionality.
```

### 12. Performance & Security Audit

- Ask AI to review the codebase for performance bottlenecks and security vulnerabilities
- Save the results in security_audit.md in the root directory
- If major issues need immediate attention, ask AI to create architecture_improvement.md based on security_audit.md
- Then use architecture_improvement.md to guide the refactoring process

```
Please conduct a comprehensive security audit of our codebase. Focus on:

- Input validation and sanitization
- Authentication and authorization patterns
- Data exposure risks
- Dependency vulnerabilities
- Common security anti-patterns

Document your findings, severity levels, and recommended remediations in security_audit.md in the root directory.
```

### 13. Create Documentation Corpus

- Ask AI to create a docs folder and generate documentation for each module
- Documentation should include edge cases and interface specifications
- This step indicates that our codebase is stabilizing and maturing

### 14. Create Production-Ready Test Suite

- For CI/CD pipeline integration
- Convert smoke tests into the appropriate testing framework for your tech stack (pytest, Jest, JUnit, etc.)
- Leverage comprehensive test coverage from all submodule smoke tests

```
Please analyze all smoke test files across all modules and create a comprehensive test suite in the root directory.

Requirements:
1. Convert smoke tests into properly structured test files using the appropriate framework for this tech stack
2. Organize tests logically for CI/CD pipeline execution
3. Include appropriate test utilities and helpers specific to the chosen framework
4. Generate test documentation that explains the testing strategy and coverage

This will serve as our production-ready test suite for continuous integration.
```

### 15. Create Comprehensive README

- Generate complete project documentation
- Include setup instructions and architecture overview
- Ensure the README reflects the current state of the codebase

```
Please create a comprehensive README.md file for the project root by:

1. Reading and synthesizing all documentation in the docs folder
2. Reviewing all .md files throughout the project
3. Creating a professional README that includes:
   - Project overview and purpose
   - Installation and setup instructions
   - Architecture overview with key components
   - Usage examples and API documentation
   - Testing instructions
   - Contributing guidelines

Ensure the README reflects the current state of the codebase and serves as the primary entry point for new developers.
```