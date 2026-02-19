# Essential Ground Rules

## The Friction Problem

AI brings its own biases to every project - preferred frameworks, design patterns, coding styles. Without explicit guidance, AI defaults to what it "thinks" is best, not what your project needs.

This creates friction. You spend more time correcting AI's assumptions than building features.

Ground rules eliminate this friction by establishing clear expectations upfront.

## Two Types of Rules

**Universal Rules**: Apply to every project, every time
**Project Preferences**: Specific to your tech stack, team, or domain

Both should be defined at the start of each AI session.

## Universal Ground Rules

### 1. No Unnecessary Mocking

```
"Only mock external dependencies (APIs, databases). Use real implementations for everything else."
```

**Why it matters:**
- AI tends to mock everything, making tests meaningless
- Real implementations reveal real bugs
- Integration issues surface immediately, not in production

**Valid exceptions:**
- Third-party API calls
- Database connections in unit tests
- Time-dependent operations

### 2. Filepath Documentation

```
"Start every file with a comment showing its path relative to project root"
```

**Example:**
```python
# src/services/auth_service.py

from typing import Optional
import jwt
```

**Benefits:**
- Clear navigation in large codebases
- Context preserved across AI sessions
- Easier refactoring and file moves

### 3. Modern Stack Only

```
"Target modern environments only. No legacy browser support or deprecated language features."
```

**Why this rule exists:**
- AI adds unnecessary compatibility layers
- Legacy support triples complexity
- Modern features improve developer experience

**Add compatibility only when explicitly needed.**

### 4. Meaningful Commits

```
"Make atomic commits with descriptive messages following conventional format (feat:/fix:/docs:)"
```

**Good commit examples:**
```
feat: add user authentication flow
fix: resolve race condition in data fetcher
docs: update API endpoint documentation
```

**Benefits:**
- Git history becomes documentation
- Easy rollbacks and bisecting
- Clear progression tracking

### 5. Modular Development

```
"Build features as isolated modules with clear interfaces"
```

**Structure example:**
```
feature/
├── index.ts        # Public interface
├── types.ts        # Type definitions
├── logic.ts        # Core business logic
├── tests.ts        # Feature tests
└── README.md       # Feature documentation
```

### 6. Explicit Naming

```
"Use descriptive variable and function names. Clarity over brevity."
```

**Examples:**
```javascript
// Bad
const d = new Date();
const u = users.filter(x => x.a > 18);

// Good
const currentDate = new Date();
const adultUsers = users.filter(user => user.age > 18);
```

## Setting Up Ground Rules

Create a `GROUND_RULES.md` file in your project root:

```markdown
# Project Ground Rules

## Universal Rules
1. Only mock external dependencies
2. Include filepath comment at top of each file
3. Target modern environments only (Node 18+, ES2022+)
4. Commit atomically with conventional messages
5. Build features as isolated modules
6. Use explicit, descriptive naming

## Project Preferences
- Framework: [Your choice]
- Testing: [Your approach]
- State Management: [Your pattern]
- Error Handling: [Your strategy]

## Code Style
- Max line length: 100 characters
- Indent: 2 spaces
- Quotes: Single for strings
- Semicolons: [Yes/No]

## AI Instructions
Read and follow these rules for all code generation.
Ask for clarification if rules conflict with requirements.
```

## Starting Each Session

Begin every AI conversation with:

```
"Please read GROUND_RULES.md and apply these consistently throughout our session"
```

## Domain-Specific Rules

### Web Applications

```markdown
## Web Development Rules
- Semantic HTML5 elements required
- Mobile-first responsive design
- WCAG 2.1 AA accessibility minimum
- CSS modules or styled-components (no inline styles)
- Lazy load images and components
- SEO meta tags on all pages
```

### APIs and Services

```markdown
## API Development Rules
- RESTful conventions unless GraphQL specified
- Consistent error response format
- Input validation on all endpoints
- Rate limiting from day one
- OpenAPI documentation required
- CORS configuration explicit
```

### Data Processing

```markdown
## Data Pipeline Rules
- Schema validation before processing
- Idempotent operations
- Clear ETL stage separation
- Audit logging for all transformations
- Error recovery strategies defined
- Sample data for all pipelines
```

## Language-Specific Rules

### Python

```markdown
## Python Standards
- Python 3.10+ features allowed
- Type hints required for all functions
- Docstrings for public APIs
- Black formatting (line length 100)
- pytest for testing
- Poetry for dependency management
```

## Evolution Strategy

Ground rules aren't static. Track patterns:

**When you correct AI repeatedly** → Add a rule
**When rules cause friction** → Refine or remove
**When context changes** → Update accordingly

## Measuring Success

Good ground rules result in:
- ✅ Less time correcting AI output
- ✅ Consistent code across sessions
- ✅ Fewer "why did AI do that?" moments
- ✅ Smoother development flow
- ✅ Higher quality first attempts

Bad ground rules cause:
- ❌ Constant rule conflicts
- ❌ AI confusion and errors
- ❌ Overly restrictive development
- ❌ More explanation than benefit

## The Compound Effect

Well-defined ground rules create compound benefits:

**Session 1**: Save 10 minutes not explaining preferences
**Session 10**: Save hours from consistent patterns
**Session 100**: Entire codebase follows your standards automatically

Ground rules are an investment. Define them once, benefit forever.


Remember: Ground rules are your contract with AI. Make them clear, keep them current, and enforce them consistently.