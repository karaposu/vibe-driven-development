# When to Guide vs When to Follow

## The Fundamental Question

Every AI interaction presents a choice: Do I lead or do I follow? Wrong choice = wasted time.

## When to Guide (You Lead)

### 1. Business Requirements
AI doesn't know your users, market, or constraints.

```
GUIDE: "Users need to export data for tax purposes in specific format"
NOT: "How should users export data?"
```

### 2. Architecture Decisions
AI suggests patterns. You choose based on reality.

```
GUIDE: "Use REST APIs since our mobile team knows it well"
NOT: "Should we use REST or GraphQL?"
```

### 3. Performance Constraints
AI doesn't know your scale or bottlenecks. 

```
GUIDE: "This needs to handle 10k requests/second"
NOT: "Make it fast"
```

### 4. Security Requirements
AI knows general security. You know your threat model.

```
GUIDE: "We need SOC2 compliance with audit logging"
NOT: "Make it secure"
```

### 5. Integration Points
AI doesn't know your existing systems.

```
GUIDE: "This must integrate with our legacy SOAP API"
NOT: "How should this communicate with other services?"
```

## When to Follow (AI Leads)

### 1. Implementation Details
Once direction is set, let AI handle specifics.

```
GUIDE: "Users need to stay logged in for 30 days"
FOLLOW AI's answer to: "What's the best way to implement JWT refresh tokens?"
```

### 2. Best Practices
AI knows current standards better than most developers.

```
GUIDE: "It needs to display user profiles"
FOLLOW AI's answer to: "How should I structure this React component?"
```

### 3. Error Handling
AI excels at comprehensive error cases.

```
GUIDE: "It processes payment webhooks"
FOLLOW AI's answer to: "What errors should this API endpoint handle?"
```

### 4. Refactoring Suggestions
AI sees patterns you might miss.

```
GUIDE: "It must remain backwards compatible"
FOLLOW AI's suggestion when asking: "This code feels complex. Suggest improvements."
```

### 5. Technology Selection
For well-understood problems, AI knows tool tradeoffs.

```
GUIDE: "We're on AWS with Redis experience"
FOLLOW AI's recommendation for: "What caching solution for session data?"
```

## The Grey Zone

Some decisions need negotiation:

### API Design
```
Human: "I need user management endpoints"
AI: "Here's a RESTful design..."
Human: "Actually, we prefer GraphQL"
AI: "Here's the GraphQL schema..."
```

Start by following, then guide corrections.

### Database Schema
```
AI: "Suggests normalized schema"
Human: "We optimize for reads, denormalize"
AI: "Here's denormalized version"
```

Let AI propose, you dispose.

### Testing Strategy
```
Human: "We need tests"
AI: "Unit, integration, and E2E tests..."
Human: "We only do integration tests"
AI: "Focused integration test suite..."
```

## Pattern Recognition

### Guide When:
- Domain-specific knowledge required
- Business logic involved
- External constraints exist
- Past decisions affect current
- User experience matters

### Follow When:
- Technical implementation unclear
- Multiple valid approaches exist
- Best practices needed
- Common patterns apply
- You're learning something new


## Communication Strategies

### When Guiding
Be specific and constraining:
```
"Build auth with these requirements:
- Email/password only
- 2FA via SMS
- Session length 24 hours
- PostgreSQL storage"
```

### When Following  
Be open and exploratory:
```
"I need authentication. What approach would you recommend given modern security practices?"
```

### The Hybrid Approach
Most effective:
```
"I need auth for a B2B SaaS (context).
What's the current best practice (follow)?
Must integrate with Okta (guide)."
```

