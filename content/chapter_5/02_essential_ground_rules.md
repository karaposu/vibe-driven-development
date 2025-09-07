# Essential Ground Rules

## Why Ground Rules Matter

AI has it's own preferences regarding how development should be made,tech stack, design, platform. And also AI has no implicit understanding of your preferences.  This is something prevents vibing and causes frictions during development. 

This is why we establish some ground rules right after each new AI session. 
First type is generic ground rules
the second type is preferences, 


I will explain them with my own use cases and examples. 


## The generic Ground Rules

### 1. No Mocks Without Necessity

```
"Avoid mocks/stubs unless absolutely necessary for external dependencies"
```

Why: AI loves mocking everything. Tests become meaningless. Real implementations reveal real problems.

Exception: External APIs, databases in unit tests.

### 2. File Path Comments at top

```
"For each file you generate, put the relative path as a comment at near the top"
```

Example:
```python
# src/services/auth.py
```

Why: 
- Navigation clarity
- Context preservation
- Refactoring tracking

### 3. Skip Legacy Compatibility

```
"During active development, skip legacy compatibility concerns"
```

Why: AI adds backwards compatibility everywhere. IE11 support. Python 2.7 compatibility. Complexity explodes.

Add compatibility later if needed.

### 4. Git Discipline

```
"If git is initialized, commit changes with proper messages at suitable times"
```

Why: AI can maintain project history. Commits become documentation. Rollback points everywhere.

Format: Conventional commits (feat:, fix:, docs:)



## Example Prompt

Create `ground_rules.md` in your project and add the below prompt along with your other preferences

```markdown
# Project Ground Rules

## Universal Rules
1. No mocks unless necessary for external dependencies
2. Include filepath comment at top of each file
3. Skip legacy compatibility during development
4. Commit progress with conventional messages
5. Development should be done in modules and isolated logic. 
6. Variable names shouldnt be ambigious 



```markdown

Dont forget to tell AI to read it and follow it in every new session

```
"Please read ground_rules.md and follow these rules for all code generation"
```


## Project-Specific Rules

### For Web Projects

```
Additional rules for web development:
- Use semantic HTML5 elements
- Mobile-first responsive design
- Accessibility from the start (ARIA labels, keyboard nav)
- No inline styles unless absolutely necessary
```

### For API Projects

```
Additional rules for APIs:
- RESTful conventions unless specified otherwise
- Comprehensive error responses
- Input validation on all endpoints
- OpenAPI/Swagger documentation
```

### For Data Projects

```
Additional rules for data processing:
- Explicit schema definitions
- Data validation before processing
- Reproducible transformations
- Clear separation of ETL stages
```

## Language-Specific Rules

### Python Projects

```
Python-specific ground rules:
- Type hints for all functions
- Docstrings for public methods
- Follow PEP 8 strictly
- Use pathlib for file operations
```

### JavaScript/TypeScript

```
JS/TS ground rules:
- Prefer const over let
- No var declarations  
- Async/await over callbacks
- Strict TypeScript settings
```


### Update When Needed
Rules evolve. When you find yourself correcting AI repeatedly, add a rule.

## The Compound Effect

Good ground rules:
- Save time explaining preferences
- Prevent common AI mistakes
- Maintain consistency across sessions
- Reduce refactoring needs

