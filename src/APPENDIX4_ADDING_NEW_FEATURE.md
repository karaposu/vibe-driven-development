# APPENDIX 4: ADDING NEW FEATURES WITH VDD

This appendix provides ready-to-use prompts for systematically planning and implementing new features using the Vibe-Driven Development methodology. These prompts ensure thorough planning, risk assessment, and safe implementation.

## OVERVIEW

Adding features in VDD follows a structured documentation-first approach that prevents scope creep, identifies risks early, and provides clear implementation paths for AI collaboration.

## PHASE 1: FEATURE DISCOVERY & DOCUMENTATION

In this phase make sure after each step, check the generated documentation and apply fixes 

### Step-1: Seeding the Feature

Start by describing the feature. Based on it's complexity provide extra information. 
End your desc with this:

"Please desc me this feature in better phrasing."


Having AI rephrase the feature back ensures mutual understanding before proceeding. This catches miscommunication early.

Once you read back what AI generated regarding the feature you asked, make sure to fix incorrect things.


###  Step-2: Generating Small Description and Plan

```
Okay now you understand this feature in general, 

Create the initial feature documentation structure in devdocs folder:

1. Create devdocs/features/planned/feat_X_[FEATURE_NAME]/desc.md with:
   - Problem statement (what problem does this solve?)
   - User value proposition (why do users need this?)
   - Success criteria (how do we know it's working?)
   - Scope boundaries (what this feature will NOT do)
   - Priority level (critical/high/medium/low)

2. Create a devdocs/features/planned/feat_X_[FEATURE_NAME]/implementation_plan.md with:
   2.1. High level plan summary in bullet points
   2.2. Full implementation plan 

  ( Keep it lightweight at this stage - we'll add detail as we validate the feature.)
```


###  Step-3: Compatibility check of the Plan (Optional)

```
Now based on the feature implementation plan (reread it, I made changes)

I want you to check and  Identify compatibility ISSUES, RISKS and CONFLICTS with respect to whole codebase's work logic. Check if this implementation plan caueses:
- Existing features that might break
- Performance implications
- API contract changes
- Database schema impacts
- Security considerations
```
   
  

### Step-4: Compatibility Analysis

```
Analyze how [FEATURE NAME] will interact with the existing codebase:

1. Read all relevant module interfaces and implementations
2. Create devdocs/features/planned/feat_X_[FEATURE_NAME]/compatibility_check.md

Document:
- Which existing features might be affected
- Potential conflicts or breaking changes
- Performance implications (latency, memory, storage)
- API contract changes required
- Database schema impacts
- Security considerations
- Required refactoring before implementation

Rate each risk as: Low/Medium/High
Suggest mitigation strategies for Medium/High risks.
```


## PHASE 2: BLUEPRINT PLANNING (Optional)

```
Expand the implementation plan for [FEATURE NAME]:

Update devdocs/features/planned/feat_X_[FEATURE_NAME]/implementation_plan.md

Structure:
1. High-level plan summary (5-10 bullet points)

2. Detailed implementation steps:
   Phase A: Foundation
   - [ ] Step 1: [Specific task]
   - [ ] Step 2: [Specific task]

   Phase B: Core Implementation
   - [ ] Step 3: [Specific task]
   - [ ] Step 4: [Specific task]

   Phase C: Integration
   - [ ] Step 5: [Specific task]
   - [ ] Step 6: [Specific task]

3. For each phase specify:
   - Files to be created/modified
   - New components/modules needed
   - Integration points
   - Testing approach

4. Architecture decisions:
   - Design patterns to use
   - Data flow design
   - Error handling strategy
   - Performance optimization approach

5. Code organization:
   - Where new code will live
   - Module boundaries
   - Interface definitions
```



## PHASE 3: Execution Loop


### Step-5: Executing 

This is where implementation is executed by AI. 

```
Now using all files we created regarding this feature, please start the execution. Be loyal to the files 
```

### Step-6: Test Scenario Planning

Once execution is finished we would like to test it. 


```
Define comprehensive test scenarios for this feature :

Create devdocs/features/planned/feat_X_[FEATURE_NAME]/test_scenarios.md

Document:

1. Feature Trigger Points
   - How can this feature be activated/used?
   - What are all the entry points?
   - User actions that trigger it
   - System events that trigger it

2. Happy Path Scenarios
   - Scenario A: [Description]
     * Input: [Specific data]
     * Expected: [Specific outcome]
   - Scenario B: [Description]
     * Input: [Specific data]
     * Expected: [Specific outcome]

3. Edge Cases
   - Boundary conditions
   - Empty/null inputs
   - Maximum load scenarios
   - Concurrent access cases

4. Error Scenarios
   - Invalid inputs
   - Missing dependencies
   - Network failures
   - Permission issues

5. Integration Tests
   - How it works with Feature X
   - How it works with Feature Y
   - Data flow through the system

6. Acceptance Criteria Checklist
   - [ ] Criterion 1 (how to verify)
   - [ ] Criterion 2 (how to verify)
   - [ ] Criterion 3 (how to verify)

7. Performance Benchmarks
   - Response time targets
   - Throughput requirements
   - Resource usage limits
```


### Step-7: Probe Test Creation

```
Use the created test scenario documentaion and  Let's design comprehensive probe tests to validate our implementation of this feature
 
Please create probe_tests folder if it doesnt exists.


Use feature name as a folder and inside create:

1. 5 test files, each containing 5 focused test cases
2. Avoid mocking and use real componenets with real calls with real data. 
3. File naming convention: test_01_[test_focus_area].py, test_02_[next_focus_area].py, etc.
4. Make sure these tests 
      -  Individual functions/methods in isolation 
      -  Test how feature related components work together
      -  Verify solidly defined requirements are met or not

       
5. For each test file, provide:
  - Clear description of what aspect it tests
  - Why this testing area is critical
  - Brief outline of each test case within the file as a top comments
6. these tests shouldnt use any testing frameworks. Make the outputs verbose enough so you can see what exactly does not work. 
7. Start with initialization test file. 
8. Each test file's most top comment should include how to run it manually. 


(Write the files in such way that each subtest inside is seperate functin and in the end there is one funciton to orchestrate runnning all of them)

(Tests should test what actually exists, do not create fallbacks etc)


```

### Step-8: Stable INtermediate Form (Anchor check)

Run all other probe tests to see this implemention did not break anyhthing. 


## PHASE 4: COMPLETION & DOCUMENTATION

### Step-9: Implementation Notes

```
Document the implementation journey for this feature what was unexpected?
Deviations from original plan? 
Technical obstacles faced and how they were resolved?
Undocumented behaviors found or not?
Integration complexities?
Technical debt created?
What to avoid next time? 

document these in 

devdocs/features/planned/feat_X_[FEATURE_NAME]/implementation_notes.md:

```


### Feature Migration

```
Move this feature to finished status.  Move the feat from planned folder to finished folder
```











