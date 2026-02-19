# VDD Task Automation

## What Is This?

An automated pipeline that connects Jira tasks to codebase analysis using VDD patterns. When a task is created in Jira, AI analyzes it against the relevant codebase and produces structured technical documentation — before any developer touches the code.

## The Problem

1. Tasks are often vague or ambiguous, leading to back-and-forth between task creators and developers
2. Developers spend significant time understanding tasks, analyzing the codebase, and planning implementation before writing a single line of code
3. Context about how a task relates to existing code lives only in developers' heads

## How It Works

### Step 1: Task Intake
A Jira task is created. The system picks it up automatically.

### Step 2: Clarity Check
AI analyzes the task description. Two paths:

**If unclear:** AI generates clarifying questions and posts them as comments on the Jira ticket within seconds. The task creator responds directly on the ticket. No Slack threads, no meetings, no ambiguity ping-pong.

**If clear:** Proceeds to analysis.

### Step 3: Codebase Analysis
AI analyzes the relevant codebase in context of the specific task:
- Which files and modules are affected?
- What are the dependencies?
- What patterns exist in the codebase?

### Step 4: Documentation Generation
AI produces 5 technical documents on a dedicated git branch:

| Document | Purpose |
|----------|---------|
| `task_desc.md` | Clarified, expanded task description |
| `solution_options.md` | Possible approaches with tradeoffs |
| `step_by_step_impl_plan.md` | Detailed implementation plan per solution |
| `task_test_designs.md` | Test cases and validation criteria |
| `critic.md` | Risks, edge cases, and potential issues |

### Step 5: Developer Review
Developer reviews the generated docs, adjusts if needed (with AI assistance), and approves for implementation. The heavy thinking is already done.

### Step 6: Tracking
The system posts back to the Jira ticket:
- Link to the git branch with documentation
- Link to Confluence page (if applicable)
- Summary of the analysis

Everything stays trackable within Jira.

## Value

| Without | With |
|---------|------|
| Developer reads vague task, guesses intent | AI clarifies ambiguity before work starts |
| Hours spent analyzing codebase for relevance | Automated codebase analysis in minutes |
| Implementation plan lives in developer's head | Documented, reviewable implementation plan |
| No visibility until code is written | Full transparency before first line of code |
| Context lost between sessions | Persistent documentation on git branch |

## Architecture (High Level)

Three main components:

### Component 1: Jira Task Manager
Handles all Jira communication:
- Listens for new/updated tasks via webhooks
- Pulls task descriptions and comments
- Posts clarifying questions as comments
- Posts analysis results (branch links, summaries) back to tickets
- Tracks task state

### Component 2: Claude Agent Manager
Manages Claude Code sessions per task:
- Spawns a new Claude Code session for each incoming task
- Runs on a server with the target codebase already cloned
- Feeds task context into the Claude Code session
- Collects outputs (docs, branch) when session completes
- Each session is stateless — starts fresh, does the work, exits

### Flow

```
┌──────────────────────┐      ┌──────────────────────────┐
│   Jira Task Manager  │      │   Claude Agent Manager   │
│                      │      │                          │
│  Webhook listener    │      │  Session spawner         │
│  Comment poster      │      │  Claude Code instances   │
│  Link updater        │      │  Output collector        │
└──────────┬───────────┘      └──────────┬───────────────┘
           │                             │
           │   1. New task detected      │
           ├────────────────────────────→│
           │                             │ 2. Spawn Claude Code session
           │                             │    (server has codebase)
           │                             │
           │                             │ 3. Claude Code:
           │                             │    - Reads task description
           │                             │    - Analyzes codebase
           │                             │    - Checks clarity
           │                             │
           │   4a. (unclear)             │
           │←── Post questions to Jira ──│
           │                             │
           │   4b. (clear)               │
           │                             │ - Generates 5 docs
           │                             │ - Creates git branch
           │                             │ - Commits docs to branch
           │                             │
           │   5. Results ready          │
           │←── Branch link + summary ───│
           │                             │
           │   6. Post to Jira ticket    │
           │                             │
```

### Component 3: Dashboard Service
Aggregates data from both components for observability:
- Task status view (from Jira Task Manager)
- Token usage and session metrics (from Claude Agent Manager)
- Server health monitoring
- Quality metrics (clarity rate, developer acceptance rate)
- Alerts (failures, budget limits, stuck tasks)

Read-only service — does not modify tasks or sessions. Built in v1.2 after core pipeline proves value.

### Server Setup

The server maintains:
- Up-to-date clone of the target codebase (git pull on schedule or webhook)
- Claude Code installed and configured
- Jira API credentials
- Git credentials for branch creation and pushing

Each Claude Code session:
- Gets its own working directory (or works on a fresh branch)
- Has full codebase access via Claude Code's built-in tools (Read, Grep, Glob)
- Outputs docs as markdown files committed to a task-specific branch
- Session ends after work is complete — no persistent state

## Core VDD Patterns Used

- **Archaeology Pattern**: Claude Code analyzes existing codebase before suggesting changes
- **DevDocs Pattern**: Structured documentation drives implementation
- **Probe Tests Pattern**: Test designs created before implementation
- **Offload Pattern**: Everything structured to make AI's and developer's job easier
- **File Relevance Mapping**: HOT/WARM/COLD classification of affected files
