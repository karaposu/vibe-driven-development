# Smoke Tests Pattern

AI can generate perfectly valid code that solves the wrong problem. Smoke tests reveal this immediately. 

## What Are Smoke Tests?

The term originates from hardware testing - checking if a device literally "smokes" when powered on. In software, smoke tests serve as quick sanity checks, typically used for:
  - Exploring and understanding unfamiliar modules or APIs or algorithms
  - Rapid prototyping when formal Test-Driven Development (TDD) would slow progress

So basically they let you quickly confirm that core functionality works under minimal conditions without the overhead of formal testing frameworks.

## Smoke Tests in Vibe Coding

Smoke Test Pattern provides  
    - Validation that AI understands your intent and you understand AI's intent. 
    - Shows AI indeed did what think it wanted to do
    - Early warning system and prevent propagations of misunderstandings
    - comprehensive summary of your project/module


Smoke tests serve not just to verify pass/fail status, but to expose actual data flow, data transformations and intermediate states and values, allowing AI& developers to understand exactly what's happening during execution. 


## How to Implement Smoke Tests pattern correctly


### 0. Verbose Over Clever


We design smoke tests to generate detailed output that exposes data flow and critical transformations, including both raw data samples and summarized results. These tests serve dual audiences: human developers who need to understand system behavior, and AI assistants that require explicit context to provide accurate assistance.


### 1. Comprehensivity 


Smoke tests must encompass diverse testing scenarios. Traditional software development achieves this through specialized test categories:

  - Unit tests - Test individual functions/methods in isolation
  - Integration tests - Test how components work together
  - End-to-end (E2E) tests - Test complete user workflows
  - Acceptance tests - Verify business requirements are met
  - Performance/Load tests - Test speed and scalability


Within the vibe coding paradigm, these traditional testing approaches are consolidated and adapted into our comprehensive Smoke Tests pattern.



### 2. Progressive Complexity

The smoke tests shold start from isolated method checks and evolve into testing concepts while each file Each file testing deeper understanding 

Smoke tests should follow a progression from simple to complex. Begin with isolated method verification and gradually advance to testing broader conceptual behaviors. Each successive test file should demonstrate deeper system understanding and better debug opportunitity for future issues. 

Example progression: test_login_returns_token → ... → test_basic_auth_flow_works

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

Smoke tests should read like documentation so we can intervene. Also Naming the Tests Clearly and Readble is important 


### 4. Full implementation Coverage 


The cost of comprehensive smoke tests is negligible compared to the cost of incorrect implementation. Generate as many tests as necessary to ensure confidence.

A practical guideline: Request AI to create 5 smoke test files, each targeting distinct logical components, with a minimum of 5 individual test cases per file.



```
smoke_tests/
├── test_01_initialization.py
├── test_02_core_functionality.py  
├── test_03_user_workflows.py
├── test_04_edge_cases.py
└── test_05_integration.py
``` 

### 5. No mocking and Providing Real Data 

And you will see that AI-generated tests often default to minimal output or use mocks that obscure real behavior. Which if not checked might have result in Phantom success.  

AI-generated tests frequently default to using mocks or minimal outputs that mask actual system behavior, potentially creating false positives where tests pass despite broken functionality.

It is your job to provide realistic data for smoke tests.When developing complex systems like video processing engines or voice detection algorithms, AI cannot generate realistic data to test the code . Without authentic test data, you risk phantom successes where mocked tests pass while real implementation fails.



### 6. Always Rerun your smoke tests by yourself. 
 
Never rely solely on AI's test execution or interpretation. A critical pitfall occurs when AI reports overall success despite partial failures - even one failing test invalidates the entire suite.

Additionally, manually reviewing smoke test output provides immediate insight into the AI's implementation approach, revealing how it handles data transformations and input/output operations. This direct observation is invaluable for understanding the actual code behavior.





