# Key Design Points

## 1. Developer Works Locally, Claude Works on Server

Claude Code runs on the server and pushes a branch with generated devdocs. Developer pulls that branch to their local machine and works as usual — editing code, running tests, iterating in their own environment. The server session handles analysis, the local fork handles implementation.

## 2. Session Stays Alive for Follow-Up

The Claude Code session that analyzed the task remains accessible. Developer can SSH in and resume the session to ask additional questions, request clarifications, or get deeper analysis. The session is supplementary — docs on the branch are the primary interface.

## 3. Push-Triggered Review Loop

When the developer pushes code to the task branch, the same Claude Code session can detect the changes, inspect the new code, and generate a `task_update_report.md`. This report evaluates:
- Does the implementation match the plan?
- Are there code quality issues?
- Are tests passing?
- Is the task ready for review or does it need more work?

This creates a continuous feedback loop: developer pushes → Claude reviews → developer iterates.

## 4. Session Sharing and Forking

Claude Code may support session sharing. If so, the system could:
- Complete the analysis in the original session
- Fork the session (preserving full context)
- Share the forked session with the developer

This gives the developer the full conversation history without affecting the original session. Needs further investigation into Claude Code's session sharing capabilities.

## 5. AI Can Also Implement, Not Just Analyze

The system isn't limited to generating docs. Once the analysis and implementation plan are approved, the same Claude Code session can execute the implementation. The developer's role shifts from "write the code" to "review and approve the code."

This means the developer accessing the session locally isn't just for follow-up questions — it's for steering the actual implementation.

## 6. The Context Transfer Problem

Ideally, the server's deep analysis session could be forked and transferred to the developer's local machine. But Claude Code sessions aren't portable across machines — context lives on the server.

Three approaches to solve this:

### Approach A: Deep Generic Analysis as Documents (Recommended)

The server performs a full codebase archaeology — traces, architecture analysis, module mapping, dependency graphs — and commits all of it as devdocs. This is the "deep generic analysis."

When the developer starts a local Claude Code session, it reads these docs first. This is "soft warming" — AI doesn't have the full session history, but it has the distilled knowledge. The docs act as a compressed transfer of understanding.

```
Server session (deep generic):
- Full archaeology traces
- Architecture analysis
- Module dependency maps
- Concept inventories
- File relevance mapping (HOT/WARM/COLD)

  ↓ committed to branch as devdocs

Developer's local session (soft context):
- Reads archaeology docs
- Reads architecture analysis
- Reads task-specific docs (solution_options, impl_plan)
- Now has ~80% of the server session's understanding
- Without spending tokens on re-analyzing the codebase
```

### Approach B: Claude Code Warm-Up Command

A custom command or script that pulls the devdocs and runs an initial indexing prompt:

```bash
# Developer runs this after checking out the task branch
claude --warm-from devdocs/
```

This would instruct Claude Code to read all devdocs before starting interaction. Still costs tokens but less than a full re-analysis.

### Approach C: Session Forking (Future)

If Claude Code ever supports session export/import or forking across machines, the server session's full context could be shared directly. This is the ideal solution but doesn't exist yet.

### Practical Decision

Approach A is the realistic path. The quality of the deep generic analysis docs determines how effective the local soft warming is. This means the archaeology traces, architecture docs, and module maps must be thorough — they are the transfer mechanism.

## 7. Two Levels of Server Analysis

The server can perform two distinct analyses:

### Generic Analysis (Codebase-Level)
- Full archaeology of the codebase
- Architecture patterns, module maps, dependency graphs
- Not task-specific — applies to any task on this codebase
- Can be reused across multiple tasks
- Done once (or periodically), shared by all task sessions

### Task-Based Analysis (Task-Level)
- Task-specific codebase analysis
- File relevance mapping for this task
- Solution options, implementation plan, test designs
- Done per task, builds on generic analysis output

Separating these means the expensive codebase understanding is done once. Each task only pays for the task-specific analysis on top.

## 8. Complexity-Aware Planning: Flat vs. Staged

Not all tasks are equal. The system should judge task complexity and choose the appropriate planning methodology.

### Simple Tasks → Flat Plan
For straightforward tasks, the system generates the standard 5 documents directly:
- task_desc.md
- solution_options.md
- step_by_step_impl_plan.md
- task_test_designs.md
- critic.md

### Complex Tasks → Staged Plan
For tasks requiring more granular control, instead of a flat step-by-step plan, the system creates a stage-by-stage plan. Each stage gets its own folder with dedicated documentation:

```
devdocs/task-JIRA-456/
├── overview.md                  # Overall staged plan
├── stage_1_setup/
│   ├── desc.md                  # What this stage achieves
│   ├── step_by_step_plan.md     # Detailed steps within stage
│   └── critic.md                # Risks and edge cases for this stage
├── stage_2_core_logic/
│   ├── desc.md
│   ├── step_by_step_plan.md
│   └── critic.md
├── stage_3_integration/
│   ├── desc.md
│   ├── step_by_step_plan.md
│   └── critic.md
└── ...
```

This gives developers granular control — they can approve, modify, or reject individual stages rather than the entire plan.

### How Complexity Is Determined

Two mechanisms:

**Automatic:** The system evaluates complexity based on:
- Number of files affected
- Number of modules touched
- Cross-cutting concerns (auth + storage + API etc.)
- Estimated lines of change

**Manual override:** Special keywords in the Jira task trigger staged planning:
- `[staged]` or `[complex]` in task title or description
- A custom Jira field (e.g., "Planning Mode: Staged")
- Jira labels (e.g., `vdd-staged`)

This ensures complex tasks get the depth they need while simple tasks aren't over-documented.

## 9. Scaling: Multiple Accounts and Servers

For teams with many concurrent tasks:
- One Claude Code account has rate limits and token quotas
- Multiple accounts may be needed to handle parallel tasks
- Multiple servers may be required for isolation and load distribution
- Agent Manager needs to handle account pooling and load balancing

Considerations:
- Account rotation strategy
- Token budget tracking per account
- Queue system for tasks when all accounts are busy
- Server provisioning (static fleet vs. dynamic scaling)

## 10. Dashboard

A central dashboard for observing the entire system:

### Task Status View
- All active tasks with current status (analyzing / docs ready / in review / complete)
- Which Claude session is handling which task
- Time elapsed per analysis

### Resource View
- Token usage per account
- Active sessions per server
- Queue depth (tasks waiting for a free session)

### Quality View
- Tasks that needed clarification vs. tasks that were clear
- Developer acceptance rate of generated docs
- How often developers modify the generated plan
- Push-to-approval cycle time

### Alerts
- Session failures or timeouts
- Token budget approaching limits
- Tasks stuck in analysis too long
- Server health issues

## 11. Claude Code for Web Changes Everything

Claude Code for web (`claude.ai/code`) runs Claude Code sessions on Anthropic-managed infrastructure. This eliminates the need for a self-hosted server entirely.

### What It Provides

- **Programmatic session spawning**: `claude --remote "prompt"` starts a web session from the command line. This is the hook the Jira Task Manager needs — no custom server, no session management, no VM provisioning.
- **Parallel execution**: Each `--remote` call creates an independent session. Multiple tasks run simultaneously without managing a server fleet.
- **Teleport**: `claude --teleport` pulls a web session into the developer's local terminal — full conversation history + branch checkout. This completely solves the context transfer problem (Point 6). No need for "soft warming" via docs — the developer gets the actual session.
- **Session sharing via links**: Sessions can be shared with team members. A session link posted to the Jira ticket gives any developer direct access to the full analysis conversation.
- **CLAUDE.md respected**: Web sessions read the repo's CLAUDE.md, so generic analysis instructions, prompt templates, and project conventions carry over automatically.
- **SessionStart hooks**: `.claude/settings.json` can configure automatic dependency installation when a session starts. This replaces custom environment setup.
- **Environment configuration**: Network access levels (none, limited, full), environment variables, all configurable per environment.
- **Diff view and PR creation**: Built-in diff review and one-click PR creation from the web UI.

### Architecture Collapse

The original architecture required:
- A server with Claude Code installed
- Codebase cloning and syncing
- Session lifecycle management
- Git credential management
- Environment setup and maintenance

With Claude Code for web, the Claude Agent Manager reduces to:
1. Call `claude --remote "prompt"` with task context
2. Capture the session URL
3. Post session URL to Jira ticket
4. Monitor session completion

The server infrastructure is Anthropic's problem. We just trigger and track.

### What This Replaces

| Before (Self-Hosted) | After (Claude Code for Web) |
|---|---|
| Manage server fleet | Anthropic manages VMs |
| Clone and sync codebases | Automatic repo cloning from GitHub |
| Session spawning and lifecycle | `claude --remote` |
| Soft warming via docs (Point 6) | Teleport gives full session context |
| Session sharing speculation (Point 4) | Built-in session sharing via links |
| SSH resume for developer access | Teleport to local terminal |
| Custom environment setup | SessionStart hooks + environment config |

### Constraints

- **GitHub only**: Claude Code for web only works with GitHub-hosted repositories. GitLab and other providers are not supported.
- **Rate limits**: Shares rate limits with all Claude usage on the account. Parallel tasks consume proportionally more.
- **Account access**: Requires Pro, Max, Team, or Enterprise Claude plans.
- **Network proxy**: All outbound traffic passes through a security proxy. Some tools (e.g., Bun) may not work correctly with it.
