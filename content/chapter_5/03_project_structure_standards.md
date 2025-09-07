# Project Structure Standards

## Why Structure Matters More with AI

Humans navigate codebases through memory and intuition. AI navigates through structure. Good structure = AI superpowers. Bad structure = AI confusion.

## The DevDocs Structure
DevDocs pattern is one of the most popular vibe pattern. Most vibe coders use it without knowing the name. 
it starts with adding devdocs folder inside the src folder. These documents are not like usual docs and they are part of the coding and part of the source code. 


```
project-src/
├── README.md           # Project overview
├── ground_rules.md     # AI instructions
├── requirements.md     # What we're building
├── devdocs/           # Development documentation
├── src/               # Source code
├-- smoke-tests/
```

And inside devdocs shoould look like this 

```
devdocs/
├── decisions/       # Architectural decisions
├── concepts/        # Feature clarifications
├── interfaces/      # Module contracts
└── explorations/    # Experiments and spikes
```


## The Code Layer

The code should be modular by Design. There is no one crystal standard here other than it should be decoupled by design. 
sth like this is usally good:

```
src/
├── core/           # Business logic
├── services/       # External integrations
├── utils/          # Shared utilities
├── models/         # Data structures
└── api/           # Interface layer
```



### Tests Together Strong

A Separate smoke-tests directory saves time when AI should run them. 
```
smoke-tests/
├── test_core/
├── test_services/
├── test_utils/
└── test_api/
```


## Language-Specific Structures

### Python Projects

```
project/
├── src/
│   └── myproject/      # Package name
│       ├── __init__.py
│       └── ...
├── tests/
├── requirements.txt    # Dependencies
├── setup.py           # Package setup
└── pyproject.toml     # Modern Python config
```

### JavaScript/TypeScript

```
project/
├── src/
│   ├── components/    # UI components
│   ├── services/      # Business logic
│   └── utils/         # Helpers
├── public/            # Static assets
├── package.json       # Dependencies
└── tsconfig.json      # TypeScript config
```

### Full-Stack Projects

```
project/
├── frontend/          # Client application
│   └── [framework structure]
├── backend/           # Server application
│   └── [framework structure]
├── shared/            # Common types/utils
└── docs/              # Unified documentation
```

## The Interface Pattern

Every module gets an interface file:

```
src/auth/
├── index.py          # Public interface
├── interface.md      # Contract documentation
├── implementation.py # Private implementation
└── tests.py         # Module tests
```

`interface.md` contains:
- What this module does
- What it needs (dependencies)
- What it provides (exports)
- How to use it

AI uses these for integration.


