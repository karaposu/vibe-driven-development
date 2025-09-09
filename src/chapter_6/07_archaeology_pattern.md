## The Archaeology Pattern: DevDocs for Existing Projects

Creating DevDocs for an existing codebase is archaeological work - you're excavating layers of decisions, uncovering patterns, and reconstructing the evolution story. Without understanding why code evolved certain ways, AI might simplify architecture back to already-invalidated states.

This pattern systematically extracts DevDocs from mature codebases using AI assistance.

### Step 0: Data Dump (Optional)

If your codebase is not mature enough to define project aspects very well, then start by dumping all available project information as if you are starting from scratch.

This raw material feeds the excavation process.

### Step 1: Foundation Documents

Ask AI to generate the three foundation documents:

- project_description.md
- philosophy.md
- known_requirements.md

Then have AI extract **concepts.md** listing all concepts.


### Step 2: Codebase Inspection

Direct AI to analyze each source file and create **codebase_summary.md** documenting:
- What each file/module does
- How components interact
- Data flow patterns
- Architectural decisions evident in code

This creates a current-state snapshot before any changes. 



### Step 3: Concept Mapping

We ask AI to generate **concept_mappings.md** linking each concept to its existing implementation:

For each concept, document:
- Which modules/services/classes implement it
- Coverage percentage (fully realized, partial, missing)
- Why the implementation chose this specific approach
- What alternatives were likely considered and rejected
- Edge cases the current design handles

This critical step captures the "why" behind existing architecture.



#### step 4: creating project_state.md 

and then we use this concept_mappings.md to create 

project_state.md file where project state is explained and summed up 


### Step 4: Project State Assessment
Aand then we use concept_mappings.md to synthesize findings into **project_state.md**:
- Missing concept implementations
- Integration points needing attention
- Overall architecture maturity
- Technical debt locations
- Recommended next steps

### Why This Works

Manual archaeology would take weeks. AI can traverse entire codebases in minutes, recognizing patterns humans might miss. The key is asking the right questions to extract not just what exists, but why it exists that way.

### Common Discoveries

The archaeology pattern often reveals:
- Undocumented workarounds for specific edge cases
- Implicit architectural decisions
- Hidden dependencies between modules
- Performance optimizations that look like complexity
- Security measures that seem redundant

