# Database Folder Structure

## Overview
The database layer follows a standard repository pattern architecture with SQLAlchemy ORM, organizing code into models, repositories, and utilities for clean separation of concerns.

## Folder Structure

```
db/
├── __init__.py           # Package initialization
├── base.py              # SQLAlchemy declarative base definition
├── session.py           # Session factory and context managers
│
├── models/              # ORM model definitions
│   ├── __init__.py
│   ├── base.py         # Base model classes/mixins
│   └── *.py            # Individual model files (user, account, etc.)
│
├── repositories/        # Data access layer
│   └── *_repository.py # Repository classes for each entity
│
├── data/               # Database files (SQLite)
│   └── *.db           # Physical database files
│
└── scripts/            # Database utilities and maintenance
    ├── __init__.py
    ├── create_*.py     # Database initialization scripts
    ├── fill_*.py       # Data seeding scripts
    └── *.py            # Other utility scripts
```

## Component Descriptions

### Core Files

**base.py**
- Defines the SQLAlchemy declarative base
- Foundation for all ORM models
- Can include common mixins for timestamps, IDs, etc.

**session.py**
- Session factory implementation
- Context managers for transaction handling
- Session lifecycle management

### Models Directory
- Contains SQLAlchemy ORM model definitions
- Each model typically represents a database table
- Models define:
  - Table structure (columns, types)
  - Relationships between tables
  - Constraints and indexes
  - Business logic methods

### Repositories Directory
- Implements the Repository Pattern
- Each repository handles CRUD operations for specific entities
- Abstracts database queries from business logic
- Common methods:
  - `create()` - Insert new records
  - `get_by_id()` - Retrieve by primary key
  - `update()` - Modify existing records
  - `delete()` - Remove records
  - Custom query methods specific to entity

### Data Directory
- Contains actual database files (for file-based DBs like SQLite)
- May include:
  - Production databases
  - Test databases
  - Backup files

### Scripts Directory
- Database maintenance and utility scripts
- Common script types:
  - **create_*.py**: Initialize database schema
  - **fill_*.py**: Seed initial/sample data
  - **migrate_*.py**: Schema migration scripts
  - **sample_generator.py**: Generate test data
  - Maintenance utilities (backup, restore, cleanup)

## Architecture Patterns

### Repository Pattern
- Encapsulates data access logic
- Provides abstraction between domain and data mapping layers
- Makes testing easier through dependency injection
- Enables switching data sources without affecting business logic

### ORM Benefits
- Object-oriented interface to database
- Automatic SQL generation
- Database vendor independence
- Built-in connection pooling
- Transaction management

### Session Management
- Unit of Work pattern implementation
- Tracks object changes
- Handles transaction boundaries
- Ensures data consistency

## Best Practices

1. **Separation of Concerns**
   - Models define structure
   - Repositories handle queries
   - Business logic stays in service layer

2. **Database Agnostic**
   - Use ORM features instead of raw SQL when possible
   - Keep database-specific code isolated

3. **Transaction Management**
   - Use context managers for automatic commit/rollback
   - Keep transactions as short as possible

4. **Migration Strategy**
   - Version control schema changes
   - Use migration tools (Alembic for SQLAlchemy)
   - Test migrations in development first

5. **Testing**
   - Use separate test database
   - Mock repositories for unit tests
   - Use transactions for test isolation

## Common Model/Repository Patterns

- **user.py / user_repository.py**: User authentication and profile management
- **admin_*.py**: Administrative interface and privileged operations
- **report_*.py**: Analytics, reporting, and data aggregation
- **file_*.py**: File upload/storage management
- **log_*.py**: Audit trails and activity logging
- Domain-specific models based on application needs

## Dependencies
- SQLAlchemy (ORM framework)
- Database driver (sqlite3, psycopg2, pymysql, etc.)
- Optional: Alembic for migrations