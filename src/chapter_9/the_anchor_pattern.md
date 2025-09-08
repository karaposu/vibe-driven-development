# The Anchor Pattern

## What Is the Anchor Pattern?

The Anchor Pattern is about ensuring that new development doesn't break existing functionality. As AI works on new features, it tends to forget earlier requirements due to limited context. Anchors force AI to regularly verify that old logic still works.

Think of it like construction - you don't just check if the new floor is level, you verify the foundation hasn't shifted.

## Why Anchoring Is Critical

AI's context window is limited. When you spend time focusing on feature B, C, and D, the AI gradually loses sight of feature A's requirements. Without anchors, you get:

```
Hour 1: "Build user authentication with email/password"
AI: ✓ Implements perfect auth system

Hour 2: "Add password reset"
AI: ✓ Adds password reset

Hour 3: "Add social login"
AI: ✓ Adds OAuth... but breaks email login

Hour 4: "Add 2FA"
AI: ✓ Adds 2FA... but breaks password reset
```

Each new feature works, but previous features break silently.

## The Core Anchor Mechanism

Anchoring means regularly forcing AI to:
1. Run existing smoke tests
2. Verify core functionality still works
3. Check that new code doesn't violate established patterns
4. Ensure integration points remain intact

```
"I've implemented the new feature. Now let's run our smoke tests 
to ensure all existing functionality still works correctly."
```

## Types of Anchors

### 1. Test Anchors

Your smoke tests are your primary anchors:

```python
# smoke_tests/test_core_functionality.py

def test_original_auth_flow():
    """ANCHOR: Original auth must always work"""
    user = create_user("test@example.com", "password")
    token = login(user.email, "password")
    assert token is not None
    assert validate_token(token)

def test_data_persistence():
    """ANCHOR: Data must persist between sessions"""
    data = create_test_data()
    save_data(data)
    app_restart()
    loaded = load_data()
    assert loaded == data
```

After each change:
```
"Run all tests in smoke_tests/ to verify nothing broke"
```

### 2. Integration Anchors

Ensure modules still work together:

```python
# smoke_tests/test_integrations.py

def test_auth_integrates_with_data_layer():
    """ANCHOR: Auth must work with our data layer"""
    # Login
    token = login("user@example.com", "password")
    
    # Use token to access data
    data = get_user_data(token)
    assert data is not None
    
    # Ensure permissions work
    other_data = get_other_user_data(token)
    assert other_data is None  # Should fail
```

### 3. Behavior Anchors

Document and test expected behaviors:

```markdown
# CORE_BEHAVIORS.md

## Anchored Behaviors (Must Always Work)

1. **Offline First**
   - Test: Disable network, all features work
   - Command: `npm run test:offline`

2. **Data Privacy**
   - Test: Monitor network, no external calls
   - Command: `npm run test:privacy`

3. **Performance**
   - Test: All operations < 100ms
   - Command: `npm run test:performance`

Run these after EVERY feature addition.
```

### 4. API Contract Anchors

Ensure interfaces don't change:

```typescript
// anchors/api-contracts.ts

export interface UserService {
  // ANCHOR: This interface is used by 5 other modules
  // Changes here will break: auth, profile, settings, admin, reports
  getUser(id: string): Promise<User>
  updateUser(id: string, data: UpdateUserDto): Promise<User>
  deleteUser(id: string): Promise<void>
}

// Test that verifies contract
test('UserService contract unchanged', () => {
  const service = new UserServiceImpl()
  expect(service.getUser).toBeDefined()
  expect(service.updateUser).toBeDefined()
  expect(service.deleteUser).toBeDefined()
})
```

## The Anchoring Workflow

### 1. Before Starting New Feature

```
"Before we add [new feature], let's run all smoke tests 
to establish our baseline. Everything should be green."
```

### 2. During Development

```
"I've added the OAuth integration. Let's run the auth smoke tests 
to ensure email/password login still works."
```

### 3. After Completion

```
"Feature complete. Run ALL smoke tests to verify:
1. New feature works
2. Old features still work  
3. No integration issues"
```

### 4. When Tests Fail

```
"The user profile test is failing after our changes. 
Let's check what we modified that could affect profile loading."
```

## Anchoring with DevDocs Pattern

DevDocs serve as persistent memory that AI can reference:

```
"Before implementing social login, please review:
- devdocs/modules/auth/requirements.md
- devdocs/modules/auth/existing_flows.md
- devdocs/simplified_concepts.md section on authentication

Ensure the new feature doesn't break existing requirements."
```

DevDocs anchoring example:
```markdown
# devdocs/modules/auth/integration_points.md

## Critical Integration Points (MUST MAINTAIN)

### 1. Session Management
- Sessions stored in `sessionStore`
- Format: `{ userId, token, expires }`
- Used by: ProfileModule, SettingsModule, AdminModule

### 2. Token Validation  
- Endpoint: `POST /api/auth/validate`
- Returns: `{ valid: boolean, user?: User }`
- Called by: Every protected route

### 3. Permission Checks
- Function: `hasPermission(user, resource, action)`
- Used by: All CRUD operations
- Must return boolean

BREAKING THESE WILL CASCADE FAILURES
```

## Advanced Anchoring Techniques

### The Regression Test Anchor

Create tests specifically for past bugs:

```python
# anchors/regression_tests.py

def test_issue_42_login_after_logout():
    """
    ANCHOR: Issue #42 - Users couldn't login after logout
    This was fixed in commit abc123. Ensure it stays fixed.
    """
    login("user@example.com", "password")
    logout()
    # This used to fail
    token = login("user@example.com", "password")
    assert token is not None
```

### The Performance Anchor

Track performance over time:

```python
# anchors/performance_anchors.py

def test_performance_benchmarks():
    """ANCHOR: Performance must not degrade"""
    benchmarks = {
        'login': 100,  # ms
        'data_load': 200,
        'search': 150,
        'export': 500
    }
    
    for operation, max_time in benchmarks.items():
        start = time.time()
        run_operation(operation)
        duration = (time.time() - start) * 1000
        
        assert duration < max_time, \
            f"{operation} took {duration}ms, max is {max_time}ms"
```

### The State Anchor

Ensure application state remains consistent:

```javascript
// anchors/state_anchor.js

function verifyStateConsistency() {
  // ANCHOR: State shape must remain consistent
  const state = store.getState()
  
  // These paths must always exist
  assert(state.user !== undefined, 'user state missing')
  assert(state.settings !== undefined, 'settings state missing')
  assert(state.data !== undefined, 'data state missing')
  
  // These types must be preserved
  assert(Array.isArray(state.data.items), 'items must be array')
  assert(typeof state.user.id === 'string', 'user.id must be string')
}
```

## Creating Effective Anchors

### 1. Make Them Automated
```bash
# run_anchors.sh
#!/bin/bash
echo "Running anchor checks..."
npm run test:smoke
npm run test:integration  
npm run test:performance
npm run test:contracts
echo "All anchors holding!"
```

### 2. Make Them Specific
```python
# Bad anchor - too vague
def test_auth_works():
    assert auth() is not None

# Good anchor - specific scenario
def test_email_login_with_remember_me():
    """ANCHOR: Email login with remember-me must persist session"""
    token = login("user@example.com", "password", remember_me=True)
    assert token is not None
    assert get_session_expiry(token) == 30 * 24 * 60 * 60  # 30 days
```

### 3. Make Them Visible

Create an anchor dashboard:
```markdown
# ANCHOR_STATUS.md

## Core Functionality Anchors
- ✅ Authentication Flow
- ✅ Data Persistence  
- ✅ Offline Mode
- ❌ Export Feature (failing after commit def456)
- ✅ Permission System

Last Run: 2024-03-15 10:30 AM
Next Required: Before any merge
```

## When to Anchor

### Always Anchor After:
- Adding new features
- Refactoring existing code
- Updating dependencies
- Changing data structures
- Modifying API contracts

### The Anchor Reminder
Add to your AI prompts:
```
"After implementing this change, remind me to run anchor tests"
```

Or better, make AI do it automatically:
```
"Implement this feature, then run all smoke tests to ensure 
existing functionality remains intact"
```

## Signs You Need More Anchors

1. **Silent Breakage**: Features break without notice
2. **Integration Issues**: Modules stop working together
3. **Performance Degradation**: App gets slower over time
4. **State Corruption**: Data structures change unexpectedly
5. **API Drift**: Contracts change without updates

## The Cost of Not Anchoring

Real scenario without anchors:
```
Day 1: Basic CRUD works perfectly
Day 5: Added search, CRUD still works
Day 10: Added filters, search broke
Day 15: Fixed search, CRUD now broken
Day 20: Everything "works" but nothing integrates
Day 25: Complete rewrite needed
```

With anchors:
```
Day 1: Basic CRUD + anchor tests
Day 5: Add search, anchors catch CRUD issue immediately
Day 5.5: Fix issue, all anchors green
Day 10: Add filters, anchors pass
Day 20: Complex app, everything still works
```

## The Meta-Anchor

The ultimate anchor is asking:
```
"What existing functionality could this change break? 
Let's test those specific areas."
```

This makes AI think about impact before problems occur.

## Anchor Best Practices

1. **Run Anchors Frequently**: Not just at the end
2. **Fix Immediately**: Don't let anchors stay red
3. **Add New Anchors**: When you find bugs
4. **Remove Obsolete Anchors**: When features are removed
5. **Document Anchor Purpose**: Why does this test exist?

Anchoring isn't about perfection - it's about detection. You will break things. Anchors ensure you know immediately, not days later.

Remember: In vibe coding, AI is powerful but forgetful. Anchors are your safety net.

Next: Offload Pattern →