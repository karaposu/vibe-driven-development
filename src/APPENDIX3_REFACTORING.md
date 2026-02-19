# APPENDIX 3: REFACTORING WITH ALIGNSTACK

Best quote regarding refactoring the code is:

> "Refactoring is like brushing your teeth. You should do it daily not monthly."

Sometimes requirements change and we might need bigger refactors, but most of the time refactors are something code begs to have, almost as if code is pregnant to a new abstraction or new design pattern.

## THE ALIGNSTACK REFACTORING PHILOSOPHY

In AlignStack, refactoring isn't about making code "clean" according to some abstract ideal. It's about recognizing when code is telling you it wants to evolve, and guiding that evolution with AI assistance while maintaining system stability.

## RECOGNIZING REFACTORING OPPORTUNITIES

### Signs Code is Ready to Evolve

```
Look at the codebase and identify these patterns:

1. Repeated code blocks with slight variations
   → Wants to become: Abstracted function/class

2. Long parameter lists being passed around
   → Wants to become: Configuration object or context

3. Multiple if/else checking the same condition
   → Wants to become: Strategy pattern or polymorphism

4. Data and functions always traveling together
   → Wants to become: Class or module

5. Comments explaining what code does (not why)
   → Wants to become: Self-documenting code

6. Test setup code duplicated across files
   → Wants to become: Test utilities or fixtures

Document findings in devdocs/refactoring/opportunities.md
```

## PHASE 1: REFACTORING DISCOVERY

### Identifying Natural Abstractions

```
Analyze the codebase for emerging patterns:

1. Find all instances where similar code appears 3+ times
2. Identify data structures that always appear together
3. Look for functions that always call each other in sequence
4. Find switch statements or if/else chains on the same variable

Create devdocs/refactoring/emerging_patterns.md documenting:
- Pattern name
- Current locations (file:line)
- Proposed abstraction
- Estimated impact (files affected)
- Risk level (low/medium/high)
```

### Code Smell Detection

```
Scan for these specific code smells:

Technical Debt Smells:
- God functions (>50 lines)
- Deep nesting (>3 levels)
- Magic numbers without constants
- Dead code (unreachable/unused)
- Circular dependencies

Architectural Smells:
- Business logic in UI/controllers
- Data access scattered everywhere
- No clear module boundaries
- Inconsistent error handling
- Mixed abstraction levels

Document in devdocs/refactoring/code_smells.md with:
- Smell type and severity
- Specific locations
- Suggested remedy
- Priority for fixing
```

## PHASE 2: SAFE REFACTORING PLANNING

### Creating Refactoring Anchor Points

```
Before refactoring, establish safety nets:

1. Create probe tests for current behavior:
   - Capture existing functionality
   - Document edge cases
   - Record performance baselines

2. Generate comprehensive tests:
   Create probe_tests/pre_refactor/
   - test_current_behavior.py
   - test_edge_cases.py
   - test_integration_points.py

3. Document current architecture:
   Create devdocs/refactoring/current_state.md
   - How it works now
   - Why it works this way
   - Known limitations

These anchor points ensure refactoring doesn't break existing functionality.
```

### Incremental Refactoring Plan

```
Create a step-by-step refactoring plan:

devdocs/refactoring/refactor_plan.md:

Phase 1: Preparation
□ Add tests for current behavior
□ Create feature flags for gradual rollout
□ Set up parallel implementations

Phase 2: Extract (Don't Change)
□ Extract methods without changing logic
□ Create new files/modules
□ Keep old code working

Phase 3: Abstract (Don't Break)
□ Introduce abstractions
□ Route through new code paths
□ Maintain backward compatibility

Phase 4: Migrate (Gradual Switch)
□ Switch features one by one
□ Monitor for issues
□ Keep rollback ready

Phase 5: Cleanup (Remove Old)
□ Delete old implementations
□ Remove feature flags
□ Update documentation
```

## PHASE 3: REFACTORING EXECUTION

### Extract Method Refactoring

```
For long functions, extract logical chunks:

1. Identify a cohesive block of code (5-15 lines)
2. Check what variables it needs (parameters)
3. Check what it produces (return values)
4. Extract to new method with descriptive name

Apply this extraction:
- Original: [file:lines]
- Extract lines [X-Y] to method [method_name]
- Parameters needed: [list]
- Returns: [type]

After extraction:
- Run tests to verify behavior unchanged
- Commit with message: "Extract [method_name] from [original_function]"
```

### Introduce Abstraction Refactoring

```
When you find repeated patterns:

1. Identify the common structure
2. Find what varies between instances
3. Create abstraction that captures commonality
4. Make variations into parameters/strategies

Create new abstraction:
File: [new_file_path]
Class/Interface: [name]
Common behavior: [what stays same]
Variable behavior: [what changes]
Implementation strategy: [how to handle variations]

Refactor each instance to use new abstraction
Test after each instance is refactored
```

### Data Structure Consolidation

```
When data always travels together:

Identify coupled data:
- Fields: [field1, field2, field3]
- Always appear in functions: [func1, func2]
- Current locations: [scattered across X files]

Create consolidated structure:
- New class/type: [StructureName]
- Properties: [organized fields]
- Methods: [related operations]
- File location: [where it lives]

Migration approach:
1. Create new structure alongside old
2. Update one function at a time
3. Run tests after each update
4. Remove old scattered fields
```

## PHASE 4: ARCHITECTURAL REFACTORING

### Repository Pattern Introduction

```
When database access is scattered:

Current state analysis:
- Find all database queries in codebase
- Group by entity type (User, Order, Product)
- Identify common query patterns

Create repository structure:
repositories/
├── base_repository.py      # Common CRUD operations
├── user_repository.py       # User-specific queries
├── order_repository.py      # Order-specific queries
└── product_repository.py    # Product-specific queries

Migration steps:
1. Create repository with existing queries (copy, don't move)
2. Update one module to use repository
3. Test thoroughly
4. Repeat for each module
5. Remove direct database access
```

### Service Layer Extraction

```
When business logic is mixed with infrastructure:

Identify business logic:
- Find code that implements business rules
- Separate from HTTP handling, database access
- Group related business operations

Create service layer:
services/
├── user_service.py         # User business logic
├── order_service.py        # Order processing
├── payment_service.py      # Payment rules
└── notification_service.py # Notification logic

Refactoring approach:
1. Extract business logic to service methods
2. Keep controllers thin (just HTTP handling)
3. Services call repositories (not direct DB)
4. Test services independently
```

### Dependency Injection Implementation

```
When testing is hard due to tight coupling:

Identify hard dependencies:
- Direct instantiation in constructors
- Global imports used directly
- Hard-coded configuration values

Introduce dependency injection:

# Before:
class OrderService:
    def __init__(self):
        self.db = Database()  # Hard dependency
        self.email = EmailSender()  # Hard dependency

# After:
class OrderService:
    def __init__(self, db, email_sender):
        self.db = db  # Injected
        self.email = email_sender  # Injected

Create dependency container:
- Central place for wiring
- Configuration-driven
- Easy to swap implementations
```

## PHASE 5: REFACTORING VALIDATION

### Performance Comparison

```
Compare before/after performance:

Create performance tests:
1. Measure current performance
   - Response times
   - Memory usage
   - Database queries

2. Run same tests after refactoring
   - Should be same or better
   - Document any degradation
   - Optimize if needed

Document in devdocs/refactoring/performance_impact.md:
- Metrics before/after
- Explanation of changes
- Optimization opportunities
```

### Behavior Verification

```
Ensure refactoring didn't change behavior:

1. Run all existing tests
   - Should pass without changes
   - If test needs updating, document why

2. Run probe tests
   - Compare output before/after
   - Check edge cases still work
   - Verify error handling unchanged

3. Manual testing checklist
   - Critical user paths
   - Integration points
   - Error scenarios

Document any behavior changes (there shouldn't be any!)
```

## PHASE 6: CONTINUOUS REFACTORING

### Daily Refactoring Habits

```
Make these part of your daily workflow:

When adding new code:
□ Extract if function > 30 lines
□ Name magic numbers as constants
□ Group related parameters into objects
□ Add types/interfaces where missing

When modifying existing code:
□ Leave it better than you found it
□ Extract repeated code you encounter
□ Improve names for clarity
□ Add missing tests

When reviewing code:
□ Identify emerging patterns
□ Note refactoring opportunities
□ Create tickets for larger refactors
```

### Refactoring During Feature Development

```
Integrate refactoring into feature work:

Before starting feature:
1. Refactor the area you'll be working in
2. Clean up technical debt that would slow you down
3. Add tests for code you'll modify

During feature development:
1. Extract new abstractions as they emerge
2. Don't copy-paste, extract shared code
3. Keep consistent patterns

After feature completion:
1. Refactor based on new understanding
2. Consolidate similar code introduced
3. Update module documentation
```

## COMMON REFACTORING PATTERNS WITH AI

### Pattern 1: Extract and Generalize

```
When you have similar code with variations:

Prompt: "I have these 3 similar functions [paste code].
Extract the common logic into a base function and handle
variations through parameters or callbacks."

AI will:
- Identify commonality
- Create generalized version
- Show how to use for each case
```

### Pattern 2: Simplify Conditional Logic

```
When you have complex nested conditions:

Prompt: "Simplify this complex conditional logic [paste code].
Use early returns, extract methods, or strategy pattern as appropriate."

AI will:
- Flatten nested conditions
- Extract boolean methods
- Suggest clearer structure
```

### Pattern 3: Introduce Design Pattern

```
When code is begging for a pattern:

Prompt: "This code [paste code] seems to need a design pattern.
Identify which pattern would help and refactor to use it."

AI will:
- Recognize applicable patterns
- Implement the pattern
- Show migration path
```

## REFACTORING SAFETY RULES

### The Golden Rules

1. **One Thing at a Time** - Never refactor multiple things simultaneously
2. **Test Continuously** - Run tests after every small change
3. **Commit Frequently** - Each successful refactor gets its own commit
4. **Keep It Working** - Code should work at every step
5. **Document Why** - Commit messages explain the refactoring reason

### When NOT to Refactor

- **Before a deadline** - Refactoring can wait
- **Without tests** - Add tests first
- **During debugging** - Fix the bug first
- **Unfamiliar code** - Understand it first
- **If it's working** - Don't fix what ain't broken (unless it's blocking progress)

## REFACTORING CHECKLIST

Before starting any refactoring:
- [ ] Current behavior is tested
- [ ] Performance baseline captured
- [ ] Rollback plan exists
- [ ] Team is informed

During refactoring:
- [ ] One change at a time
- [ ] Tests pass after each change
- [ ] Commits are atomic
- [ ] Code always compiles

After refactoring:
- [ ] All tests still pass
- [ ] Performance unchanged or better
- [ ] Documentation updated
- [ ] Team code review completed
- [ ] Old code removed

## TIPS FOR AI-ASSISTED REFACTORING

1. **Show Context** - Give AI the full picture, not just the code to refactor
2. **Specify Constraints** - Tell AI what must not change
3. **Request Steps** - Ask for incremental refactoring steps
4. **Verify Understanding** - Have AI explain the refactoring before doing it
5. **Test Generation** - Ask AI to create tests before and after

Remember: Refactoring is about making code better without changing what it does. It's evolution, not revolution. The best refactoring is invisible to users but obvious to developers.