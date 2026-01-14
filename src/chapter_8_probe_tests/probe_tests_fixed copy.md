

# The Probe Tests Pattern

## Core Concept

All testing serves three purposes: **Discovery** (how it behaves), **Diagnostic** (what's broken), and **Validation** (meets requirements).

Probe Tests combine all three into a single development loop that mirrors how developers naturally work, running code to verify it works while learning how it behaves.

> **Probe Tests = Smoke + Discovery + Validation in one testing logic**

This is different in nature from E2E or Integration or Unit tests. Probe tests are especilly useful for heavy development and prototyping phase.  

Probe tests are used for
 - Understanding how an extermal framework works, reacts to inputs or produces outputs
 - Creating the first stable intermediate form of the new prototype. 
 - Quick way of interating over design. If codebase is not stable and design has big potential of changing/evolving writing comprehensive test suits are waste of time.  


## Why It Matters

In AI-assisted development, syntactically perfect code can solve the wrong problem. Probe tests reveal misunderstandings immediately through:

1. **✓ Smoke** - Does it run?
2. **🔍 Discovery** - How does it actually behave?
3. **⚠️ Validation** - Are critical requirements met?

This isn't about pass/fail. It's about understanding data flow, transformations, and the gap between design and implementation. 

## Important Distinction

Probe testing complements formal CI/CD frameworks but focuses on the developer experience during active development. It's for running code to inspect and understand, not automated regression testing.


## Benefits in AI Development

- **Fast Feedback** - Three insights from one test
- **Self-Documenting** - Output shows actual behavior
- **Educational** - AI learns from discoveries
- **Safety Net** - Critical validations prevent dangerous bugs


## How to Implement Probe Tests pattern correctly


### 0. Verbose Over Clever


We design Probe tests to generate detailed output that exposes data flow and critical transformations, including both raw data samples and summarized results. These tests serve dual audiences: human developers who need to understand system behavior, and AI assistants that require explicit context to provide accurate assistance.


### 1. Comprehensiveness 


Probe tests must encompass diverse testing scenarios. Traditional software development achieves this through specialized test categories:

  - Unit tests - Test individual functions/methods in isolation
  - Integration tests - Test how components work together
  - End-to-end (E2E) tests - Test complete user workflows
  - Acceptance tests - Verify business requirements are met
  - Performance/Load tests - Test speed and scalability


Within the vibe coding paradigm, we seperate probe tests in order to have semantically holistically probe the project's current status.
 


### 2. Progressive Complexity




Probe tests should follow a progression from simple to complex. Begin with isolated method verification and gradually advance to testing broader conceptual behaviors. Each successive test file should demonstrate deeper system understanding and better debug opportunity for future issues. 

- We test micro → macro (smallest units first, then compositions)
- We stabilize before expanding (happy path → variations → stress, also no point of writing high level tests if low level fails and design will change)
- We respect architectural layers (pure logic → adapters → ports → core)



Testing Coupled Components                                                                                                                       
                                                                                                                                                   
  Not all components can be tested in isolation. Some behaviors only emerge when components work together - you can't meaningfully test an LLM     
  integration without the storage it depends on.                                                                                                   
                                                                                                                                                   
  In these cases, we take a different approach:                                                                                                    
                                                                                                                                                   
  1. Bootstrap a working state across coupled components                                                                                           
  2. Probe and observe how they behave together                                                                                                    
  3. Maintain this working state as an anchor while improving                                                                                      
                                                                                                                                                   
  This is iterative: observe, understand, improve - without breaking what works. The working state becomes both your test baseline and your        
  learning tool.                                                                                                                                   
                                                                                                                                                   
  This is where human judgment becomes essential. Knowing what "working" looks like, deciding what to probe next, recognizing when behavior is     
  correct versus just not crashing - these require understanding that goes beyond pass/fail.     





It is common to have first file as 

test_01_initialization.py
- Can we import the modules?
- Do classes instantiate?
- Are constants defined?

and second file as: 

test_02_connectivity.py
  - Can we connect to the database?
  - Do API endpoints respond?
  - Are external services reachable?
  - Do authentication mechanisms work?
  - Can we read/write to external resources?



### 3. Clear Intent

Probe tests should read like documentation so we can intervene when needed. Test names should be clear and readable, describing exactly what behavior is being verified 


### 4. Full implementation Coverage 


The cost of comprehensive Probe tests is negligible compared to the cost of incorrect implementation. Generate as many tests as necessary to ensure confidence.

A practical guideline: Request AI to create 5 Probe test files, each targeting distinct logical components, with a minimum of 5 individual test cases per file.



```
Probe_tests/
├── test_01_initialization.py
├── test_02_core_functionality.py  
├── test_03_user_workflows.py
├── test_04_edge_cases.py
└── test_05_integration.py
``` 

### 5. No mocking and Providing Real Data 

And you will see that AI-generated tests often default to minimal output or use mocks that obscure real behavior. Which if not checked might have result in Phantom success.  

AI-generated tests frequently default to using mocks or minimal outputs that mask actual system behavior, potentially creating false positives where tests pass despite broken functionality.

It is your job to provide realistic data for Probe tests.When developing complex systems like video processing engines or voice detection algorithms, AI cannot generate realistic data to test the code . Without authentic test data, you risk phantom successes where mocked tests pass while real implementation fails.



### 6. Always Rerun your Probe tests by yourself. 
 
Never rely solely on AI's test execution or interpretation. A critical pitfall occurs when AI reports overall success despite partial failures - even one failing test invalidates the entire suite.

Additionally, manually reviewing Probe test output provides immediate insight into the AI's implementation approach, revealing how it handles data transformations and input/output operations. This direct observation is invaluable for understanding the actual code behavior.






