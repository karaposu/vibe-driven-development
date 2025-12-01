# APPLYING VIBE CODING TO AN EXISTING CODEBASE

This appendix contains ready-to-use prompts for applying Vibe Coding patterns to existing codebases. The archaeology pattern (Chapter 6.7) helps extract DevDocs from mature projects without losing architectural wisdom.

## IMPORTANT NOTES
- Existing code contains hidden reasons - don't simplify without understanding why
- Technical debt often exists for valid historical reasons
- Start documentation before making changes
- Keep old architectural decisions visible to prevent regression

## APPLY THE ARCHAEOLOGY PATTERN

### Phase 1: Filling the Context and Summarizing


"""

This is an ongoing project. It is currently partially working but on heavy development. 
I would like you read all the files and tell me about this project in non technical terms

- Make sure you focus on code files and not existing documentation
- Make sure you read code files fully 


And create devdocs/archaeology/small_summary.md

"""

### Phase 2: Enhancing Generic Technical Understanding 


"""
Now understand how this codebase designed in terms of 

- data flow paths
- main abstractions 
- top level desing patterns 

But talk about these in high level. As if you are introducing the architecture / project to a new engineer. 

put this in devdocs/archaeology/intro2codebase.md

"""

### Phase 3: Deeper look in CodeBase  


"""
Identify every internal interface and submodule-level interaction defined within the codebase (excluding external packages). For each interface, follow its execution path end-to-end: what calls it, what it triggers, how data or state moves through the layers, and what outcomes it produces. 

Document these flows at a high level, explaining what each interaction corresponds to, what it affects, and why it behaves that way.  


Create one file per interaction trace under devdocs/archaeology/traces/ (e.g., trace_1.md, trace_2.md).
Base all analysis strictly on actual code behavior rather than names or assumptions.


Each trace should have the following sections

Entry Point
Execution Path
Resource Management
Error Path
Performance Characteristics
Observable Effects
Why This Design 

What feels incomplete
What feels vulnerable
What feels bad design



"""


### Phase 4: Using Fresh Trace analysis to Identify "Things"


"""

Now look at all traces and what are the 5 things that would improve the codebase a lot?

Put these in devdocs/archaeology/5_things_or_not.md

And make sure after each of them think for a possible reason this thing is not implemented/fixed at the current code
(the reason is there might be some undocumented decisions and these 5 thigns might refer to them  )


"""

### Phase 5:  Concept Inventory


"""

Looking at the codebase, 

Create 

1. devdocs/archaeology/concepts/technical_concepts_list.md  
2. devdocs/archaeology/concepts/design_concepts_list.md 
3. devdocs/archaeology/concepts/busines_lvl_concepts_list.md 


where each concept has high level explanation (max 3 sentence) as well as current implementation status. And make sure the listing starts from most main ones and branches as needed. 

Recognize that the codebase may contain architectural intentions, hidden assumptions, edge-case handling, or future-oriented design considerations that exist only in the code and are not explicitly documented. Surface these implicit concepts clearly among with others explain their possible purpose, rationale, and potential impact on scalability, security, and maintainability. 


and then Identify missing but required/expected concepts and thenput them in 

devdocs/archaeology/concepts/missing_concepts_list.md 




"""



### Phase 5: Codebase inferred Foundation Extraction

```
Now based on solely the codebase analysis and devdocs/archaeology documents, please extract these foundations documents:

1. Create devdocs/archaeology/foundations/project_description.md
   - What the system actually does (not what docs claim)
   - Current user base and use cases
   - Actual problems being solved

2. Create devdocs/archaeaology/foundations/philosophy.md
   - Implicit design principles found in code
   - Coding patterns consistently used
   - Architectural decisions evident in structure

3. Create devdocs/archaeology/foundations/known_requirements.md
   - Requirements inferred from implementations
   - Constraints visible in code
   - Compliance/security measures present
```



## STANDARD ANALYSIS 

### Phase 6: Data Dumb and Foundation Extraction

This is where we start swaying away from the current implementation itself and focus on project itself.
In this stage make sure provide all non code documentations regarding project idea. 


```
Based on the given documentations (not the prior codebase knowledge), please extract these foundations documents:

1. Create devdocs/foundations/project_description.md
   - What the system actually does (not what docs claim)
   - Current user base and use cases
   - Actual problems being solved

2. Create devdocs/foundations/philosophy.md
   - Implicit design principles found in code
   - Coding patterns consistently used
   - Architectural decisions evident in structure

3. Create devdocs/foundations/known_requirements.md
   - Requirements inferred from implementations
   - Constraints visible in code
   - Compliance/security measures present
```





### Phase 4: Architecture Archaeology

```
Reconstruct the architecture from code:

1. Create devdocs/archaeology/architecture_analysis.md:
   - Trace main entry points and flows
   - Map data models and schemas
   - Document API endpoints and contracts
   - Identify architectural patterns used

2. Create devdocs/archaeology/module_discovery.md:
   - Natural module boundaries in code
   - Coupling and cohesion analysis
   - Dependency relationships
   - Shared utilities and libraries
```


### Phase 5: Concept Mapping

```
Map discovered concepts to actual implementation:

Create devdocs/archaeology/concept_mappings.md documenting:
- Which files/modules implement each concept
- Coverage percentage (fully realized, partial, missing)
- Why implementation diverged from ideal
- What alternatives were likely considered
- Edge cases that shaped the current design

This captures the "why" behind existing architecture.
```

### Phase 7: State Assessment

```
Synthesize findings into current state assessment:

Create devdocs/archaeology/project_state.md:
- Overall architecture maturity level
- Technical debt impact assessment
- Missing concept implementations
- Integration points needing attention
- Risk areas for future development
- Recommended refactoring priorities
```

## TOWARDS FIRST AI IMPLEMENTATION 

### Phase 8: Gap Analysis

```
Compare current state to desired future state:

Create devdocs/evolution/gap_analysis.md:
1. What concepts need implementation
2. What architecture changes are required
3. What technical debt blocks progress
4. What can be incrementally improved
5. What requires complete rewrite
```

### Phase 9: Gap Closure Strategy

```
Using gap_analysis.md create phased evolution plan:

Create devdocs/evolution/gap_closure_plan.md:
1. Quick wins (can do immediately)
2. Incremental improvements (module by module)
3. Major refactoring (requires planning) 
4. Complete rewrites (if necessary)

For each phase:
- Dependencies and prerequisites
- Risk assessment
- Testing strategy
```


### Phase 10: Baseline Smoke Tests

```
Establish working baseline with smoke tests. See what is running and what is not running.
Your job is to create smoke_tests/check_what_is_working/
and under this folder create smoke test files for each implementation that seems to be working. 

Let's design comprehensive smoke tests to validate the implementation.
Please create smoke_tests folder if it doesn't exist and create a test plan with the following structure:

1. 5 test files, each containing 5 focused test cases
2. Avoid mocking and use real components with real calls with real data
3. File naming convention: test_01_[test_focus_area].py, test_02_[next_focus_area].py, etc.
4. Make sure these tests:
   - Individual functions/methods in isolation
   - Test how components work together
   - Verify solidly defined requirements are met or not

5. For each test file, provide:
   - Clear description of what aspect it tests
   - Why this testing area is critical
   - Brief outline of each test case within the file

6. These tests shouldn't use any testing frameworks. Make the outputs verbose enough so you can see what exactly does not work
7. Start with initialization test file
8. Each test file's top comment should include how to run it manually 

Make sure not mock things and try to run them with minimal changes. Make sure you cover all codebase.
Document current behavior in smoke_tests/check_what_is_working/report.md:
- What works as expected
- What's broken but acceptable

```



### Phase 11: Codebase Cleanup Inventory

```
Identify unused code and organize for safe removal:

1. Scan for unused elements:
   - Unreferenced files and modules
   - Dead code paths (unreachable functions)
   - Commented-out code blocks
   - Duplicate implementations
   - Abandoned features
   - Test files for non-existent code
   - Orphaned configuration files

2. Create devdocs/archaeology/cleanup_inventory.md:
   - List all candidates for removal
   - Note why each appears unused
   - Mark any that might be used dynamically
   - Identify potential hidden dependencies

Never delete immediately - code that looks unused might be:
- Loaded dynamically
- Referenced in configuration
- Used by external systems
- Kept for compliance/audit reasons
```



### Phase 12: Strategic Refactoring Opportunities

  Identify high-value refactoring opportunities that will significantly improve the codebase:

  1. Scan for refactoring candidates:
     - Database operations scattered across codebase → Repository Pattern
     - Business logic mixed with infrastructure → Service Pattern
     - Repeated API call patterns → Gateway/Client abstraction
     - Global state management → Dependency Injection
     - Hard-coded configurations → Configuration Pattern
     - Complex conditionals → Strategy Pattern
     - Direct file system access → Storage abstraction

  2. Create devdocs/evolution/refactoring_opportunities.md:
     For each opportunity document:
     - Current problematic pattern (with file locations)
     - Proposed abstraction/pattern
     - Immediate benefits (testability, maintainability)
     - Implementation effort estimate
     - Risk assessment
     - ROI justification

  3. Prioritize by value/effort ratio:
     - Critical: Blocks testing or development
     - High: Significant maintenance reduction
     - Medium: Nice to have, clear benefits
     - Low: Cosmetic, can wait

  Focus only on refactoring that:
  - Enables better testing
  - Reduces coupling between modules
  - Makes AI-driven development easier
  - Solves actual pain points

  Avoid refactoring for its own sake - each change must deliver measurable value.


  ### Phase 13: Implementation Roadmap

  Create comprehensive roadmap combining all improvement activities:

  Create devdocs/evolution/implementation_roadmap.md organizing work into phases:

  Phase A - Foundation (Week 1-2):
  1. Critical cleanup from cleanup_inventory.md
  2. Essential refactoring that unblocks other work
  3. Fix broken core functionality from smoke test report
  4. Establish CI/CD if missing

  Phase B - Core Refactoring (Week 3-4):
  1. Implement highest-ROI refactoring from refactoring_opportunities.md
  2. Add abstraction layers (Repository, Service patterns)
  3. Decouple tightly coupled modules
  4. Run smoke tests after each refactor

  Phase C - Gap Filling (Week 5-8):
  1. Implement missing concepts from gap_analysis.md
  2. Start with quick wins
  3. Progress to module-by-module improvements
  4. Add new features identified in gaps

  Phase D - Integration & Polish (Week 9-10):
  1. Ensure all modules work together
  2. Performance optimization
  3. Documentation updates
  4. Comprehensive testing

  For each item include:
  - Specific files/modules affected
  - Dependencies (what must be done first)
  - Success criteria
  - Time estimate
  - Risk level

  This roadmap becomes your execution guide for transforming the codebase systematically.
```

