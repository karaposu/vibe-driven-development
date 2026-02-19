# Structural Sensemaking: VDD Task Automation

---

## Initial Sense Version (SV1 — Baseline Understanding)

A system that sits between Jira and a codebase, using Claude Code to automatically analyze tasks, generate documentation, and create implementation plans before developers start coding. It eliminates the ambiguity gap between task creation and implementation.

---

## Phase 1 — Cognitive Anchor Extraction

### Constraints
- Claude Code runs on a server, not on developer machines
- One Claude Code session per task (stateless per task)
- Jira is the single source of truth for task management
- Developers work locally on their own machines
- Claude Code accounts have rate limits and token quotas
- Session sharing capabilities in Claude Code are uncertain
- Server must have up-to-date codebase at all times
- Claude Code sessions are not portable across machines — context lives on the server
- Token cost scales with codebase size and task complexity

### Key Insights
- The system doesn't replace developers — it front-loads the thinking phase
- Documentation (not code) is the primary output of the automation
- The push-triggered review loop creates a continuous AI feedback cycle beyond initial analysis
- The real bottleneck in development is understanding, not typing — this targets understanding directly
- Git branches serve as both delivery mechanism and collaboration interface
- This is VDD patterns (Archaeology, DevDocs, Probe Tests) automated into a pipeline
- AI can also implement, not just analyze — the boundary between planning and execution is fluid
- Codebase understanding (warm) and task analysis (hot) are two separable concerns with different lifespans
- Deep analysis documents can serve as a compressed context transfer mechanism between server and local sessions
- Task complexity should determine planning depth — not all tasks need the same treatment

### Structural Points
- **Three core components**: Jira Task Manager + Claude Agent Manager + Dashboard Service
- **Three phases of value**: Pre-implementation (analysis/docs) + During-implementation (review loop) + Implementation itself (AI codes)
- **Three interfaces**: Jira comments, git branches, Claude Code sessions
- **Two output modes (MVP)**: Flat plan (5 docs) for simple tasks, staged plan (per-stage folders) for complex tasks
- **Two output modes (Full)**: Doc output mode (flat/staged planning docs) + Code alter mode (codebase edits + implementation success report)
- **Two analysis tiers**: Warm (codebase-level, reusable) + Hot (task-specific, per task)
- **Three access methods**: Git branch (primary), SSH resume, Dashboard (observe). Remote sessions as future option if Claude Code supports it.
- **Context transfer via docs**: Deep warm analysis committed as devdocs enables soft warming of local sessions

### Foundational Principles
- AI analyzes before humans implement
- Documentation drives implementation (VDD core principle)
- Developers remain the decision makers — AI proposes, human disposes
- Everything stays trackable within existing tools (Jira, Git)
- The system should reduce developer cognitive load, not add to it
- Expensive analysis (codebase understanding) should be done once and reused
- Planning granularity should match task complexity

### Meaning-Nodes
- **Ambiguity elimination**: AI catches vagueness before it becomes wasted effort
- **Pre-implementation intelligence**: Knowledge about the task is generated before any code
- **Continuous feedback**: Not a one-shot analysis but an ongoing loop
- **Developer sovereignty**: Developers choose how to interact and can steer AI implementation
- **Context portability**: The challenge of moving understanding from server to developer without losing fidelity
- **Adaptive complexity**: The system adapts its output depth to match the task's demands

---

### Sense Version 2 (SV2 — Anchor-Informed Understanding)

This is not just "AI reads Jira tasks." It is a multi-phase system that: (1) performs reusable codebase archaeology (warm analysis), (2) generates task-specific intelligence (hot analysis) with complexity-appropriate planning depth, (3) monitors developer progress through a push-triggered review loop, and (4) can participate in implementation itself. The system operates through three interfaces (Jira, Git, Claude sessions) and solves the context transfer problem by committing deep analysis as devdocs that enable soft warming of developer-local sessions. Planning depth adapts — simple tasks get flat plans, complex tasks get staged plans with per-stage documentation.

---

## Phase 2 — Perspective Checking

### Technical / Logical
- Claude Code's `--resume` and session management are the critical technical dependency
- Webhook reliability (Jira → server) is a single point of failure
- Git branch management at scale needs automation (cleanup, naming conventions, conflicts)
- Codebase sync on server must be near real-time to avoid stale analysis
- Token consumption per task is unpredictable — large codebases may exhaust context
- Warm analysis can be cached and reused, dramatically reducing per-task token cost
- Complexity detection needs heuristics (files affected, modules touched, cross-cutting concerns)
- **New anchor**: Need a queue/retry system for webhook failures
- **New anchor**: Warm analysis caching strategy is a critical optimization
- **New anchor**: Complexity detection must have both automatic and manual override paths

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
- Warm analysis documents become a persistent, evolving understanding of the codebase — value beyond any single task
- The system naturally evolves toward full AI implementation with human oversight
- **New anchor**: Task analysis archive becomes organizational knowledge asset
- **New anchor**: Warm analysis docs are a codebase knowledge asset independent of the automation system

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
- MVP is achievable: webhook listener + session spawner + Jira API integration
- Claude Code accounts cost money — per-task token usage needs budgeting
- Server costs scale with concurrent tasks
- Building the dashboard is a separate significant effort
- Warm analysis reuse significantly reduces token costs for subsequent tasks
- Staged planning costs more tokens but only triggers for complex tasks
- **New anchor**: MVP scope should be minimal — one repo, one team, no dashboard
- **New anchor**: Warm/hot analysis separation is the key cost optimization

### Ethical / Systemic
- Developers might feel surveilled if every push triggers AI review
- The system could create pressure to follow AI plans even when developer disagrees
- Task creators might stop thinking carefully about requirements if "AI will figure it out"
- If AI implements too much, developer skills may atrophy over time
- **New anchor**: System must be positioned as assistant, not authority
- **New anchor**: AI implementation should augment developer capability, not replace it

---

### Sense Version 3 (SV3 — Multi-Perspective Understanding)

The project is technically feasible as an MVP but has significant sociotechnical and architectural dimensions. The technical core (webhook → Claude session → git branch → Jira comment) is straightforward. Three architectural decisions emerged as critical: (1) separating warm and hot analysis to reduce token cost and enable reuse, (2) using docs as the context transfer mechanism between server and local sessions (solving portability without session forking), and (3) adapting planning depth to task complexity. The hard parts remain: ensuring analysis quality for developer trust, handling failures gracefully, managing human dynamics, and finding the right boundary between AI analysis and AI implementation. The warm analysis docs may become the most valuable artifact — a living, evolving understanding of the codebase that outlives any single task.

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

**Resolution:** Through deep warm analysis documents committed to the branch. The server performs thorough archaeology (traces, architecture analysis, module maps, concept inventories) and commits these as devdocs. Developer's local session reads these docs for "soft warming" — gaining ~80% of the server's understanding without session portability.

**What is now fixed?** Documents are the transfer mechanism. No session forking required.

**What is no longer allowed?** Expecting developer's local session to have full server context. Skipping deep warm analysis docs to save tokens.

**What now depends on this choice?** Quality and thoroughness of warm analysis docs. They must be comprehensive because they ARE the transfer mechanism.

**What changed in the conceptual model?** The devdocs serve a dual purpose: (1) guiding implementation and (2) transferring codebase understanding to local sessions. This elevates doc quality from "nice to have" to "critical infrastructure."

---

### Ambiguity 9: How does the system determine task complexity for planning depth?

**Resolution:** Two mechanisms. Automatic: Claude Code evaluates complexity during analysis based on files affected, modules touched, cross-cutting concerns, estimated scope. Manual override: special keywords in Jira task (`[staged]`, `[complex]`), custom Jira fields, or labels (e.g., `vdd-staged`).

**What is now fixed?** Complexity detection is hybrid — AI judges by default, human overrides when needed.

**What is no longer allowed?** Treating all tasks identically. Always using staged planning (over-documentation). Always using flat planning (under-documentation).

**What now depends on this choice?** Complexity evaluation prompt template. Jira field/label conventions. Two doc generation templates (flat and staged).

**What changed in the conceptual model?** The system has adaptive output — it's not one-size-fits-all. This reduces noise for simple tasks while providing depth for complex ones.

---

### Sense Version 4 (SV4 — Clarified Understanding)

The system has two trigger sources (Jira webhooks, Git webhooks) feeding into two components (Jira Task Manager, Claude Agent Manager). Claude Code itself handles clarity judgment. Docs are handed off to developers who own them completely. Failures are visible and limited to one retry. MVP is single-tenant.

Three new structural commitments: (1) the system can implement, not just plan, but always requires human approval; (2) context transfers from server to local via deep warm analysis docs, making doc quality critical infrastructure; (3) planning depth adapts to task complexity via automatic detection with manual override.

Two analysis tiers are now explicit: warm (codebase-level, reusable) and hot (task-specific, per task).

---

## Phase 4 — Degrees-of-Freedom Reduction

### Fixed Variables
- **AI Engine**: Claude Code (not custom LLM integration)
- **Task Source**: Jira (not GitHub Issues, Linear, etc.)
- **Delivery Mechanism**: Git branches with markdown docs
- **Communication**: Jira comments (not Slack, email, etc.)
- **Scope**: Single repo, single team
- **Trigger Model**: Event-driven (webhooks), not polling
- **Failure Policy**: Visible failure, one retry, then manual
- **Context Transfer**: Deep warm analysis docs committed to branch (not session forking)
- **Analysis Tiers**: Warm (codebase, reusable) + Hot (task-specific)
- **Complexity Detection**: Automatic with manual override via Jira keywords/labels
- **Implementation Gate**: Requires explicit developer approval

### Eliminated Options
- Custom codebase analysis engine (Claude Code does this)
- Real-time streaming of analysis to developers
- Multi-repo support in v1
- Dashboard in v1
- Automatic implementation without approval (AI writes code without consent)
- Multi-provider support (only Claude Code)
- Session forking as context transfer (not feasible yet)
- One-size-fits-all planning depth (adaptive instead)

### Remaining Viable Paths

**Developer Access**: Start with docs on branch + soft warming. Add SSH resume when needed.

**Implementation Mode**: Start with analysis-only. Add AI-assisted implementation in v1.1 once trust is established.

**Scaling Strategy**: Start with single server, single account. Add account pooling when hitting limits.

**Review Loop**: Implement after core analysis pipeline is stable. This is v1.1, not v1.0.

**Dashboard**: Build after core pipeline proves value. Could be as simple as a Jira dashboard initially.

**Warm Analysis Refresh**: Start with manual trigger. Add periodic auto-refresh later.

---

### Sense Version 5 (SV5 — Constrained Understanding)

**MVP is a three-piece system:**
1. Jira webhook listener that detects new tasks
2. Claude Agent Manager that spawns sessions, runs analysis, captures outputs
3. Jira commenter that posts results back to tickets

**MVP includes:**
- Warm analysis (run once per codebase setup)
- Hot analysis per task (flat plan for simple tasks)
- Deep warm analysis docs committed to branch
- Session ID posted to Jira for SSH resume

**MVP does NOT include:**
- Staged planning for complex tasks (v1.1)
- AI-assisted implementation (v1.1)
- Push-triggered review loop (v1.1)
- Dashboard (v1.2)
- Multi-repo support (v2)
- Session sharing (when Claude Code supports it)
- Automatic complexity detection (manual labels only in v1)

**Developer workflow in MVP:**
1. Create Jira task
2. Wait for AI comment (questions or analysis complete)
3. Pull task branch, read docs (including warm analysis)
4. Start local Claude Code session — it reads devdocs for soft warming
5. Implement (with or without local AI assistance)
6. Push and create PR as normal

---

## Phase 5 — Conceptual Stabilization

### Coherent Interpretation

VDD Task Automation is an event-driven pipeline that inserts an AI analysis and optional implementation phase between task creation and developer work. It uses Claude Code as the engine, Jira as the task interface, and Git branches as the delivery mechanism. The system performs two tiers of analysis — reusable codebase understanding (warm) and task-specific intelligence (hot) — with adaptive planning depth based on task complexity. Deep warm analysis docs serve as both implementation guides and context transfer mechanism for developer-local sessions.

### Problem Structure

```
Input: Jira task (potentially vague)
          ↓
Warm Analysis: Codebase archaeology (done once, reused)
          ↓
Hot Analysis: Task-specific planning (complexity-adaptive)
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
1. Warm analysis pipeline (run archaeology, commit devdocs)
2. Jira webhook listener (receive task events)
3. Claude Agent Manager (spawn sessions with warm context + task)
4. Output collector (capture docs, commit to branch)
5. Jira commenter (post results back)
6. Error handling (failure states, retry)
7. Complexity detection + staged planning (v1.1)
8. AI-assisted implementation mode (v1.1)
9. Push-triggered review loop (v1.1)
10. Dashboard (v1.2)

**Critical path dependencies:**
- Claude Code CLI must support headless session spawning on server
- Jira API access with comment/webhook permissions
- Git credentials for automated branch creation and push
- Prompt templates for: clarity check, warm analysis, hot analysis, flat plan, staged plan
- Deep warm analysis docs must be thorough (they are the context transfer mechanism)

---

### Final Sense Version (SV6 — Stabilized Model)

**VDD Task Automation is an event-driven bridge between Jira and codebases, powered by Claude Code, with adaptive intelligence depth.**

It solves the core problem: developers waste time understanding tasks and analyzing code before they can start building. The system does this work automatically, producing structured documentation within minutes of task creation.

**Architecture**: Three components (Jira Task Manager + Claude Agent Manager + Dashboard Service) connected by webhooks. Claude Code is the engine. Dashboard reads from both other components.

**Two-tier analysis**: Warm analysis (codebase-level, done once, reused) provides persistent understanding. Hot analysis (task-specific) builds on warm context. This separation is the key cost and quality optimization.

**Adaptive planning**: Simple tasks get flat 5-doc plans. Complex tasks get staged plans with per-stage folders. Complexity is detected automatically with manual override.

**Context portability**: Deep warm analysis docs committed to branches serve as compressed context transfer. Developer's local session reads these for soft warming (~80% of server understanding without session forking).

**Implementation spectrum**: Analysis-only (default), AI-assisted implementation (developer steers), or developer-only implementation (docs as guide). Always gated by human approval.

**Developer experience**: Read docs on branch, soft warm local session via devdocs, implement locally, push as normal. Optionally resume server session for follow-up.

**MVP scope**: One repo, one team, one server. Warm analysis + flat planning + Jira integration. No dashboard, no review loop, no staged planning.

**How this differs from SV1**: SV1 was "AI analyzes Jira tasks." SV6 is a precisely scoped, event-driven, two-tier analysis system with adaptive planning depth, a solved context transfer problem (docs as transfer mechanism), an implementation spectrum from planning to AI-assisted coding, defined failure modes, clear ownership boundaries, and a phased build order. Every major ambiguity has been collapsed into a concrete structural commitment.
