# Alignment Artifacts

## Documentation Is an Alignment Artifact

In the AlignStack framework, every document you create serves a specific purpose: it aligns human intent with AI understanding at a particular level. These documents aren't descriptions of what exists — they're instruments that ensure both sides agree before moving forward.

A task description isn't just a task description. It's Level 1 alignment — proof that the problem is understood. A step-by-step plan isn't just a plan. It's Level 3 alignment — proof that the specific actions are agreed upon.

When you see documentation this way, the quality bar changes. A vague doc isn't just unhelpful — it's a broken alignment instrument. And broken alignment compiles into broken implementation.

## The Two Roles of Documentation

With AI, documentation serves two roles simultaneously:

**1. Alignment role**: It ensures human and AI agree on what's being built, how, and why. Each document is a checkpoint in the AlignStack — a point where both sides can confirm "yes, we're aligned on this."

**2. Compilation role**: AI can turn aligned documentation into implementation. A well-written task description compiles into architecture. An interface spec compiles into APIs. A requirements doc compiles into features.

The second role only works if the first role is fulfilled. Documentation that isn't aligned compiles into the wrong thing — confidently, quickly, and at scale. This is the core danger of AI-assisted development: the compiler is powerful, but it amplifies whatever you feed it, including misalignment.

## What Makes an Artifact Aligned

Not all documents are alignment artifacts. A document becomes an alignment artifact when it:

- **Captures a decision, not just information**: "We will use PostgreSQL" is alignment. "PostgreSQL is a database" is not.
- **Has a clear level**: It maps to a specific level of the AlignStack. Workspace, task, action-space, action-set, coherence, or outcome.
- **Is verifiable**: Both sides can point to it and agree or disagree. Vague documents can't be verified — they just feel approximately right.
- **Is current**: An outdated document is worse than no document. It creates false alignment — both sides think they agree, but they're agreeing on something that's no longer true.

## Artifacts by Level

| Level | Artifact | What It Locks Down |
|-------|----------|-------------------|
| 0 - Workspace | Project description, architecture docs, convention guides | The environment and its rules |
| 1 - Task | Task description, success criteria, scope boundaries | What we're doing and why |
| 2 - Action-Space | Solution options, approach decision, high-level strategy | How we'll approach it |
| 3 - Action-Set | Step-by-step plan, implementation sequence | What exactly we'll do |
| 4 - Coherence | Compatibility review, impact analysis, critic doc | Whether it fits with what exists |
| 5 - Outcome | Verification report, gap analysis, retrospective | Whether it actually worked |

## The Compilation Chain

When artifacts are aligned at every level, AI compilation becomes reliable:

```
Aligned workspace docs     → AI understands the environment
Aligned task description   → AI understands the goal
Aligned approach decision  → AI understands the strategy
Aligned step-by-step plan  → AI understands what to build
Aligned coherence review   → AI understands what not to break
```

Each level constrains the next. The workspace docs constrain which approaches make sense. The approach constrains which steps are valid. The steps constrain what code gets written.

Remove any level and the compilation becomes unreliable. The AI fills the gap with assumptions — and assumptions are where misalignment hides.

## Precision Matters

An alignment artifact is only as good as the language it uses. Vague words create vague alignment. "Make it fast" aligns on nothing. "Response time under 200ms for 95th percentile" aligns on something concrete and verifiable.

This is why semantic precision isn't a nice-to-have — it's the difference between an artifact that actually aligns and one that merely looks like it does. A document full of ambiguous terms is a false checkpoint. Both sides pass through it thinking they agree, but they're agreeing on different interpretations of the same words.

## The Cost of Skipping Artifacts

Every skipped artifact is a level of alignment left to chance:

- Skip workspace docs → AI doesn't know the conventions. It invents its own.
- Skip task description → AI doesn't know the goal. It assumes one.
- Skip approach decision → AI picks whatever seems reasonable. It might not be.
- Skip step-by-step plan → AI improvises. Some steps will be wrong.
- Skip coherence review → AI doesn't know what it might break. It breaks things.
- Skip outcome verification → Nobody knows if it actually worked. It might not have.

Each skip feels like saving time. Each one is a gamble that alignment will happen by accident. Sometimes it does. Often it doesn't. And when it doesn't, the cost of fixing misaligned implementation far exceeds the cost of writing the artifact.

## Artifacts Are Not Bureaucracy

This might sound like heavy process. It's not. A task description can be three sentences. A coherence review can be a checklist. An outcome verification can be a single test run.

The point isn't volume — it's intentionality. Each artifact forces a moment of explicit agreement at a specific level. That moment is what prevents misalignment from silently propagating through the entire implementation.

Write the artifact. Verify the alignment. Then let AI compile.
