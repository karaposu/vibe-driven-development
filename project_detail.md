# Project Detail: Developer Access to Task Sessions

## The Problem

Claude Code sessions run on a server, one per Jira task. But developers need to:
- View what Claude analyzed
- Continue the conversation (ask follow-ups, refine docs)
- Adjust the generated plan before approving

How do developers connect to a specific task's Claude Code session?

## Options

### Option 1: SSH + Session Resume

Claude Code supports `--resume` with session IDs.

Flow:
1. Claude Agent Manager stores session ID per task
2. Session ID is posted to Jira ticket as a comment
3. Developer SSHes into server
4. Runs `claude --resume <session-id>`
5. Full conversation history is available, developer continues where AI left off

Pros:
- Simple, uses existing Claude Code functionality
- Full context preserved
- Developer gets the real Claude Code experience

Cons:
- Requires SSH access to server
- Not great UX for non-terminal users
- One developer at a time per session

### Option 2: Web Terminal Proxy

Expose Claude Code sessions via a web-based terminal (e.g., ttyd, Wetty, or custom solution).

Flow:
1. Each task session gets a web terminal URL
2. URL is posted to Jira ticket
3. Developer clicks link, gets browser-based terminal
4. Already attached to the Claude Code session

Pros:
- No SSH setup needed
- Accessible from any browser
- Link directly in Jira ticket — one click

Cons:
- Extra infrastructure (web terminal service)
- Security considerations (auth, isolation)
- Still a terminal experience

### Option 3: Read-Only Output + New Session for Interaction

Don't connect to the original session. Instead:
1. All outputs (docs, analysis) are committed to git branch
2. Developer reads docs on GitHub/GitLab
3. If developer wants to interact, they start a NEW Claude Code session locally with the docs as context

Flow:
1. Generated docs are the interface, not the session
2. Jira ticket has branch link with all docs
3. Developer checks out branch, opens Claude Code locally
4. Claude Code reads the existing docs and continues from there

Pros:
- No server access needed
- Developer works in their own environment
- Docs ARE the handoff — clean separation

Cons:
- Loses original conversation context
- Developer's local Claude Code session starts fresh
- Might duplicate some analysis

### Option 4: Claude Code Remote Sessions

Claude Code may support remote/shared sessions. If available:

Flow:
1. Session is created on server
2. A shareable session URL is generated
3. URL posted to Jira ticket
4. Developer connects from their own Claude Code client

Pros:
- Best UX
- Native Claude Code experience
- No extra infrastructure

Cons:
- Depends on Claude Code supporting this feature
- May not exist yet

## Recommendation

**Start with Option 3** (docs as interface) because:
- Simplest to build
- No infrastructure beyond git
- Docs are the actual deliverable anyway
- Developers already know git workflows

**Evolve to Option 1 or 2** when:
- Developers need to interact with the analysis in real-time
- Tasks are complex enough that reading docs isn't enough
- Team is comfortable with terminal-based access

**Watch for Option 4** as Claude Code evolves.

## Hybrid Approach

In practice, combine options:

```
Task created in Jira
        ↓
Claude Code session runs on server
        ↓
Outputs committed to git branch
        ↓
Jira ticket updated with:
├── Branch link (Option 3 — everyone can read docs)
├── Session ID (Option 1 — SSH users can resume)
└── Web terminal URL (Option 2 — if infra exists)
```

Developers choose their preferred access method. The docs on git are always available as the minimum interface.

## Session ID Capture Flow

The key mechanism: when Claude Agent Manager spawns a session, it captures the session ID and passes it to Jira.

```
1. Jira webhook fires → new task JIRA-456 detected

2. Claude Agent Manager:
   - Creates task branch: task/JIRA-456-analysis
   - Spawns Claude Code session with task context
   - Captures session ID from Claude Code (e.g., abc-123-def)

3. Jira Task Manager posts comment on JIRA-456:
   ┌─────────────────────────────────────────┐
   │  AI Analysis Started                    │
   │                                         │
   │  Session ID: abc-123-def                │
   │  Branch: task/JIRA-456-analysis         │
   │  Status: In Progress                    │
   │                                         │
   │  To connect:                            │
   │  ssh devserver && claude --resume abc-123-def │
   └─────────────────────────────────────────┘

4. Claude Code session completes analysis

5. Jira Task Manager posts second comment:
   ┌─────────────────────────────────────────┐
   │  AI Analysis Complete                   │
   │                                         │
   │  Branch: task/JIRA-456-analysis         │
   │  Docs generated:                        │
   │  - task_desc.md                         │
   │  - solution_options.md                  │
   │  - step_by_step_impl_plan.md            │
   │  - task_test_designs.md                 │
   │  - critic.md                            │
   │                                         │
   │  To continue conversation:              │
   │  ssh devserver && claude --resume abc-123-def │
   │                                         │
   │  Status: Awaiting Developer Review      │
   └─────────────────────────────────────────┘

6. Developer connects anytime to:
   - Ask follow-up questions about the analysis
   - Refine the generated docs
   - Request alternative approaches
   - Approve for implementation
```

## Open Questions

- Should multiple developers be able to connect to the same session?
- Should there be a way to "approve" from within the session (triggers implementation)?
- How do we handle session timeout/expiry on the server?
- Should the server keep sessions alive indefinitely or clean up after X hours?
- Can we pipe Claude Code output to a Slack/Teams channel for passive monitoring?
