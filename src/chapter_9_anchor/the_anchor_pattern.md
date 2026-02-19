# The Anchor Pattern

## What Is the Anchor Pattern?

In scientific literature this is known as "Stable Intermediate Forms" which is a methodology to help de-risking the process of change (also known as strangler fig pattern)

The Anchor Pattern is about ensuring that new development doesn't break existing functionality. As AI works on new features, it tends to forget earlier requirements due to limited context. Anchoring actions force AI to regularly verify that old logic still works.


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
1. Run existing probe tests
2. Run existing test suite (E2E,Integration, Unit etc)
2. Verify core functionality still works
3. Check that new code doesn't violate established patterns
4. Ensure integration points remain intact

And if vibe tests pattern is used correctly then anchoring your development is simple as running such prompt:

```
"We've implemented the new feature. Now let's run our tests 
to ensure all existing functionality still works correctly. If something is broken we will fix it later. Once tests are  finished generate me a devdocs/what_is_broken.md"
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

## The Meta-Anchor

The ultimate anchor is asking:
```
"What existing functionality could this change break? 
Let's add extra tests for those specific areas."
```

This makes AI think about impact before problems occur.

## Anchor Best Practices

1. **Run Anchors Frequently**: Not just at the end
2. **Fix Immediately**: Don't let anchors stay red
3. **Add New Anchors**: When you find bugs
4. **Remove Obsolete Anchors**: When features are removed
5. **Document Anchor Purpose**: Why does this test exist?

Anchoring isn't about perfection - it's about detection. You will break things. Anchors ensure you know immediately, not days later.
