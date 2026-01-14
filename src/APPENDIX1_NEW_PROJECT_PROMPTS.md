# VIBE CODING A NEW PROJECT 

This appendix document contains ready-to-use prompts for IDEA -> PROTOTYPE.  These prompts contains established vibe coding patterns. Their detailed explanations can be found in related chapters.  

Take attention that phase 7-13 should be repeated many times as the modules are needed. 

      0 → 1 → 2 → 3 → 4 → 5 → 6 → ┌─[7 → 8 → 9 → 10 → 11 → 12]─┐ → 13 → 14
                                    └─────────────←───────────────┘
                                          (loop for each module)



##  IMPORTANT NOTES:
   - Do not forget to act as a human in the loop. Read each generated documentation and fix any misunderstanding asap. Otherwise they can propagate and cause bigger errors
   - Remind AI keep the core documents and smoke tests to upto date after any change. 
   - Understand the flow so you can intervene. Create as many as free style documents. 
   - It is okay that your understanding of the project will change and you may feel like starting over especially with documentations. Do it. But instead of deleting old devdocs folder just rename it to deprecated. You may refer to them later. 
   - Dont forget to git push your code. AI is not almighty and it can mess things up. 


## COMPLETE PHASES AND PROMPTS

### Phase 0: Data Dump


Provide the AI with all project-relevant information. This is essential. Don't rush to over-define your project at this stage - fuzzy, incomplete details are fine. You'll have opportunities to refine and clarify later. During Phase 1, this information will be processed into three structured documents. 

If you have multiple information sources, consolidate them into a data_dump.txt file. Include these four aspects (even if vaguely defined):
  - Project purpose: Your goals from a non-technical perspective
  - Tech stack preferences: Any preferred technologies or frameworks
  - Target platforms: Mobile, web, embedded, etc.
  - Priorities: Relative importance of platforms, features, and objectives




### Phase 1: Foundation Documents

This phase is explained in detailed in chapter_6/01_devdocs_pattern.md and chapter_6/02_root_docs.md



```
Based on the provided project information, I need you to establish the DevDocs pattern foundation.

First, analyze the project requirements and create a clear understanding of what we're building.
Create the following foundation documents:

1. devdocs/foundations/project_description.md
   
   What are we building?
   What problem are we solving
   What are the various scopes of this project?
   Who are the targeted users?


2. devdocs/foundations/philosophy.md
   - what is the philosophy of this project? (dont go into technical details)

   
3. devdocs/foundations/known_requirements.md
   - Technical requirements
   - Business requirements 
   - User requirements 

Focus on clarity and mutual understanding before any implementation.
```

### Phase 2: Concept Extraction and Clarification

This phase is explained in detail in chapter_6/03_concept_docs.md 

```
Using the foundation documents you just created (project_description.md, philosophy.md, known_requirements.md), 
extract and document the key core concepts (only needed and core ones):

1. Create devdocs/concepts/concepts.md
   - List only essential technical concepts
   - Order by importance/dependency
   - Brief one-line description for each

2. For each concept, create detailed clarification in devdocs/concepts/concept_clarifications/
   Name files with ordering prefixes (01_[concept].md, 02_[concept].md, etc.)
   
   Each clarification must answer:
    - Clear short explanation what it is and why it matters
    - How this concept helps the overall project
    - How this concept limits the overall project
    - What kind of information this concept needs as input
    - What kind of process this concept should use
    - What kind of information this concept outputs or relays
    - Explain the good expected outcome of realizing this concept
    - Explain the bad unwanted outcome of realizing this concept


```

### Phase 3: Simplification for MVP

This phase is explained in detail in chapter_6/03_concept_docs.md 

```
I want you to create devdocs/concepts/simplified_concepts.md using concepts.md and the goal is to trim the features but the core ones for each concept so we can still have these concepts but they are more about prototype. 

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

Put 1_ 2_ 3_ like prefix of each file to order them and make sure priotize the core concepts when you are ordering them. and do this in devdocs/concepts/simplified_concept_clarifications/

Critical: The simplification should reduce features, not break architecture and be flexible for future scope expansion
```


### Phase 4: Identifying Modules


We want development to be done in modular way. This ensures project stays in debuggable/testable complexity. 
This step identifies all possible modules. 


```

Review the simplified concepts and identify logical abstractions that can be organized into modules. Focus on creating a modular architecture that will facilitate cleaner, more maintainable development. Ensure the proposed modularity doesn't compromise performance or security requirements. Avoid over-engineering - only modularize major conceptual boundaries. Document your module structure proposal in module_proposal.md

```


### Phase 5: Architecture and Structure


```
Based on the simplified concepts, and module proposal please propose the most suitable architecture for this project. Keep in mind that we'll be developing iteratively, evolving from a simple prototype to more complex versions over time. And our priority is solid foundation whcih can be expanded overtime and not immediate full scope solution. 

Please use the info from module_proposal.md intelligently (you may choose not to accept a module if it is not neccesary or overengineered for the MVP logic ) and avoid tightly coupled architecture. 

Key considerations:
- Avoid over-engineering or excessive complexity or explicity at this stage
- The architecture will evolve as we progress, so maintain flexibility
- Focus on high-level concepts that can accommodate the project's core requirements
- Present a design that balances simplicity with extensibility
- Make sure to use proper design patterns in order to keep modularity of codebase(e.g., repository pattern for DB related operations)

```


### Phase 7: Selecting One module and Preparing for implementation


One way to enforce AI to do the development is done in a moduler way is to implement one by one. 

   
```
 
With the project information, architecture overview, and module structure defined, select the first module for implementation.
   Choose a module that:
  1. Encapsulates the most messy distractive existing code
  2. Is peripheral to the core system (minimal dependencies)
  3. Has stable requirements unlikely to change
  4. Can be implemented independently without requiring other modules to be fully defined first


  And then create devdocs/proposal/[module_name]_module_implementation_proposal.md which explain in order 
  
  1.  what components this modules would have?
  2.  what the interface/endpoints this module would show
  3.  how it would be used with pseudo code
  4.  how it will be used by other/core modules (in a high level without definitive definition)
  5.  make sure the interface is not mixing concerns and modular 
  6.  if selected module is peripheral - it should knows nothing about the business domain, just how to persist and retrieve objects. This makes it:
         - More reusable
         - Easier to test (mock repositories)
         - Clear separation of concerns
         - No mixed responsibilities

```



### Phase 8: Module implementation

 ```

 Please implement this module with required files. Based on our previous discussions and documentation, 
please provide:

- Complete file list with their respective directory paths
- Full implementation for each file
- All necessary code to make this module functional

 ```



### Phase 9: Probe test

Details are explained in chapter_7/probe_tests_pattern.md

```
Let's design comprehensive probe tests to validate our implementation.
Please create probe_tests folder if it doesn't exist.
And Please create a test plan with the following structure:

## Test Structure
1. At least 5 test files, each containing 5 focused test cases
2. File naming convention: test_01_[test_focus_area].py, test_02_[next_focus_area].py, etc.
3. Each test file's top comment should include how to run it manually.


### No Mocking - Real Calls Only
4. Use real components with real API calls and real data, if mocking is absolutely needed then be verbose about this.  
5. No mocking, no faking, no stubbing

### Understand Return Types Before Testing
6. BEFORE writing any test, re-read the actual function/method signature and return type
7. Check what fields indicate success vs failure (e.g., result.success, result.data, result.error)
8. Tests must validate the ACTUAL return structure, not assume exception-based error handling 


### Validate Real Success, Not Just "No Exception"
9. A test passes ONLY if:  No exception was raised, AND The result indicates success with MEANINGFUL data,   
10. Print the actual result data (trim if too long) to verify real MEANINGFUL data is indeed there..
11. Show sample data to prove it's not empty/fake

12. Async and concurrency should be seperately tested in isolation. 
13. Ensure all async operations run within the proper context
14. Test both sequential and concurrent operations within the same context


  ## Test Coverage
  For each test file, cover:
  - Individual functions/methods in isolation
  - How components work together
  - Verify solidly defined requirements are met or not

  ## Output Requirements
  - NO testing frameworks (no pytest, unittest, etc.)
  - Verbose output showing exactly what works and what doesn't
  - Print actual return values, data types, and sample data
  - Clear distinction between:
    - ✅ Real success (got actual data)
    - ❌ Exception raised
    - ❌ Result returned but success=False or data=None/empty
  - Include timing information where relevant

  ## Test File Structure
  Each test file should:
  1. Have each subtest as a separate function
  2. Have one orchestrator function at the end to run all subtests
  3. Show a summary at the end with pass/fail counts

  ## Test Sequence
  1. Start with initialization/connection test file
  2. Progress from simple to complex operations
  3. End with concurrency/stress tests

  ## Before Writing Each Test
  Ask yourself:
  1. What does this function actually return? (Read the source)
  2. How does it indicate failure? (Exception vs result.success=False vs empty data)
  3. What constitutes REAL success? (What data should be present?)
  4. Does it need async context? (Check if it uses async with)

```




1. 5 test files, each containing 5 focused test cases
2. Avoid mocking and use real componenets with real calls with real data. 
3. File naming convention: test_01_[test_focus_area].py, test_02_[next_focus_area].py, etc.
4. Make sure these tests 
      -  Individual functions/methods in isolation 
      -  Test how components work together
      -  Verify solidly defined requirements are met or not
       
5. For each test file, provide:
  - Clear description of what aspect it tests
  - Why this testing area is critical
  - Brief outline of each test case within the file
6. these tests shouldnt use any testing frameworks. Make the outputs verbose enough so you can see what exactly does not work.  
7.  Make sure tests are made in a way that they output related result data in a readable format to prevent false positives. 
8. Start with initialization test file. 
9. Each test file's top comment should include how to run it manually. 

(Write the files in such way that each subtest inside is seperate functin and in the end there is one funciton to orchestrate runnning all of them)

(Tests should test what actually exists, do not create fallbacks etc)



### Phase 10: Running the smoke test and fix the errors

It is important to run smoke tests by ourself. First we will let AI do this and then we should run them by ourselves. 

```
Lets run each smoke test one by one and fix all errors. If you find errors and cant fix them after 3 changes break down the smoke test into a smaller more isolated forms with more verbose outputs ( in smoke tests files) And rerun them. 

if a test is failing lets isolate it in another test file under probe_tests/isolation with relevant name and verbose output and run it again to see what is going on so we can fix according to new understanding we have.

```



### Phase 11: Fuzzy Module Documentation

Now our module is ready and working we should create documentation about it. 

```
 create comprehensive documentation:

Create devdocs/modules/[module_name]/ containing:

1. what_is_this_for.md
   - Core purpose
   - Why it's a separate module
   - What breaks without it
   - Who depends on it

2. interfaces_and_endpoints.md
   - Public methods/functions
   - API endpoints
   - Event emissions
   - Data structures

3. integration_points.md
   - How to integrate this module (only if what to integrate is already defined in the codebase)
   - Multiple integration approaches if flexible
   - Best practices for usage

4. integration_requirements.md
   - Environment variables needed (only if really needed)
   - Database schemas required (only if really needed)
   - External services (only if really needed)
   - Configuration files (only if really needed)

5. limitations.md
   - Performance boundaries
   - Feature boundaries
   - Technical constraints
   - Security limitations

6. possible_use_cases.md
   - Common usage patterns
   - Anti-patterns to avoid
   - Performance tips

7. edge_cases_covered.md
   - Handled edge cases
   - Error scenarios
   - Recovery mechanisms

8. example_usage.md
   - Code examples
   - Setup instructions
   - Common operations
   - Testing approach

9. summary.md
   - Quick reference
   - Main interfaces
   - Critical limitations
   - Integration checklist
```



### Phase 12: INTEGRATION & SMOKE TESTS

```
Now that the module is complete and documented, integrate it with the core system:

  1. Create integration tests between this module and any existing core components under smoke_tests 
  2. Verify the module works within the larger system context
  3. Test data flow between modules
  4. Validate that the module's interfaces are being used correctly
  5. Check for any unexpected side effects or performance impacts
  6. Update smoke tests to include integration scenarios

  Run all tests together to ensure the module doesn't break existing functionality.
  
```


