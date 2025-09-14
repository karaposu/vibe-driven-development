We have a bug in our code. Based on all information you know:

  1. List all modules/components/concepts potentially relevant to this bug, including:
  - Direct code modules involved in the execution path
  - System dependencies and libraries
  - Runtime environment factors (execution context, state persistence, caching)
  - Development environment factors (IDEs, notebooks, debuggers)
  - Configuration and initialization aspects
  - External factors (file system, network, permissions)
  - Programming language behaviors (scoping, defaults, type coercion)

  2. Once listed, based on the data gathered so far, identify:
  - Where the problem is DEFINITELY NOT (with concrete proof/evidence)
  - Where the problem MIGHT be (with reasoning)
  - What environmental or state-related factors could be influencing the behavior
  - Any assumptions we're making that should be validated"**


Fault Localization - Identifying which module/component is responsible
  3. Divide and Conquer Debugging - Systematically narrowing down the problem space
  4. Binary Search Debugging - Cutting the problem space in half repeatedly







  this is a common debugging blind spot. Here's what happened:

  When you trace a parameter through a codebase, there's a natural tendency to follow the "happy path" - the code branch you
  expect to execute. In this case:

  1. Cognitive bias toward recent changes: You mentioned using one_by_one=True in earlier examples, so my mental model was primed
   to look at that branch (lines 89-107) where the parameter WAS correctly passed.
  2. Incomplete code review pattern: When checking if a parameter is passed through, I should have systematically checked ALL
  branches that call the same method, not just the first one I found.
  3. Missing the forest for the trees: I was focused on tracing the parameter deep into ExtractHero's internals (looking at
  prompts, LLM services, etc.) instead of first verifying it was correctly passed at every call site in BrightSets.

  The generic lesson: When debugging parameter flow, always check ALL call sites first before diving deeper. It's like checking
  if a pipe is connected at both ends before investigating if there's a blockage in the middle.

  This is why systematic debugging (like your approach of adding logging at each layer) is superior to assumption-based
  debugging. The logs immediately showed the parameter was "json" not "markdown", which pointed directly to the problem.