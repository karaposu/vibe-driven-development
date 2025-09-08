

## For Existing Projects

### Archaeology Phase

```
Analyze this existing codebase and create DevDocs:

Phase 1 - Surface Scan:
1. Map directory structure
2. Identify technologies from package files
3. Find all existing documentation
4. Check recent git activity
5. Create devdocs/initial_observations.md

Phase 2 - Deep Dive:
1. Trace main entry points
2. Follow 3-5 critical user flows
3. Map data models and schemas
4. Document actual API endpoints
5. Update devdocs/project_description.md with reality
6. Create devdocs/discovered_architecture.md

Phase 3 - Pattern Recognition:
1. What patterns are actually used?
2. What conventions exist?
3. How are errors handled?
4. What's the testing approach?
5. Create devdocs/actual_patterns.md

Phase 4 - Technical Debt:
1. Find TODO/FIXME/HACK comments
2. Identify workarounds
3. Locate fragile code
4. Create devdocs/technical_debt.md
5. Create devdocs/fragile_areas.md

Phase 5 - Extract Concepts:
Read the implementation and extract what concepts are actually implemented.
Create the same concept documentation structure as new projects,
but based on what EXISTS, not what was planned.
```

### Migration Planning

```
With DevDocs established for the existing project:

1. Compare current state to desired state
2. Create devdocs/migration_plan.md with:
   - What needs to change
   - What order to change it
   - What risks exist
   - What can't change (constraints)

3. Create devdocs/refactoring_opportunities.md
4. Create devdocs/quick_wins.md for easy improvements
```

## Quick Start Checklist

For any project using DevDocs pattern:

```
Please set up DevDocs pattern:

- [ ] Create devdocs/ folder structure
- [ ] Write three foundation documents
- [ ] Extract concepts from requirements
- [ ] Create concept clarifications
- [ ] Simplify concepts for MVP
- [ ] Create simplified clarifications
- [ ] Design architecture
- [ ] Define modules
- [ ] Document each module
- [ ] Set up issues tracking
- [ ] Create support documents
- [ ] Human review checkpoint

Start with foundation documents and proceed systematically.
Each phase builds on the previous one.
```

## Continuous DevDocs Maintenance

```
As development proceeds, continuously update DevDocs:

After each work session:
1. Update relevant module docs if interfaces changed
2. Log any architectural decisions in decisions.md
3. Document any issues in issues/
4. Update limitations.md if new constraints discovered
5. Add to notes.md any observations

Weekly:
1. Review if simplified concepts need expansion
2. Check if new modules are needed
3. Update architecture.md with any evolution
4. Move relevant items from notes.md to proper docs

This maintains DevDocs as living documentation.
```

## The Complete DevDocs Prompt

For maximum effectiveness, combine all phases:

```
I need to establish comprehensive DevDocs pattern for this project.

[Include all phase prompts from above]

Proceed systematically through each phase, creating all specified documentation.
After each phase, pause for my review before continuing.
Maintain consistency across all documents.
Ensure documents reference each other appropriately.
Keep language clear and specific.

The goal is a complete knowledge base that allows any AI assistant
to understand and contribute to this project effectively.
```

---

This ready_prompt.md provides comprehensive, copy-paste ready prompts for establishing the full DevDocs pattern, incorporating all concepts from Chapter 6 including foundation documents, concepts, simplification, architecture, modules, issues tracking, and continuous maintenance.









### Phase 9: Interface Discussion for Selected Module 

"""
Task: Based on selected module, create a comprehensive interface design document (interface_discussion.md) that explores API requirements and
  possibilities.

  Required Analysis:

  1. List All known Interface Capabilities
    - What operations must the interface support?
    - What configuration options are needed?
    - What input/output formats are required?
    - What modes of operation should exist?
  2. Review Current Implementation
    - Analyze existing code structure
    - Identify limitations and gaps
    - Note what works well
  3. Explore Design Patterns
    - Present multiple interface approaches (builder, functional, config-based, etc.)
    - Show concrete code examples
    - Compare pros/cons of each
  4. Propose Recommended Interface
    - Design that balances simplicity and power
    - Usage examples from basic to advanced
    - Method signatures and chaining options
    - Error handling approach
  5. Document Open Questions
    - Key decisions needing resolution
    - Trade-offs to consider
    - Naming conventions
    - Default behaviors

  Goal: Produce a thorough discussion document that clarifies interface requirements and provides foundation for making implementation decisions. Focus on understanding what's possible and what makes sense for users.

  Format: Markdown document with code examples, structured sections, and clear reasoning for recommendations.

"""