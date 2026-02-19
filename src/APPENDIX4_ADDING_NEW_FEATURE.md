# APPENDIX 4: ADDING NEW FEATURES WITH ALIGNSTACK

This appendix provides ready-to-use prompts for systematically planning and implementing new features using the AlignStack methodology. These prompts ensure thorough planning, risk assessment, and safe implementation.

## OVERVIEW

Adding features in AlignStack follows a structured documentation-first approach that prevents scope creep, identifies risks early, and provides clear implementation paths for AI collaboration.

## PHASE 1: FEATURE DISCOVERY & DOCUMENTATION

In this phase make sure after each step, check the generated documentation and apply fixes 

### Step-1: Seeding the Feature

Start by describing the feature. Based on it's complexity provide extra information. 
End your desc with this:

"Please desc me this feature in better phrasing."


Having AI rephrase the feature back ensures mutual understanding before proceeding. This catches miscommunication early.

Once you read back what AI generated regarding the feature you asked, make sure to fix incorrect things.


###  Step-2: Generating Description of the Feature

```
Okay now you understand this feature in general, 

Create the initial feature documentation structure in devdocs folder:

1. Create devdocs/features/planned/feat_X_[FEATURE_NAME]/desc.md with:
   - Problem statement (what problem does this solve?)
   - User value proposition (why do users need this?)
   - Success criteria (how do we know it's working?)
   - Scope boundaries (what this feature will NOT do)
   - Priority level (critical/high/medium/low)

2. Create a devdocs/features/planned/feat_X_[FEATURE_NAME]/step_by_step_plan.md with:
   2.1. High level plan summary in bullet points
   2.2. Full implementation plan 

  ( Keep it lightweight at this stage - we'll add detail as we validate the feature.)
```

###  Step-3: Generating Step By Step Plan

```
Okay now I want you to ultrathink and reread all codefiles and then generate  

Create a devdocs/features/planned/feat_X_[FEATURE_NAME]/step_by_step_plan.md 

it should start with  High level plan summary in bullet points and then explain the Full implementation plan 
```


###  Step-4: Generating the critic.md 

```
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
2. Create devdocs/features/planned/feat_X_[FEATURE_NAME]/critic.md




```

## PHASE 2: Execution Loop


### Step-5: Executing 

This is where implementation is executed by AI. 

```
Now using step by step implementation we created regarding this feature, reread it fully and then please start the execution. Be loyal to the plan. 
```

### Step-6: Test Scenario Planning

Once execution is finished we would like to test it of course


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

and if these tests exists, run them, if not add them to the test suite, or probe tests and then run them. 


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

Run all other existing tests to see this implemention did not break anyhthing. 


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


# Alternative 

for really complex tasks which requires more granular control during the implementation I use a different approach 

instead of directly creating step by step plan 
we create stage by stage plan and once it is confirmed each stage is seperated in devdocs folder and for eaach stage we create desc.md step_by_step_plan.md and critic.md etc. 











