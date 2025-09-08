# Semantic Precision and "The Butterfly Defect"

## The Weight of Words

In human communication, we tolerate ambiguity. "Fast" could mean milliseconds or minutes. "User-friendly" means different things to different people.

AI doesn't tolerate - it interprets. And propagates.

## The Butterfly Defect

Traditional butterfly effect: A butterfly flaps wings in Brazil, causes tornado in Texas.

The Butterfly Defect: You type "modal" instead of "dialog", your entire UI philosophy shifts.

Real example:
```
Human: "Create a service for handling user data"
AI: *builds microservice architecture*

vs

Human: "Create a class for handling user data"
AI: *builds single class with methods*
```

One word. Completely different architecture.

## The Propagation Problem

Wrong terminology compounds:
- Say "component" → AI assumes React
- React assumption → hooks everywhere
- Hooks everywhere → state management complexity
- Complexity → performance issues


The defect spreads through every decision.

## Finding the Right Words

Two strategies:

### 1. Use AI as Terminology Guide
```
Human: "What's the proper term for a popup window that blocks interaction?"
AI: "That's called a 'modal dialog' or simply 'modal'"
```

### 2. Define Terms Explicitly
```
For this project:
- "Service" means a class with business logic
- "Module" means a Python file
- "Component" means a logical grouping of features
```

## Common Defects to Avoid

- "Simple" → AI removes error handling
- "Fast" → AI ignores correctness
- "Modern" → AI adds every new feature
- "Clean" → AI over-abstracts

## The Precision Principle

Be specific about:
- Technical terms (service vs class vs module)
- Scope words (simple vs minimal vs basic)
- Quality attributes (fast vs optimized vs efficient)

Remember: AI amplifies ambiguity into architecture.

## The Fix

When you catch a Butterfly Defect:
1. Stop immediately
2. Correct the terminology
3. Explicitly state what you mean
4. Let AI adjust course

Better to fix terminology early than refactor architecture later.


## Using a clearly named variables 

Because ai treats variables together with their names, sacrificing shortness in order to clearly define a varible is good practice.  