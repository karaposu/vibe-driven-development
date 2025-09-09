## Concept Documents

Identifying concepts is critical during development. Poor concept understanding evolves into flawed architecture and toxic development cycles.

Concepts are meta-abstractions encompassing any development aspect - from essential requirements to payment verification modules to unique architectural patterns. Concept documentation articulates what needs building at a high level, enabling truly modular development practices.

### concepts.md

This document extracts and lists all key technical concepts from the foundation documentation (project_description.md, philosophy.md, known_requirements.md). We instruct AI to focus solely on essential technical concepts to prevent bloat.

### concepts_clarifications folder

For each concept in concepts.md, we have AI generate detailed clarification documents. This folder typically contains around 10 documents, each thoroughly explaining a single concept. As humans in the loop, reading these reveals exactly how AI interprets our concepts.

Each clarification document systematically addresses:
- What the concept is and why it matters
- How it benefits the overall project
- How it constrains the overall project  
- Required input information
- Core processes involved
- Output information or relay points
- Expected positive outcomes when realized
- Potential negative outcomes to avoid

This multi-perspective analysis ensures nothing gets overlooked.

### simplified_concepts.md

New development typically begins with prototyping, then iterative enhancements transform prototypes into MVPs. Reading all full-scope concepts in concepts.md can feel overwhelming - for both humans and AI. Our responsibility as humans in the loop is orchestrating AI's work through modular, gradual, controllable increments.

AI lacks this self-regulation. While you can request simplified prototype implementations, AI's simplification intuition remains poorly calibrated and requires human oversight.

This is precisely why we have AI create this documentation simplified_concepts.md so we can HIL it effectively.

When creating simplified concepts, we instruct AI to:
- Preserve essential architecture - never oversimplify to the point where the foundation cannot support the full concept
- For multi-faceted concepts - avoid binarizing (reducing to just one or two options), instead reduce the number of supported subconcepts by prioritizing the most important ones

### simplified_concepts folder

Mirrors the concepts_clarifications folder structure. We have AI generate clarification documents for each simplified concept, allowing us to understand AI's interpretation of the streamlined versions.

Each document addresses the same systematic questions:
- What the concept is and why it matters
- How it benefits the overall project
- How it constrains the overall project
- Required input information
- Core processes involved
- Output information or relay points
- Expected positive outcomes when realized
- Potential negative outcomes to avoid

### The Dual-Concept Strategy

Having both simplified_concepts.md and concepts.md in the codebase is essential. These paired documents define the expansion trajectory for AI. When introducing intermediate concepts, AI can position them appropriately within the current-to-future scope continuum.