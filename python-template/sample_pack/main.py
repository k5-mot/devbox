"""Main module."""

import logging

from .sample import sample

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def main() -> None:
    """Main entry point."""
    logger.info("Hello from api!")
    logger.info("Hello from devbox-python-template!")
    sample()


if __name__ == "__main__":
    main()
