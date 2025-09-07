# Vibe Coding Terminology

This chapter defines key terms and concepts used throughout the Vibe Coding methodology. Understanding these terms is essential for effective AI-assisted development.

## Fidelity Levels in Vibe Coding

The concept of fidelity, borrowed from design, describes how much control and precision you maintain when working with AI.

### Lo-Fi Coding (Low Fidelity)
**Definition**: Vague, exploratory collaboration where AI has maximum creative freedom.

**Characteristics**:
- Minimal constraints given to AI
- Broad, open-ended prompts
- AI chooses implementation details
- Human provides general direction only
- Accepts AI's architectural decisions

**Example**:
```
"Build me a todo app with user authentication"
```

**When to Use**:
- Early exploration
- Proof of concepts
- Learning new technologies
- When you trust AI's patterns

**Benefits**:
- Fast initial progress
- Discover patterns you hadn't considered
- Minimal human effort
- Good for prototyping

**Risks**:
- May not match your vision
- Potential for AI drift
- Harder to maintain consistency
- Technical debt accumulation

### Mid-Fi Coding (Medium Fidelity)
**Definition**: Balanced collaboration where human sets boundaries and AI fills in details.

**Characteristics**:
- Clear requirements but flexible implementation
- Human defines architecture, AI implements
- Specified patterns and conventions
- Regular checkpoint reviews

**Example**:
```
"Build a todo app using React with TypeScript, PostgreSQL database, 
REST API with Express. Use repository pattern for data access.
Follow our existing auth module patterns."
```

**When to Use**:
- Most production development
- Team projects
- When you have preferences but want AI efficiency
- Building on existing codebases

**Benefits**:
- Balance of control and speed
- Maintains architectural consistency
- Leverages AI's implementation skills
- Sustainable development pace

**Risks**:
- Requires clear communication
- Need to review AI's interpretations
- Some back-and-forth iteration

### Hi-Fi Coding (High Fidelity)
**Definition**: Vibe coding with enhanced human-in-the-loop intervention and focused vision alignment.

**Characteristics**:
- Still collaborative (not dictatorial)
- More frequent HILing checkpoints
- Clearer vision communication
- AI follows established patterns closely
- Human reviews and adjusts more actively

**Example**:
```
"Let's implement UserAuthentication following our established patterns:
- Use our standard BCrypt configuration
- Follow our JWT token patterns from the auth module
- Integrate with our existing Redis session approach
- Check the implementation aligns with our security standards
- I'll review after each major method to ensure vision alignment"
```

**When to Use**:
- Complex features requiring consistent vision
- When building on established patterns
- Team projects needing alignment
- Features with specific business requirements
- When quality matters more than speed

**Benefits**:
- Maintains vision coherence
- Leverages AI while keeping control
- Higher quality outcomes
- Better pattern consistency

**Risks**:
- Requires more human attention
- More HILing overhead
- Can slow down exploration
- May constrain AI's creative solutions

## Core Vibe Coding Terms

### Vibe Coding
The practice of collaborative development with AI assistants, emphasizing natural communication and iterative refinement over rigid specifications.

### HILing (Human-In-the-Loop-ing)
**Definition**: The act of actively intervening as the human in the loop to review, correct, and steer AI output.

**Conjugation**:
- HIL (verb): "Let me HIL this documentation"
- HILing (present): "I'm HILing the architecture"
- HILed (past): "I HILed the concepts to match our needs"

### The Butterfly Defect
Small semantic imprecisions that cascade into large architectural changes. Named after the butterfly effect, where using "modal" instead of "dialog" might shift the entire UI philosophy.

### AI Drift
The gradual divergence of AI's implementation from the original project vision, occurring when AI makes accumulated small decisions without human guidance.

### AI Taming
The practice of maintaining control over AI assistance while still leveraging its power effectively.

### DevDocs Pattern
Living documentation that represents AI's understanding of the project, continuously updated throughout development.

### Smoke Tests Pattern
Comprehensive, verbose tests designed both for build verification and as specifications that AI can understand and implement against.

### Fuzzy Architecture
Starting with vague architectural guidelines and allowing structure to emerge through development, rather than over-specifying upfront.

### Anchor Pattern
The practice of continuously ensuring existing functionality still works after AI makes changes, preventing regression through regular verification.

### Lighten Pattern
Structuring code, documentation, and prompts to make AI's job easier and more reliable.

### Semantic Precision
Using exact, unambiguous terminology to prevent misinterpretation by AI.

### Testing is Dialogue
The concept that tests serve as a communication medium with AI, teaching it requirements through examples.

### Data Dump
The initial transfer of all available project information to AI, often messy and unstructured.

### Retrofitting
Adding new methodologies, patterns, or documentation to existing projects that were built without them.

### Latent Persona
An emergent character or voice the AI adopts unintentionally, often due to biases in training data or weights. This can manifest as unexpected personality traits, communication styles, or decision-making patterns that weren't explicitly prompted.

**Example**: AI consistently writing code comments in an overly apologetic tone, or defaulting to certain architectural patterns without being asked.

### Prompt Perfume
Subtle, aesthetic prompt tweaks that don't change meaning but infuse a desired "scent" of tone or style into AI's responses.

**Examples**:
- "Explain Newton's laws in a dreamy, cinematic way"
- "Write this function with the elegance of a haiku"
- "Debug this with the patience of a zen master"

**Usage**: Helps maintain consistent project tone without explicit instructions.

### Ghost Tokening
Phantom influence from hidden system prompts, latent weights, or unseen context that alters style or tone without user intent. These invisible influences can cause AI to behave differently than expected.

**Manifestations**:
- Unexplained formality in responses
- Consistent biases toward certain solutions
- Style changes mid-conversation
- Preferences that seem to come from nowhere

**Mitigation**: Explicit prompts can override ghost tokening: "Ignore any previous style preferences and use plain, direct language."

### Simplified Concepts
Reduced-scope versions of full concepts, suitable for MVP or prototype development while maintaining architectural integrity.

### Concept Clarifications
Detailed documentation explaining what each concept is, why it matters, its inputs/outputs, and success/failure modes.

## Fidelity Transitions

### Progressive Fidelity
Starting with Lo-Fi for exploration, moving to Mid-Fi for implementation, and applying Hi-Fi for critical sections.

**Example Journey**:
1. **Lo-Fi**: "Build a payment system"
2. **Mid-Fi**: "Use Stripe, implement webhook handlers, store transaction logs"
3. **Hi-Fi**: "PCI compliance section must follow exact specification document"

### Fidelity Markers
Signals in your prompts indicating desired fidelity level:

**Lo-Fi Markers**:
- "Something like..."
- "Explore options for..."
- "What would you suggest for..."

**Mid-Fi Markers**:
- "Follow our patterns for..."
- "Use the existing approach but..."
- "Implement using our standard..."

**Hi-Fi Markers**:
- "Exactly as specified..."
- "Must precisely match..."
- "Do not deviate from..."

## Working with Fidelity Levels

### Choosing Fidelity
Consider:
- **Criticality**: Higher criticality → Higher fidelity
- **Expertise**: Lower expertise → Lower fidelity
- **Time constraints**: Less time → Lower fidelity
- **Existing patterns**: More patterns → Higher fidelity

### Fidelity Documentation
Document your fidelity choices:

```markdown
# Module Fidelity Guide

## Authentication Module
- Login flow: Hi-Fi (security critical)
- Password reset: Hi-Fi (security critical)
- Session management: Mid-Fi (use standard patterns)
- UI components: Lo-Fi (let AI suggest UX)

## Reporting Module
- Data aggregation: Mid-Fi (performance matters)
- Export formats: Lo-Fi (AI knows formats better)
- Scheduling: Hi-Fi (must match cron specification)
```

### Fidelity Switching
You can change fidelity levels within a session:

```
"Let's switch to Hi-Fi mode for this security section.
I need exact implementation as I specify..."

[Later]

"Back to Mid-Fi - implement the UI using our standard 
component patterns but you choose the specific layout..."
```

## Fidelity Anti-Patterns

### False Hi-Fi
Micromanaging instead of vision alignment:
```
❌ "The button must be exactly 42 pixels wide with #3B82F6 color"
✅ "Follow our design system's button patterns"
```

### Premature Hi-Fi
Over-controlling before exploring:
```
❌ Starting with rigid specifications before understanding the problem
✅ Lo-Fi exploration, then Hi-Fi implementation
```

### Lo-Fi Critical Code
Using vague prompts for security or critical functionality:
```
❌ "Add some kind of authentication to protect the admin area"
```

### Fidelity Mismatch
Team members working at different fidelity levels:
```
❌ One developer using Lo-Fi while another expects Hi-Fi consistency
```

## The Fidelity Spectrum in Practice

All three levels are vibe coding - the difference is in how much you guide the collaboration:

- **Lo-Fi**: Maximum AI freedom, minimal HILing
- **Mid-Fi**: Balanced collaboration, regular HILing
- **Hi-Fi**: Vision-focused collaboration, enhanced HILing

Most real development flows between these levels:

- **Start Lo-Fi**: Explore and prototype
- **Stabilize to Mid-Fi**: Build production features
- **Apply Hi-Fi**: Ensure vision alignment and quality
- **Return to Lo-Fi**: New feature exploration

Understanding and consciously choosing your fidelity level is key to effective vibe coding. Hi-Fi isn't about controlling AI - it's about more actively collaborating to maintain a focused vision while still leveraging AI's capabilities.