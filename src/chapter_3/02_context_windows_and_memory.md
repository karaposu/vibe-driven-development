# Context Windows and Memory

## The Fundamental Limitation

Every AI has a context window - the total amount of text it can "see" at once. Think of it as RAM, not hard drive.
Even tho we see huge gains in terms of incresed context length it still matter to use it efficiently. 


## Context Window !== Memory

**Context Window**: What AI can see right now
**Memory**: What AI learned during training

You can fill the context window. You can't add to memory.

## The Sliding Window Problem

As conversation grows, early content falls out:

```
[Start of conversation]
"Here are my ground rules..." <- Eventually falls out
[... many messages ...]
"Why aren't you following the ground rules?" <- AI: "What ground rules?"
[Current message]
```

Anchor pattern is a good fix for this issue. 

## Token Economics

Everything counts against the window:
- Your messages
- AI responses
- Code snippets
- Error messages
- File contents

Long error stacktraces can eat 1000+ tokens instantly.

## Strategies for Large Codebases

### 1. The Core + Context Pattern

Don't share everything. Share:
- Core file being modified
- Direct dependencies only
- Relevant interfaces
- Specific test files

### 2. The Summarization Ladder

For huge codebases:
```
Level 1: Full implementation files (for current work)
Level 2: Interface files (for dependencies)
Level 3: Summary docs (for distant modules)
Level 4: Architecture overview (for system context)
```

### 3. The Refresh Pattern

Periodically refresh context:
```
"Let me remind you of the key requirements:
- [Critical point 1]
- [Critical point 2]
We're currently working on [specific task]"
```

### 4. The Checkpoint Strategy

After major milestones:
```
"We've completed the authentication module.
Here's what we built: [summary]
Now let's move to the authorization module."
```

## Window Management Techniques

### Compression via Abstraction

Instead of:
```python
# Sharing full implementation
class UserService:
    def __init__(self, db, cache, logger):
        self.db = db
        self.cache = cache
        self.logger = logger
    
    def create_user(self, email, password):
        # 50 lines of implementation
        
    def authenticate(self, email, password):
        # 30 lines of implementation
        
    # ... 10 more methods
```

Share:
```python
# UserService interface
class UserService:
    """Handles user CRUD and authentication"""
    def create_user(self, email: str, password: str) -> User
    def authenticate(self, email: str, password: str) -> str  # JWT token
    def get_user(self, user_id: str) -> User
    # ... just signatures
```

devdocs pattern explicitly creates a doc called interfaces_and_endpoints.md which can be used for this exact purpose as well. 

### Selective Inclusion

Use AI to identify what to include:
```
"I need to modify the payment processing.
What files should I share with you?"
```

AI often knows what it needs to see.

### The Layered Approach

1. Start with high-level overview
2. Drill into specific modules
3. Zoom into exact functions
4. Back out to integration level

Like Google Maps for code.


## The Context Budget

Treat tokens like money:
- Budget for each conversation
- Spend on valuable context
- Cut unnecessary verbosity
- Save for complex operations

## Signs You're Out of Context

- AI forgets earlier requirements
- Suggestions contradict prior work
- Generic responses increase
- AI asks for clarification repeatedly

Time to refresh or start new conversation.

