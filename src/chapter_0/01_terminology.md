# Chapter 0: Terminology

This chapter defines key terms and concepts used throughout the Vibe-Driven Development methodology.

## Core Terms

### Vibe Coding
The practice of collaborative development with AI assistants, emphasizing natural communication and iterative refinement over rigid specifications.

### Vibe-Driven Development (VDD)
An emerging methodology that brings structure and repeatable patterns to vibe coding, providing systematic foundations and granular control throughout the development process.


### DevDocs Pattern
Living documentation that represents AI's understanding of the project, continuously updated throughout development.

### Smoke Tests Pattern
Comprehensive, verbose tests designed both for build verification and as specifications that AI can understand and implement against.

### The Butterfly Defect
Small semantic imprecisions that cascade into large architectural changes. Named after the butterfly effect, where using "modal" instead of "dialog" might shift the entire UI philosophy.

### Semantic Precision
Using exact, unambiguous terminology to prevent misinterpretation by AI.

### Anchor Pattern
The practice of continuously ensuring existing functionality still works after AI makes changes, preventing regression through regular verification.

### HILing (Human-In-the-Loop-ing)
The act of actively intervening as the human in the loop to review, correct, and steer AI output.
- HIL (verb): "Let me HIL this documentation"
- HILing (present): "I'm HILing the architecture"
- HILed (past): "I HILed the concepts to match our needs"

### AI Drift
The gradual divergence of AI's implementation from the original project vision, occurring when AI makes accumulated small decisions without human guidance.


### Fuzzy Architecture
Starting with vague architectural guidelines and allowing structure to emerge through development, rather than over-specifying upfront.


### Offload Pattern
Structuring code, documentation, and prompts to make AI's job easier and more reliable.

### Testing is Dialogue
The concept that tests serve as a communication medium with AI, teaching it requirements through examples.

### Data Dump
The initial transfer of all available project information to AI, often messy and unstructured.

### Retrofitting 
Introducing VDD methodologies to projects that were originally developed without them.


### Latent Persona
An emergent character or voice the AI adopts unintentionally, often due to biases in training data or weights. This can manifest as unexpected personality traits, communication styles, or decision-making patterns that weren't explicitly prompted.

### Prompt Perfume
Subtle, aesthetic prompt tweaks that don't change meaning but infuse a desired "scent" of tone or style into AI's responses.
- Example: "Write this function with the elegance of a haiku"

### Ghost Tokening
Phantom influence from hidden system prompts, latent weights, or unseen context that alters style or tone without user intent. These invisible influences can cause AI to behave differently than expected.


### Lo-Fi Coding (Low Fidelity)
Vague, exploratory collaboration where AI has maximum creative freedom. 
- Minimal constraints given to AI
- Broad, open-ended prompts
- AI chooses implementation details
- Example: "Build me a todo app with user authentication"
- Use for: Early exploration, proof of concepts, prototyping

### Mid-Fi Coding (Medium Fidelity)
Balanced collaboration where human sets boundaries and AI fills in details.
- Clear requirements but flexible implementation
- Human defines architecture, AI implements
- Example: "Build a todo app using React with TypeScript, PostgreSQL database, REST API with Express"
- Use for: Most production development, team projects, existing codebases

### Hi-Fi Coding (High Fidelity)
Enhanced human-in-the-loop intervention with focused vision alignment.
- Still collaborative (not dictatorial)
- More frequent HILing checkpoints
- AI follows established patterns closely
- Example: "Implement following our exact security standards with review after each major method"
- Use for: Complex features, critical security sections, when quality matters more than speed

### Progressive Fidelity
Starting with Lo-Fi for exploration, moving to Mid-Fi for implementation, and applying Hi-Fi for critical sections.
