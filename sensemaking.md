# Structural Sensemaking: VDD Task Automation

---

## Initial Sense Version (SV1 — Baseline Understanding)

A system that sits between Jira and a codebase, using Claude Code to automatically analyze tasks, generate documentation, and create implementation plans before developers start coding. It eliminates the ambiguity gap between task creation and implementation.

---

## Phase 1 — Cognitive Anchor Extraction

### Constraints
- Claude Code runs on Anthropic-managed infrastructure via Claude Code for web (not self-hosted)
- One Claude Code session per task (stateless per task)
- Jira is the single source of truth for task management
- Developers work locally on their own machines
- Claude Code accounts have rate limits and token quotas (shared across all Claude usage)
- Session sharing is supported — sessions can be shared via links (team or public visibility)
- Codebase is cloned automatically from GitHub by Claude Code for web
- Sessions are portable: teleport pulls full conversation + branch to local terminal
- Token cost scales with codebase size and task complexity
- **GitHub only** — Claude Code for web only supports GitHub-hosted repositories
- Requires Pro, Max, Team, or Enterprise Claude plans

### Key Insights
- The system doesn't replace developers — it front-loads the thinking phase
- Documentation is as important as code output — the system produces both
- The push-triggered review loop creates a continuous AI feedback cycle beyond initial analysis
- The real bottleneck in development is understanding, not typing — this targets understanding directly
- Git branches serve as both delivery mechanism and collaboration interface
- This is VDD patterns (Archaeology, DevDocs, Probe Tests) automated into a pipeline
- AI can also implement, not just analyze — the boundary between planning and execution is fluid
- Codebase understanding (generic) and task analysis (task-based) are two separable concerns with different lifespans
- Deep analysis documents can serve as a compressed context transfer mechanism between server and local sessions
- Task complexity should determine planning depth — not all tasks need the same treatment
- Claude Code for web eliminates self-hosted server infrastructure — Anthropic manages the VMs
- `claude --remote` is the programmatic trigger — replaces custom session spawning
- Teleport solves context transfer completely — full session history + branch, not just docs
- Session sharing via links replaces speculation about session forking

### Structural Points
- **Two core components (simplified)**: Jira Task Manager + Dashboard Service. Claude Agent Manager collapses to `claude --remote` calls — no self-hosted infrastructure.
- **Three phases of value**: Pre-implementation (analysis/docs) + During-implementation (review loop) + Implementation itself (AI codes)
- **Three interfaces**: Jira comments, git branches, Claude Code web sessions (shareable via links)
- **Two output modes (MVP)**: Flat plan (5 docs) for simple tasks, staged plan (per-stage folders) for complex tasks
- **Two output modes (Full)**: Doc output mode (flat/staged planning docs) + Code alter mode (codebase edits + implementation success report)
- **Two analysis tiers**: Generic (codebase-level, reusable) + Task-based (task-specific, per task)
- **Three access methods**: Session link in Jira (primary), Teleport to local terminal (full context), Dashboard (observe)
- **Context transfer solved**: Teleport gives developers the full session — conversation history + branch. Docs remain useful but are no longer the only transfer mechanism.

### Foundational Principles
- AI analyzes before humans implement
- Documentation drives implementation (VDD core principle)
- Developers remain the decision makers — AI proposes, human disposes
- Everything stays trackable within existing tools (Jira, Git)
- The system should reduce developer cognitive load, not add to it
- Expensive analysis (codebase understanding) should be done once and reused
- Planning granularity should match task complexity
- Infrastructure should be someone else's problem when possible (Claude Code for web)

### Meaning-Nodes
- **Ambiguity elimination**: AI catches vagueness before it becomes wasted effort
- **Pre-implementation intelligence**: Knowledge about the task is generated before any code
- **Continuous feedback**: Not a one-shot analysis but an ongoing loop
- **Developer sovereignty**: Developers choose how to interact and can steer AI implementation
- **Context portability**: The challenge of moving understanding from server to developer without losing fidelity
- **Adaptive complexity**: The system adapts its output depth to match the task's demands

---

### Sense Version 2 (SV2 — Anchor-Informed Understanding)

This is not just "AI reads Jira tasks." It is a multi-phase system that: (1) performs reusable codebase archaeology (generic analysis), (2) generates task-specific intelligence (task-based analysis) with complexity-appropriate planning depth, (3) monitors developer progress through a push-triggered review loop, and (4) can participate in implementation itself. The system operates through three interfaces (Jira, Git, Claude web sessions) and solves the context transfer problem via teleport (full session + branch to local terminal). Claude Code for web eliminates the need for self-hosted infrastructure — `claude --remote` triggers sessions on Anthropic-managed VMs. Session links posted to Jira give developers direct access. Planning depth adapts — simple tasks get flat plans, complex tasks get staged plans with per-stage documentation.

---

## Phase 2 — Perspective Checking

### Technical / Logical
- `claude --remote` is the critical technical dependency — programmatic session spawning on Anthropic infrastructure
- Webhook reliability (Jira → our service) is a single point of failure
- Git branch management at scale needs automation (cleanup, naming conventions, conflicts)
- Codebase sync is handled by Claude Code for web (clones from GitHub automatically) — no longer our concern
- Token consumption per task is unpredictable — large codebases may exhaust context
- Generic analysis can be cached and reused, dramatically reducing per-task token cost
- Complexity detection needs heuristics (files affected, modules touched, cross-cutting concerns)
- Teleport (`claude --teleport`) solves context transfer — full session history + branch checkout
- Session sharing via links enables Jira integration — post link, developer clicks through
- SessionStart hooks in `.claude/settings.json` handle environment setup automatically
- CLAUDE.md carries generic analysis instructions into every web session
- All outbound traffic goes through Anthropic's security proxy — some tools may not work
- **New anchor**: Need a queue/retry system for webhook failures
- **New anchor**: Generic analysis caching strategy is a critical optimization
- **New anchor**: Complexity detection must have both automatic and manual override paths
- **New anchor**: `claude --remote` output parsing for session URL capture is a critical integration point
- **New anchor**: GitHub-only constraint — must validate repo hosting before triggering

### Human / User
- Developers may resist AI-generated plans if quality is inconsistent
- Task creators benefit massively — their vague tickets get instant, structured feedback
- Onboarding new developers becomes easier — every task comes with context
- There's a trust-building period: early quality determines adoption
- Developers who can steer AI implementation (not just read docs) get more value
- Staged plans give developers granular control — approve/reject individual stages
- Soft warming via docs means developers don't need server access for 80% of use cases
- **New anchor**: Quality of first 10 analyses determines team adoption
- **New anchor**: Staged planning increases developer trust by giving them stage-level control

### Strategic / Long-term
- This creates an institutional knowledge base — every task has documented analysis
- Over time, the system learns codebase patterns implicitly through repeated analysis
- Could expand beyond Jira to GitHub Issues, Linear, Shortcut, etc.
- The dashboard becomes a management tool for engineering velocity
- Generic analysis documents become a persistent, evolving understanding of the codebase — value beyond any single task
- The system naturally evolves toward full AI implementation with human oversight
- **New anchor**: Task analysis archive becomes organizational knowledge asset
- **New anchor**: Generic analysis docs are a codebase knowledge asset independent of the automation system

### Risk / Failure
- Wrong analysis is worse than no analysis — developers may trust bad plans
- Claude Code session failures mid-analysis leave orphaned branches and incomplete Jira comments
- Rate limiting during peak sprint periods could block the pipeline
- Security: Claude Code has full codebase access on a shared server
- AI implementation without careful human review could introduce bugs at scale
- Complexity detection misjudgment: simple task gets over-documented, complex task gets under-planned
- Soft warming via docs may miss nuances that only exist in session conversation history
- **New anchor**: Need graceful failure handling — incomplete analysis must be clearly marked
- **New anchor**: Security model for multi-tenant (multiple repos/teams) is undefined
- **New anchor**: AI implementation must require explicit developer approval before merge

### Resource / Feasibility
- MVP is dramatically simpler now: Jira webhook listener + `claude --remote` calls + Jira API posting
- No server infrastructure to manage — Anthropic handles VMs, cloning, environment
- Claude Code account costs (Pro/Max/Team/Enterprise plans) replace server hosting costs
- Rate limits are shared across all Claude usage — parallel tasks consume proportionally more
- Building the dashboard is a separate significant effort
- Generic analysis reuse significantly reduces token costs for subsequent tasks
- Staged planning costs more tokens but only triggers for complex tasks
- **New anchor**: MVP scope should be minimal — one repo, one team, no dashboard
- **New anchor**: Generic/task-based analysis separation is the key cost optimization
- **New anchor**: Infrastructure cost shifts from servers to Claude plan subscription — simpler but less controllable

### Ethical / Systemic
- Developers might feel surveilled if every push triggers AI review
- The system could create pressure to follow AI plans even when developer disagrees
- Task creators might stop thinking carefully about requirements if "AI will figure it out"
- If AI implements too much, developer skills may atrophy over time
- **New anchor**: System must be positioned as assistant, not authority
- **New anchor**: AI implementation should augment developer capability, not replace it

---

### Sense Version 3 (SV3 — Multi-Perspective Understanding)

The project is technically feasible as an MVP and dramatically simpler than originally conceived. Claude Code for web eliminates self-hosted infrastructure — the technical core is now: Jira webhook → `claude --remote` → session URL to Jira → developer teleports or clicks link. Three architectural decisions remain critical: (1) separating generic and task-based analysis to reduce token cost and enable reuse, (2) teleport as the context transfer mechanism (full session + branch, not just docs), and (3) adapting planning depth to task complexity. The hard parts shift from infrastructure to integration: ensuring analysis quality for developer trust, parsing `claude --remote` output for session URLs, handling rate limits across parallel tasks, and managing the GitHub-only constraint. The generic analysis docs (via CLAUDE.md and devdocs) may become the most valuable artifact — a living, evolving understanding of the codebase that outlives any single task.

---

## Phase 3 — Ambiguity Collapse

### Ambiguity 1: What triggers analysis — task creation or task state change?

**Resolution:** Task creation triggers initial analysis. Task state changes (e.g., developer pushes code) trigger review loops.

**What is now fixed?** Two distinct trigger types with different behaviors.

**What is no longer allowed?** Analyzing every Jira field edit or comment update.

**What now depends on this choice?** Webhook configuration, event filtering logic, session lifecycle management.

**What changed in the conceptual model?** The system has two modes: reactive (task created → analyze) and monitoring (code pushed → review).

---

### Ambiguity 2: What does "unclear task" mean technically?

**Resolution:** A task is unclear if Claude Code cannot produce a concrete implementation plan without making assumptions. The clarity check is Claude Code's own judgment, guided by a prompt template that defines minimum requirements (what, why, acceptance criteria).

**What is now fixed?** Clarity is evaluated by Claude Code against a defined checklist, not a separate service.

**What is no longer allowed?** Binary pass/fail from keyword matching or rule-based systems.

**What now depends on this choice?** Quality of the clarity prompt template. It must be refined over time based on false positives/negatives.

**What changed in the conceptual model?** There's no separate "clarity analyzer" — Claude Code itself decides, simplifying architecture.

---

### Ambiguity 3: Who owns the generated docs — AI or developer?

**Resolution:** AI generates v1. Developer owns from that point forward. Developer can edit, delete, rewrite. AI's review loop compares against latest version, not original.

**What is now fixed?** Ownership transfers at branch creation. Developer has full authority.

**What is no longer allowed?** AI overwriting developer edits. AI treating its docs as canonical after handoff.

**What now depends on this choice?** Review loop must diff against current branch state, not original AI output.

**What changed in the conceptual model?** The docs are a starting point, not a contract. Developer sovereignty is preserved.

---

### Ambiguity 4: How does the push-triggered review loop work technically?

**Resolution:** A git webhook on the task branch triggers the Claude Agent Manager. It resumes the existing session (or starts new one with docs as context) and runs a diff-based review against the implementation plan.

**What is now fixed?** Review is git-webhook-driven, not polling. Same session preferred, new session as fallback.

**What is no longer allowed?** Continuous monitoring or periodic polling of branches.

**What now depends on this choice?** Git webhook infrastructure. Session persistence/timeout policy.

**What changed in the conceptual model?** Two webhook sources: Jira (task events) and Git (push events). Both funnel into Claude Agent Manager.

---

### Ambiguity 5: What happens when Claude Code session fails or times out?

**Resolution:** Failed sessions are marked in Jira with a clear "Analysis Failed" comment. Partial outputs are still committed to the branch if any exist. System can retry once automatically, then requires manual trigger.

**What is now fixed?** Failure is visible, not silent. One automatic retry. Manual intervention after that.

**What is no longer allowed?** Silent failures. Infinite retry loops. Incomplete analysis presented as complete.

**What now depends on this choice?** Error handling in Agent Manager. Jira comment templates for failure states.

**What changed in the conceptual model?** The system has three end states per task: success, partial (with warning), and failed.

---

### Ambiguity 6: Single-tenant or multi-tenant?

**Resolution:** Start single-tenant (one repo, one Jira project, one server). Multi-tenant is a future concern.

**What is now fixed?** MVP scope. No repo routing, no project isolation, no multi-team access control.

**What is no longer allowed?** Building for multiple repos or teams in v1.

**What now depends on this choice?** Server setup is simple (one codebase clone). No need for repo registry or project mapping.

**What changed in the conceptual model?** Dramatically reduced scope. Single pipeline, single target.

---

### Ambiguity 7: Does the system only analyze or also implement?

**Resolution:** The system can do both. Analysis is the default. Implementation is triggered only by explicit developer approval. The same Claude Code session that analyzed can continue into implementation, or the developer can take the docs and implement locally (with or without AI assistance).

**What is now fixed?** Three modes: analysis-only (default), AI-assisted implementation (developer steers), developer-only implementation (docs as guide).

**What is no longer allowed?** Automatic implementation without human approval. AI merging code without developer review.

**What now depends on this choice?** Approval mechanism in Jira or session. Branch protection rules. Implementation prompt templates.

**What changed in the conceptual model?** The system's scope extends beyond planning into execution, but always gated by human approval. The developer-AI relationship is collaborative, not autonomous.

---

### Ambiguity 8: How is context transferred from server session to developer's local session?

**Resolution:** Through deep generic analysis documents committed to the branch. The server performs thorough archaeology (traces, architecture analysis, module maps, concept inventories) and commits these as devdocs. Developer's local session reads these docs for "soft warming" — gaining ~80% of the server's understanding without session portability.

**What is now fixed?** Documents are the transfer mechanism. No session forking required.

**What is no longer allowed?** Expecting developer's local session to have full server context. Skipping deep generic analysis docs to save tokens.

**What now depends on this choice?** Quality and thoroughness of generic analysis docs. They must be comprehensive because they ARE the transfer mechanism.

**What changed in the conceptual model?** The devdocs serve a dual purpose: (1) guiding implementation and (2) transferring codebase understanding to local sessions. This elevates doc quality from "nice to have" to "critical infrastructure."

---

### Ambiguity 9: How does the system determine task complexity for planning depth?

**Resolution:** Two mechanisms. Automatic: Claude Code evaluates complexity during analysis based on files affected, modules touched, cross-cutting concerns, estimated scope. Manual override: special keywords in Jira task (`[staged]`, `[complex]`), custom Jira fields, or labels (e.g., `vdd-staged`).

**What is now fixed?** Complexity detection is hybrid — AI judges by default, human overrides when needed.

**What is no longer allowed?** Treating all tasks identically. Always using staged planning (over-documentation). Always using flat planning (under-documentation).

**What now depends on this choice?** Complexity evaluation prompt template. Jira field/label conventions. Two doc generation templates (flat and staged).

**What changed in the conceptual model?** The system has adaptive output — it's not one-size-fits-all. This reduces noise for simple tasks while providing depth for complex ones.

---

### Ambiguity 10: Self-hosted server or managed infrastructure?

**Resolution:** Claude Code for web. Anthropic manages the VMs, cloning, environment setup. The system triggers sessions via `claude --remote "prompt"` and tracks them via session URLs. No self-hosted server infrastructure.

**What is now fixed?** Infrastructure is Anthropic's responsibility. Our system is a lightweight orchestrator (Jira webhooks + `claude --remote` calls + Jira API posting).

**What is no longer allowed?** Managing servers, cloning repos, installing Claude Code, handling git credentials on our infrastructure. Building custom containerization or VM management.

**What now depends on this choice?** GitHub-only constraint (Claude Code for web only supports GitHub). Dependency on Anthropic's availability and rate limits. Account plan requirements (Pro/Max/Team/Enterprise).

**What changed in the conceptual model?** The Claude Agent Manager is no longer a "manager" — it's a thin trigger layer. The architecture collapses from three heavyweight components to: Jira Task Manager (webhook listener + API poster) + trigger logic (`claude --remote`) + Dashboard. The complexity shifts from infrastructure to integration and prompt engineering.

---

### Ambiguity 11: How do developers access the analysis session?

**Resolution:** Three methods, all enabled by Claude Code for web:
1. **Session link in Jira** (primary): System posts the session URL as a Jira comment. Developer clicks through to the full conversation in the Claude web UI.
2. **Teleport to local terminal**: Developer runs `claude --teleport <session-id>` to pull the full session (conversation + branch) into their local Claude Code CLI.
3. **Dashboard** (observe): Read-only view of all active and completed sessions.

**What is now fixed?** No SSH access needed. No web terminal. Session access is through Claude's native features.

**What is no longer allowed?** Building custom session access infrastructure. SSH tunneling to server sessions. Custom web terminals.

**What now depends on this choice?** Reliable session URL capture from `claude --remote` output. Jira comment templates with session links. Developer familiarity with teleport workflow.

**What changed in the conceptual model?** Developer access is no longer a custom feature we build — it's a native capability of Claude Code for web. We just need to surface the right URLs in the right places.

---

### Sense Version 4 (SV4 — Clarified Understanding)

The system has two trigger sources (Jira webhooks, Git webhooks) feeding into a lightweight orchestrator that calls `claude --remote`. Claude Code for web handles all infrastructure — VMs, cloning, environment. Claude Code itself handles clarity judgment. Docs are handed off to developers who own them completely. Failures are visible and limited to one retry. MVP is single-tenant, GitHub-only.

Five structural commitments: (1) the system can implement, not just plan, but always requires human approval; (2) context transfers via teleport (full session + branch), with docs as secondary mechanism; (3) planning depth adapts to task complexity via automatic detection with manual override; (4) no self-hosted infrastructure — Claude Code for web handles everything; (5) developer access via session links and teleport, not custom tooling.

Two analysis tiers are now explicit: generic (codebase-level, reusable) and task-based (task-specific, per task).

---

## Phase 4 — Degrees-of-Freedom Reduction

### Fixed Variables
- **AI Engine**: Claude Code via Claude Code for web (not self-hosted, not custom LLM integration)
- **Infrastructure**: Anthropic-managed VMs (not self-hosted servers)
- **Session Trigger**: `claude --remote "prompt"` (programmatic, headless)
- **Task Source**: Jira (not GitHub Issues, Linear, etc.)
- **Code Hosting**: GitHub only (Claude Code for web constraint)
- **Delivery Mechanism**: Git branches with markdown docs
- **Communication**: Jira comments with session links (not Slack, email, etc.)
- **Scope**: Single repo, single team
- **Trigger Model**: Event-driven (webhooks), not polling
- **Failure Policy**: Visible failure, one retry, then manual
- **Context Transfer**: Teleport (full session + branch) as primary, docs as secondary
- **Developer Access**: Session links in Jira + teleport to local terminal
- **Analysis Tiers**: Generic (codebase, reusable) + Task-based (task-specific)
- **Complexity Detection**: Automatic with manual override via Jira keywords/labels
- **Implementation Gate**: Requires explicit developer approval

### Eliminated Options
- Self-hosted server infrastructure (Claude Code for web replaces this)
- Custom codebase analysis engine (Claude Code does this)
- Custom session management (Claude Code for web handles lifecycle)
- Custom environment/VM provisioning (Anthropic manages this)
- SSH resume for developer access (teleport replaces this)
- Real-time streaming of analysis to developers
- Multi-repo support in v1
- Dashboard in v1
- Automatic implementation without approval (AI writes code without consent)
- Multi-provider support (only Claude Code)
- Non-GitHub repositories in v1 (platform constraint)
- One-size-fits-all planning depth (adaptive instead)

### Remaining Viable Paths

**Developer Access**: Start with session links in Jira comments. Developers who want local access use teleport.

**Implementation Mode**: Start with analysis-only. Add AI-assisted implementation in v1.1 once trust is established.

**Scaling Strategy**: Start with single account. Add account pooling when hitting rate limits. No server scaling needed.

**Review Loop**: Implement after core analysis pipeline is stable. This is v1.1, not v1.0.

**Dashboard**: Build after core pipeline proves value. Could be as simple as a Jira dashboard initially.

**Generic Analysis Refresh**: Start with manual trigger. Add periodic auto-refresh later.

**Environment Config**: Start with limited network access (default allowlist). Open up per-project as needed via environment settings.

---

### Sense Version 5 (SV5 — Constrained Understanding)

**MVP is a lightweight orchestrator:**
1. Jira webhook listener that detects new tasks
2. Trigger logic that calls `claude --remote` with task context + CLAUDE.md instructions
3. Session URL capture and Jira comment posting

**MVP includes:**
- Generic analysis via CLAUDE.md (project instructions carried into every session)
- Task-based analysis per task (flat plan for simple tasks)
- Docs committed to branch by Claude Code for web
- Session link posted to Jira for developer access
- Teleport available for developers who want local access

**MVP does NOT include:**
- Staged planning for complex tasks (v1.1)
- AI-assisted implementation (v1.1)
- Push-triggered review loop (v1.1)
- Dashboard (v1.2)
- Multi-repo support (v2)
- Non-GitHub repositories (platform constraint)
- Automatic complexity detection (manual labels only in v1)

**Developer workflow in MVP:**
1. Create Jira task
2. Wait for AI comment (questions or analysis complete + session link)
3. Click session link to view analysis conversation, or teleport to local terminal
4. Pull task branch, read docs
5. Implement (with or without local AI assistance)
6. Push and create PR as normal

---

## Phase 5 — Conceptual Stabilization

### Coherent Interpretation

VDD Task Automation is a lightweight orchestrator that inserts an AI analysis and optional implementation phase between task creation and developer work. It uses Claude Code for web as the engine (triggered via `claude --remote`), Jira as the task interface, and Git branches as the delivery mechanism. No self-hosted infrastructure — Anthropic manages VMs and environments. The system performs two tiers of analysis — reusable codebase understanding (generic, via CLAUDE.md) and task-specific intelligence (task-based) — with adaptive planning depth based on task complexity. Context transfers via teleport (full session + branch) or session links posted to Jira.

### Problem Structure

```
Input: Jira task (potentially vague)
          ↓
Generic Analysis: Codebase archaeology (done once, reused)
          ↓
Task-Based Analysis: Task-specific planning (complexity-adaptive)
          ↓
Output: Docs on git branch + Jira comments
          ↓
Developer: Soft warms local session via docs
          ↓
Implementation: Developer-led or AI-assisted (with approval)
          ↓
Review Loop: Push-triggered AI review (v1.1)
```

### Action Framework

**Build order:**
1. CLAUDE.md setup (generic analysis instructions, project conventions, prompt templates)
2. Jira webhook listener (receive task events)
3. `claude --remote` trigger logic (compose prompt from task + CLAUDE.md, spawn session)
4. Session URL parser (capture session link from `claude --remote` output)
5. Jira commenter (post session link + results back to ticket)
6. Error handling (failure states, retry)
7. SessionStart hooks for environment setup (`.claude/settings.json`)
8. Complexity detection + staged planning (v1.1)
9. AI-assisted implementation mode (v1.1)
10. Push-triggered review loop (v1.1)
11. Dashboard (v1.2)

**Critical path dependencies:**
- `claude --remote` must be parseable for session URL capture
- Claude Pro/Max/Team/Enterprise plan with sufficient rate limits
- Jira API access with comment/webhook permissions
- GitHub repository (Claude Code for web constraint)
- CLAUDE.md with generic analysis instructions and prompt templates
- `.claude/settings.json` for SessionStart hooks (dependency installation)

---

### Final Sense Version (SV6 — Stabilized Model)

**VDD Task Automation is a lightweight orchestrator between Jira and GitHub codebases, powered by Claude Code for web, with adaptive intelligence depth and zero self-hosted infrastructure.**

It solves the core problem: developers waste time understanding tasks and analyzing code before they can start building. The system does this work automatically, producing structured documentation within minutes of task creation.

**Architecture**: Dramatically simplified by Claude Code for web. Jira Task Manager (webhook listener + API poster) triggers `claude --remote` calls. Dashboard Service reads status. No servers to manage — Anthropic handles VMs, cloning, environments.

**Two-tier analysis**: Generic analysis (codebase-level, via CLAUDE.md, reused across sessions) provides persistent understanding. Task-based analysis (task-specific) builds on generic context. This separation is the key cost and quality optimization.

**Adaptive planning**: Simple tasks get flat 5-doc plans. Complex tasks get staged plans with per-stage folders. Complexity is detected automatically with manual override.

**Context portability**: Solved by teleport — developers pull the full session (conversation history + branch) into their local terminal via `claude --teleport`. Session links in Jira comments provide instant web access. Docs remain useful but are no longer the only transfer mechanism.

**Implementation spectrum**: Analysis-only (default), AI-assisted implementation (developer steers), or developer-only implementation (docs as guide). Always gated by human approval.

**Developer experience**: Click session link in Jira to view analysis, or teleport to local terminal for full context. Pull task branch, implement locally, push as normal. Iterate with Claude via web UI or locally.

**MVP scope**: One GitHub repo, one team, no servers. CLAUDE.md + `claude --remote` + Jira webhook listener. No dashboard, no review loop, no staged planning.

**How this differs from SV1**: SV1 was "AI analyzes Jira tasks on a self-hosted server." SV6 is a zero-infrastructure orchestrator using Claude Code for web — `claude --remote` triggers analysis on Anthropic-managed VMs, teleport solves context transfer, session links enable developer access, CLAUDE.md carries generic analysis. Every major ambiguity has been collapsed: 11 ambiguity resolutions covering triggers, clarity judgment, doc ownership, review loops, failure handling, tenancy, implementation scope, context transfer, complexity detection, infrastructure, and developer access.
