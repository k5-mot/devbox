# Backend Development Guide

## Project Structure

### Python Template (`python-template`)
- **Framework**: FastAPI
- **Python Version**: 3.12+ (3.14 recommended)
- **Package Manager**: uv
- **Main Use Cases**: REST API, microservices, LangChain applications

## Technology Stack

### Language & Runtime
- **Python**: 3.12+
- **FastAPI**: 0.126.0+
- **Uvicorn**: ASGI server

### Package Manager
- **uv**: Fast Python package manager (implemented in Rust)
- Lock file: Always commit `uv.lock`
- Configuration file: `pyproject.toml`

### Code Quality Tools
- **Linter/Formatter**: Ruff 0.14.10+ (implemented in Rust, fast)
- **Type Checker**: Pyright (basic mode)
- **Test Framework**: pytest 9.0+
- **Coverage**: pytest-cov

### Major Libraries
- **boto3**: AWS SDK
- **LangChain**: LLM application development
- **Pydantic**: Data validation and settings management
- **python-dotenv**: Environment variable management

## Development Workflow

### Initial Setup
```bash
cd python-template
uv sync                  # Install dependencies
```

### Virtual Environment
- uv automatically manages `.venv` directory
- Persisted with volume mount

### Start Dev Server
```bash
uv run uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

### Task Runner (poethepoet)
```bash
# Format
uv run poe format

# Lint
uv run poe lint

# Type check
uv run poe type

# Run tests
uv run poe test

# Run all checks
uv run poe check
```

### Manual Execution
```bash
# Format with Ruff
uv run --no-env-file -- ruff format .

# Lint with Ruff
uv run --no-env-file -- ruff check --fix .

# Type check with Pyright
uv run --no-env-file -- pyright --project .

# Test with pytest
uv run --no-env-file -- pytest -q --junitxml=coverage/junit.xml --cov=. --cov-report=xml:coverage/coverage.xml --cov-report=html:coverage/coverage_html
```

## Coding Conventions

### File Structure
```
src/
├── mypack/          # Main package
│   ├── __init__.py
│   ├── api/         # API endpoints
│   ├── models/      # Data models (Pydantic)
│   ├── services/    # Business logic
│   ├── utils/       # Utility functions
│   └── config.py    # Configuration management
tests/
├── __init__.py
└── test_*.py        # Test files
main.py              # Entry point
```

### Naming Conventions
- **Modules/Packages**: snake_case (`user_service.py`)
- **Classes**: PascalCase (`UserService`)
- **Functions/Variables**: snake_case (`get_user`, `user_id`)
- **Constants**: UPPER_SNAKE_CASE (`API_VERSION`)
- **Private**: Leading underscore (`_internal_method`)

### Ruff Configuration
- **Line length**: 88 characters
- **Indent**: 4 spaces
- **Quotes**: Double quotes
- **Line ending**: LF
- **Docstring**: Google style
- **Complexity**: Max 10 (McCabe)

### Lint Rules
- **Enabled**: Almost all rules (`select = ["ALL"]`)
- **Disabled**: 
  - `AIR`, `EXE`, `ERA`: Specific use cases
  - `COM812`: Conflicts with Ruff formatter
  - `CPY`, `NPY`, `PD`: Not needed for project
  - `D100`, `D104`: Module/package docstrings
  - `D400`, `D415`: Docstring punctuation
  - `D203`, `D213`: Docstring style

### Test File Special Rules
- `S101`: Allow assert usage
- `ARG`: Allow unused arguments (fixtures)
- `FBT`: Allow boolean arguments
- `PLR2004`: Allow magic numbers
- `S311`: Allow non-crypto random

## Type Annotations

### Basic Principles
- Add annotations to all functions
- Pyright in `basic` mode (not too strict, not too loose)

### Examples
```python
from typing import Optional, List, Dict
from pydantic import BaseModel

class User(BaseModel):
    id: int
    name: str
    email: Optional[str] = None

def get_users(limit: int = 10) -> List[User]:
    """Get list of users."""
    ...

async def create_user(user: User) -> Dict[str, str]:
    """Create a user."""
    ...
```

## FastAPI Development

### API Endpoints
```python
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

class Item(BaseModel):
    name: str
    price: float

@app.post("/items/")
async def create_item(item: Item):
    """Create an item."""
    return {"name": item.name, "price": item.price}

@app.get("/items/{item_id}")
async def read_item(item_id: int):
    """Get an item."""
    if item_id < 0:
        raise HTTPException(status_code=404, detail="Item not found")
    return {"item_id": item_id}
```

### Automatic Documentation
- Swagger UI: `http://localhost:8000/docs`
- ReDoc: `http://localhost:8000/redoc`
- OpenAPI JSON: `http://localhost:8000/openapi.json`

### Settings Management
```python
from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    api_key: str
    database_url: str
    
    class Config:
        env_file = ".env"

settings = Settings()
```

## Testing Strategy

### Test File Naming
- `test_*.py` or `*_test.py`
- Test classes: `Test*`
- Test functions: `test_*`

### Using pytest
```python
import pytest

def test_addition():
    """Test addition."""
    assert 1 + 1 == 2

@pytest.fixture
def sample_user():
    """Sample user fixture."""
    return {"id": 1, "name": "Test User"}

def test_user_creation(sample_user):
    """Test user creation."""
    assert sample_user["name"] == "Test User"

@pytest.mark.asyncio
async def test_async_function():
    """Test async function."""
    result = await some_async_function()
    assert result is not None
```

### Using Mocks
```python
from pytest_mock import MockerFixture

def test_with_mock(mocker: MockerFixture):
    """Test with mock."""
    mock_api = mocker.patch("mypack.api.external_api_call")
    mock_api.return_value = {"status": "success"}
    
    result = call_function_that_uses_api()
    assert result["status"] == "success"
```

### Coverage
- Target: 80%+
- Report: `coverage/coverage_html/index.html`
- CI/CD: Output XML format report

## Environment Variable Management

### .env File
```env
# .env (gitignored)
API_KEY=your-api-key
DATABASE_URL=postgresql://user:pass@localhost/db
DEBUG=true
```

### .env.example
```env
# .env.example (committed)
API_KEY=
DATABASE_URL=
DEBUG=false
```

### Pydantic Settings
```python
from pydantic_settings import BaseSettings, SettingsConfigDict

class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8")
    
    api_key: str
    database_url: str
    debug: bool = False
```

## LangChain Integration

### Basic Example
```python
from langchain_aws import ChatBedrock
from langchain_core.messages import HumanMessage

llm = ChatBedrock(
    model_id="anthropic.claude-3-sonnet-20240229-v1:0",
    region_name="us-west-2"
)

messages = [HumanMessage(content="Hello, Claude!")]
response = llm.invoke(messages)
```

## Error Handling

### FastAPI Exceptions
```python
from fastapi import HTTPException, status

@app.get("/users/{user_id}")
async def get_user(user_id: int):
    user = find_user(user_id)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )
    return user
```

### Custom Exceptions
```python
class UserNotFoundError(Exception):
    """Exception when user not found."""
    pass

@app.exception_handler(UserNotFoundError)
async def user_not_found_handler(request, exc):
    return JSONResponse(
        status_code=404,
        content={"message": str(exc)}
    )
```

## Logging

### Basic Configuration
```python
import logging

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s - %(name)s - %(levelname)s - %(message)s"
)

logger = logging.getLogger(__name__)

logger.info("Application started")
logger.error("Error occurred", exc_info=True)
```

## Debugging

### VSCode Debugger
- Configure with `launch.json`
- Breakpoints, variable watch

### print vs logging
- Development: `logger.debug()`
- Production: `logger.info()`, `logger.error()`
- `print()` prohibited (except in tests)

## Performance Optimization

### Async Processing
```python
import asyncio

async def fetch_data():
    """Fetch data asynchronously."""
    async with httpx.AsyncClient() as client:
        response = await client.get("https://api.example.com/data")
        return response.json()

# Parallel execution
results = await asyncio.gather(fetch_data(), fetch_data())
```

### Caching
```python
from functools import lru_cache

@lru_cache(maxsize=128)
def expensive_computation(n: int) -> int:
    """Cache expensive computation."""
    return sum(i for i in range(n))
```

## Security

### Input Validation
- Auto-validation with Pydantic models
- SQL injection prevention: Use ORM or parameterized queries

### Authentication & Authorization
```python
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPBearer

security = HTTPBearer()

async def verify_token(credentials = Depends(security)):
    """Verify token."""
    token = credentials.credentials
    if not is_valid_token(token):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid token"
        )
    return token
```

## CI/CD Integration

### Pre-commit hooks
- Ruff format
- Ruff lint
- Pyright type check
- pytest execution

### GitLab CI/CD
- Configured in `.gitlab-ci.yml`
- Stages: build → test → deploy

## Troubleshooting

### uv sync errors
- Delete `uv.lock` and retry
- Verify Python version (3.12+)

### Type errors
- Verify with `uv run poe type`
- Minimize `# type: ignore` usage

### Test failures
- Show details with `uv run poe test -v`
- Environment variables: Create `.env.test` file

### Import errors
- Verify `src` directory in PYTHONPATH
- Check `pyproject.toml` `package-dir` configuration
