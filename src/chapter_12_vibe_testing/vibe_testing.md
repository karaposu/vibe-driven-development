
# Vibe Testing (Not finished yet)

Before writing tests, understand what exists, what to test, and what's needed to test correctly. 

---

## Phase 1: Codebase Understanding

Understand structure before mapping details.

### Prompt Template

```
Scan the codebase and identify:

1. External Dependencies
   - All external API calls (LLM providers, third-party services)
   - Database connections and operations
   - File system operations
   - Network/HTTP operations

2. Major Internal Modules
   - List each module/package
   - Identify its primary responsibility
   - Note its dependencies on other modules

3. Architectural Pattern Analysis
   - What pattern is in use? (hexagonal, layered, clean, etc.)
   - Where are the boundaries? (ports, adapters, interfaces)
   - What is core logic vs infrastructure?

Put this analysis in devdocs/testing/plan/phase1_codebase_understanding.md

Focus on structure only. No operation details yet.
```

### Expected Output

```markdown
# Phase 1: Codebase Understanding

## External Dependencies
| Dependency | Type | Location |
|------------|------|----------|
| OpenAI API | LLM Provider | adapters/llm/ |
| PostgreSQL | Database | adapters/storage/ |
| Redis | Cache | adapters/cache/ |

## Internal Modules
| Module | Responsibility | Depends On |
|--------|---------------|------------|
| core/ | Business logic | ports/ |
| adapters/ | External integrations | (external) |
| ports/ | Interfaces | (none) |

## Architecture
- Pattern: Hexagonal
- Core: core/
- Ports: ports/
- Adapters: adapters/
- Boundaries: All external access through adapters
```

---

## Phase 2: Operation Mapping

Comprehensive identification of all operations. This needs depth.

### Prompt Template

```
Based on the codebase understanding from phase1, create a comprehensive operation map.

For EACH operation in the codebase:

1. Operation Identification
   - Name and location
   - What it does (one sentence)
   - Input → Output

2. Sub-operations
   - What operations does this depend on?
   - What operations depend on this?

3. Architectural Layer
   - pure logic / adapter / port / core integration
   - Can this be tested in isolation?

4. Coupling Analysis
   - Is this truly isolated?
   - Or does it only make sense composed with other operations?

Put this in devdocs/testing/plan/phase2_operation_mapping.md

Be comprehensive. Every operation matters.
```

### Expected Output

```markdown
# Phase 2: Operation Mapping

## Operations Inventory

### LLM Operations
| Operation | Location | Does | Layer | Isolated? |
|-----------|----------|------|-------|-----------|
| send_prompt | adapters/llm/openai.py | Sends prompt to OpenAI | Adapter | Yes |
| parse_response | adapters/llm/parser.py | Extracts structured data | Pure logic | Yes |
| agent_decide | core/agent.py | LLM + tools + state | Core | No - coupled |

### Storage Operations
| Operation | Location | Does | Layer | Isolated? |
|-----------|----------|------|-------|-----------|
| save_session | adapters/storage/pg.py | Persists session | Adapter | Yes |
| ... | ... | ... | ... | ... |

## Dependency Graph
```
agent_decide
├── send_prompt
├── parse_response
├── tool_executor
│   └── (various tools)
└── state_manager
    └── save_session
```

## Coupling Groups
Operations that must be tested together:
- Group 1: agent_decide + send_prompt + parse_response (agent loop)
- Group 2: ...
```

---

## Phase 3: Concept Mapping

Test abstract qualities, not just operations.

### Prompt Template

```
Identify concepts that need testing beyond individual operations.

1. Performance Concepts
   - Response time requirements
   - Throughput expectations
   - Resource usage limits

2. Architecture Concepts
   - Are boundaries respected?
   - Is core independent of adapters?
   - Are ports properly abstracted?

3. Reliability Concepts
   - Error recovery
   - Retry behavior
   - Graceful degradation

4. Data Concepts
   - Data integrity across operations
   - Transformation correctness
   - State consistency

5. Security Concepts
   - Authentication boundaries
   - Authorization checks
   - Data isolation

Put this in devdocs/testing/plan/phase3_concept_mapping.md

For each concept, note:
- What does "correct" look like?
- How would we know if it's broken?
- What operations are involved?
```

### Expected Output

```markdown
# Phase 3: Concept Mapping

## Performance Concepts
| Concept | Correct Looks Like | Broken Looks Like | Operations Involved |
|---------|-------------------|-------------------|---------------------|
| LLM Response Time | < 5s for simple queries | > 10s or timeout | send_prompt, parse_response |
| DB Write Speed | < 100ms per write | > 500ms | save_session, save_message |

## Architecture Concepts
| Concept | Correct | Broken | How to Verify |
|---------|---------|--------|---------------|
| Core Independence | core/ imports only from ports/ | core/ imports from adapters/ | Import analysis |
| Adapter Isolation | Adapters don't know about each other | Cross-adapter imports | Dependency check |

## Reliability Concepts
| Concept | Correct | Broken | Test Approach |
|---------|---------|--------|---------------|
| LLM Retry | 3 retries on timeout, then fail gracefully | Crash on first failure | Kill connection mid-request |
| DB Reconnect | Auto-reconnect after connection drop | Permanent failure | Restart DB during test |

## Data Concepts
| Concept | Correct | Broken | Test Approach |
|---------|---------|--------|---------------|
| Session Integrity | All messages in order | Missing or duplicated messages | Concurrent write test |
| State Consistency | State reflects all operations | Stale or partial state | Crash recovery test |

## Security Concepts
| Concept | Correct | Broken | Test Approach |
|---------|---------|--------|---------------|
| User Isolation | User A cannot see User B data | Data leakage | Cross-user query test |
```

---

## Phase 4: Test Requirements Document

What's needed for tests to be meaningful.

### Prompt Template

```
Based on the operations and concepts identified, document what's required for correct testing.

1. Real Data Requirements
   - What real files are needed? (videos, images, documents)
   - What format and specifications?
   - Where should they be located?

2. External Service Requirements
   - What services must be running?
   - What credentials are needed?
   - Can we use sandboxed/test versions?

3. Environment Requirements
   - Minimum hardware specs
   - Required environment variables
   - Network access needs

4. Test Data Specifications
   - What edge cases must be covered?
   - What data variations are needed?
   - Sample data schemas

5. State Requirements
   - What must exist before tests run?
   - Database seeds needed?
   - Files that must be present?

Put this in devdocs/testing/plan/requirements_for_correct_testing.md

Without these requirements met, tests pass but prove nothing.
```

### Expected Output

```markdown
# Requirements for Correct Testing

## Real Data Requirements

### Video Files
| Requirement | Specification | Location | Purpose |
|-------------|--------------|----------|---------|
| Test video | MP4, 10MB, 30s, 720p | tests/fixtures/video/ | Video processing tests |
| Corrupt video | MP4 with broken headers | tests/fixtures/video/ | Error handling tests |
| Large video | MP4, 500MB | tests/fixtures/video/ | Performance tests |

### Documents
| Requirement | Specification | Location | Purpose |
|-------------|--------------|----------|---------|
| PDF samples | Various sizes, 1-100 pages | tests/fixtures/docs/ | Document parsing |
| Unicode text | UTF-8 with emojis, RTL text | tests/fixtures/docs/ | Encoding tests |

## External Service Requirements

| Service | Required For | Test Version Available? | Credentials |
|---------|-------------|------------------------|-------------|
| OpenAI API | LLM tests | No - use real with low quota | OPENAI_API_KEY |
| PostgreSQL | Storage tests | Yes - Docker container | tests/docker-compose.yml |
| Redis | Cache tests | Yes - Docker container | tests/docker-compose.yml |

## Environment Requirements

| Requirement | Minimum | Recommended | Notes |
|-------------|---------|-------------|-------|
| RAM | 4GB | 8GB | For load tests |
| Disk | 2GB free | 10GB free | For video fixtures |
| Network | Internet access | Low latency | For LLM API calls |

### Environment Variables
```bash
# Required for all tests
DATABASE_URL=postgresql://test:test@localhost:5432/test
REDIS_URL=redis://localhost:6379

# Required for LLM tests
OPENAI_API_KEY=sk-...

# Optional
LOG_LEVEL=DEBUG
TEST_TIMEOUT=30
```

## Test Data Specifications

### User Data Edge Cases
Must test with:
- [ ] Empty username
- [ ] Unicode username (日本語, العربية)
- [ ] Maximum length username (255 chars)
- [ ] Special characters (!@#$%^&*)
- [ ] SQL injection attempts
- [ ] XSS attempts

### Session Data
Must include:
- [ ] Empty session
- [ ] Session with 1 message
- [ ] Session with 1000 messages
- [ ] Session with large attachments
- [ ] Corrupted session data

## Pre-Test State Requirements

### Database
```sql
-- Must exist before tests
CREATE DATABASE test_db;

-- Seed data required
INSERT INTO users (id, name) VALUES ('test-user', 'Test User');
```

### File System
```
tests/
├── fixtures/
│   ├── video/
│   │   └── (required video files)
│   ├── docs/
│   │   └── (required document files)
│   └── data/
│       └── (required JSON/CSV files)
└── tmp/
    └── (writable directory for test outputs)
```

## Checklist Before Running Tests

- [ ] Docker containers running (PostgreSQL, Redis)
- [ ] Environment variables set
- [ ] Test fixtures present
- [ ] Network access available
- [ ] Sufficient disk space
- [ ] API keys valid and have quota
```

---

## Test Types Summary

After completing phases 1-4, you understand:

| What | Phase | Produces |
|------|-------|----------|
| Structure | Phase 1 | Codebase map |
| Operations | Phase 2 | What to test mechanically |
| Concepts | Phase 3 | What to test abstractly |
| Requirements | Phase 4 | What's needed to test correctly |

Now you can create two types of tests:

### Probe Tests (Discovery)
- Used during development
- Human observed, verbose output
- Establishes "what works"
- Teaches you how the system behaves

### CI/CD Tests (Reliability)
- Automated, runs on every commit
- Pass/fail gates
- Maintains "what must keep working"
- Codified knowledge from probe tests

```
Phase 1-4 → Understand what to test
     ↓
Probe Tests → Discover what works, learn behavior
     ↓
Codify → Turn discoveries into CI/CD tests
     ↓
CI/CD Tests → Maintain reliability over time
```
