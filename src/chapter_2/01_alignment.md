# The Alignment Chain

## The Core Problem

When you delegate work — to a person, a team, or an AI — failure rarely happens at execution. It happens at understanding. The person builds the wrong thing not because they lack skill, but because what they understood and what you meant were never the same.

This is the alignment problem. Not in the existential AI safety sense, but in the practical, everyday sense: are we talking about the same thing?

## Alignment Is Not a Single Moment

Most people treat alignment as a one-shot event. You describe what you want. The other side says "got it." Work begins. Then, three days later, you realize they built something entirely different.

The mistake is treating alignment as binary — aligned or not. In reality, alignment has layers. You can be perfectly aligned on *what* the task is and completely misaligned on *how* to approach it. You can agree on the approach and disagree on the specific steps. You can agree on the steps and still produce something that contradicts everything already in place.

Each layer is a different kind of understanding. Each can fail independently.

## The Five Levels

### Level 0: Workspace Alignment

Before any task begins, there's a foundational question: does the person doing the work understand the environment they're operating in?

This means understanding:
- What already exists and how it's structured
- What conventions are in place
- What constraints apply (technical, organizational, stylistic)
- What has been tried before and what was decided against

Without this, every task starts from a blank slate. Decisions that contradict existing patterns get made. Work that duplicates what already exists gets created. The person is operating in a vacuum, and no amount of task-level clarity fixes that.

Workaction-space alignment is done once and maintained over time. It's the shared understanding of the playing field.

### Level 1: Task Alignment

*Is the task understood clearly?*

This is the most basic level: what are we doing and why? Not how — just what.

A task that says "improve the search" is not aligned. Improve how? For whom? What's wrong with it now? What does success look like?

Task alignment means both sides agree on:
- What the problem is
- Why it matters
- What the expected outcome looks like
- What is explicitly out of scope

If this level fails, everything downstream is wasted effort. A perfectly executed plan for the wrong task is still the wrong task.

### Level 2: Action-Space Alignment

*Is the actionable space understood clearly?*

Once the task is clear, the next question is: where do we act? What's the high-level strategy?

For any non-trivial task, there are multiple valid approaches. Space alignment is about agreeing on which region of the solution space we're operating in — before committing to specific steps.

This is the difference between "we'll extend the existing module" and "we'll build a new module from scratch." Both might solve the task. But they lead to completely different action plans, different risks, and different integration points.

If you skip this level and jump straight to steps, you might end up with a perfect step-by-step plan for an approach that was never the right one.

### Level 3: Action-Set Alignment

*Is the set of actions understood clearly?*

Now we're concrete. Given the task (Level 1) and the approach (Level 2), what exactly are the steps?

This is the level where vague intent becomes a specific sequence of operations. Each action should be unambiguous enough that someone could execute it without asking clarifying questions.

Action alignment catches a different class of problems than task or action-space alignment. The task is right, the approach is right, but the steps are out of order, or a critical step is missing, or a step makes an assumption that doesn't hold.

### Level 4: Coherence Alignment

*Are the defined actions aligned with the existing aligned structure?*

This is the final check: does this plan fit with what already exists?

A plan can be correct in isolation and still be wrong in context. It might duplicate functionality. It might contradict established patterns. It might introduce inconsistency. It might break implicit contracts that nothing documents but everything depends on.

Coherence alignment is where the plan meets reality. It asks: if we execute these actions, will the result be coherent with the whole — or will it create a new island that doesn't connect to anything?

### Level 5: Outcome Alignment

*Did the result actually solve the original problem?*

Everything above can be perfectly aligned and the outcome can still miss the mark. The task description was subtly wrong. The success criteria didn't capture what actually mattered. The real problem was adjacent to the one that was articulated.

Outcome alignment closes the loop. After execution, you compare what was built against the original intent — not the plan, not the steps, but the actual problem that started everything.

This level is different from the others because it happens after the work, not before. It's retrospective. And it feeds back into the chain: what you learn from outcomes updates your workspace understanding (Level 0), sharpens how you write tasks (Level 1), and calibrates your judgment about approaches (Level 2). The chain becomes a cycle.

Without outcome alignment, you can complete task after task with perfect process and gradually drift from what actually matters.

## Why the Order Matters

The levels are sequential for a reason. Each one depends on the one above:

- You can't evaluate the approach (Level 2) if the task isn't clear (Level 1)
- You can't define steps (Level 3) if the approach isn't chosen (Level 2)
- You can't check structural fit (Level 4) if the steps don't exist yet (Level 3)
- You can't verify outcomes (Level 5) if nothing was executed yet (Levels 0-4)
- None of the above work if the workspace isn't understood (Level 0)
- Level 5 feeds back into Level 0 — the chain becomes a cycle

Skipping levels is how misalignment sneaks in. It feels faster to jump straight to action, but you end up building the wrong thing faster.

## The Cost of Misalignment at Each Level

The earlier the misalignment, the more expensive:

| Level | Misalignment | Cost |
|-------|-------------|------|
| 0 - Workspace | Operating without understanding the environment | Contradicts existing patterns, duplicates work |
| 1 - Task | Building the wrong thing | Total waste — everything must be redone |
| 2 - Action-Space | Right task, wrong approach | Major rework — approach must be reconsidered |
| 3 - Action-Set | Right approach, wrong steps | Partial rework — specific steps need fixing |
| 4 - Coherence | Right steps, poor fit | Tech debt — works but doesn't belong |
| 5 - Outcome | Everything aligned, wrong result | Silent drift — process looks good, results don't |

## Alignment as Documentation

Each level of alignment naturally produces an artifact:

| Level | What It Captures |
|-------|-----------------|
| 0 - Workspace | Environment understanding, conventions, constraints |
| 1 - Task | Problem statement, success criteria, scope boundaries |
| 2 - Action-Space | High-level approach, strategy, key decisions |
| 3 - Action-Set | Step-by-step plan, specific operations |
| 4 - Coherence | Compatibility review, fit analysis, identified conflicts |
| 5 - Outcome | Verification against original intent, gap analysis, lessons feeding back to Level 0 |

These aren't bureaucratic paperwork. They're proof of alignment — a checkpoint at each level that both sides can point to and say "yes, we agree on this before moving forward."

When work goes wrong, you can trace back to exactly which level of alignment broke down. When work goes right, these artifacts explain why.

## Alignment in Practice

The alignment chain applies whether you're delegating to a junior developer, briefing a contractor, or prompting an AI. The failure modes are the same:

- Skip workspace alignment → they don't know what's already there
- Skip task alignment → they build confidently in the wrong direction
- Skip action-space alignment → they pick an approach you'd never approve
- Skip action-set alignment → they improvise steps that miss critical details
- Skip coherence alignment → they produce something that doesn't fit
- Skip outcome alignment → you never learn whether the work actually mattered

The only difference is speed. With AI, misalignment manifests in seconds instead of days. Which means the cost of skipping alignment is felt immediately — but also means the cost of doing alignment is low. A few minutes of structured alignment saves hours of misaligned output.
